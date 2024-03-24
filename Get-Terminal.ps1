Param ( # Input parameters
    [String]$Username,
    [switch]$withPass,
    [String]$Hostname,
    [Int]$Port,
    [string]$TermType
)

Function Get-Settings {
    If (Test-Path ".\settings.json") { 
        $Settings = Get-Content '.\settings.json' | Out-String | ConvertFrom-Json -AsHashtable 
    }
    Else {
        $Settings = @{}
    }
    return $Settings
}

$Params = @{} # Grab parameters to a hash table
foreach ($paramName in $PSBoundParameters.Keys) { 
    $Params[$paramName] = $PSBoundParameters[$paramName]
}


# $Settings = . .\Get-Settings.ps1 @Params        # Settings with Params
$Settings = Get-Settings # Settings 
$Credentials = . .\Get-Credentials.ps1 @Params    # Credentials with Params

If ($PSBoundParameters.ContainsKey('Hostname') -eq $true) { 
    $Settings.hostname = $Hostname 
}


switch ($TermType) { 
    "Putty" {
        # PuTTY
        if ($PSBoundParameters.ContainsKey('Port') -eq $true) {
            If ($null -eq $Settings.ssh.port) {
                $Settings.Add("ssh", @{ "port" = $Port })
            }
            Else {
                $Settings.ssh.port = $Port
            }
        }
        # putty.exe -ssh -P %port% %pw% %user%@%host%
        $puttyPath = "putty.exe"
        try {
            $localCommand = $puttyPath + " -ssh -P " + $Settings.ssh.port + " -pw " + $(ConvertFrom-SecureString -SecureString $Credentials.Password -AsPlainText) + " " + $Credentials.Username + "@" + $Settings.hostname
        }
        catch {
            $localCommand = $puttyPath + " -ssh -P " + $Settings.ssh.port + " " + $Credentials.Username + "@" + $Settings.hostname
        }
    }
    "Serial" {
        Write-Host "Wybrano opcję Serial"
        $Serial = @{
            port   = "com1"
            speed  = 9600
            data   = 8
            parity = 1
        }
        If ($null -eq $Settings.serial.port) {
            $Settings.Add("serial", $Serial);
        }
        $localCommand = "putty.exe -serial " + $Settings.serial.port
    }
    Default {
        Write-Host "Nieprawidłowa opcja"
        # Tutaj umieść kod obsługujący przypadki nieprawidłowej opcji
    }
}

$Settings | ConvertTo-Json | Out-File "settings.json"
Write-Output $localCommand
Invoke-Expression($localCommand)