Param (  # Parameters
    [String]$Username, # -Username abcdef
    [switch]$withPass, # -withPass true / false
    [String]$Hostname, # -Hostname fqdn.example.com
    [Int]$Port,        #
    [string]$TermType
)

# $Params = @{} # Grab parameters to a hash table
# foreach ($paramName in $PSBoundParameters.Keys) { 
#     $Params[$paramName] = $PSBoundParameters[$paramName]
# }

. .\include\Functions.ps1
$Settings = Get-Settings # Settings 
$Credentials = Get-Credentials @Params # Credentials (with parameters splatting)

If ($Params.ContainsKey('Hostname') -eq $true) {
    $Settings.hostname = $Hostname 
} Elseif ($Settings.hostname -eq "") { 
    $Settings.hostname = Read-Host "Please enter hostname" 
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