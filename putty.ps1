[CmdletBinding()]
Param (
    [String]$Username,
    [Int]$Port,
    [String]$Hostname
)

If (Test-Path ".\settings.json") { $Settings = Get-Content '.\settings.json' | Out-String | ConvertFrom-Json }
Else {
    $Settings = @{
        hostname = "";
        ssh      = [PSCustomObject] @{
            port = "22"
        };
        # serial   = [PSCustomObject] @{
        #     port   = "com1"
        #     speed  = 9600
        #     data   = 8
        #     parity = 1
        # }
    }
}

If ($Hostname -ne "") { $Settings.hostname = $Hostname }
Elseif ($Settings.hostname -eq "") { $Settings.hostname = Read-Host "Please enter hostname" }
If ($Port -ne "") { $Settings.ssh.port = "$Port" }

$puttyPath = "putty.exe"

If (Test-Path ".\credentials.xml") {
    $Credentials = Import-CliXml -Path 'credentials.xml'

}Else {
    $Credentials = $host.ui.PromptForCredential("Need credentials", "Please enter your user name and password.", $username,"")
    $Credentials | Export-CliXml -Path 'credentials.xml'
}


$p = ConvertFrom-SecureString -SecureString $Credentials.Password -AsPlainText
# putty.exe -ssh -P %port% %pw% %user%@%host%
$localCommand = $puttyPath + " -ssh -P " + $Settings.ssh.port + " -pw "+ $p + " "+$Credentials.Username+"@" + $Settings.hostname

# $a = @{
#      serial = [PSCustomObject] @{
#          port = "com2"
#          speed = "9600"
#          data = 8
#      }
#  }

#$Settings.ssh.port = "22"
#$Settings.serial.port = "com3"
$Settings | ConvertTo-Json | Out-File "settings.json"

#Get-Content "settings.ini" | foreach-object -begin { $h=@{} } -process { $k = [regex]::split($_,’=’); if(($k[0].CompareTo(“”) -ne 0)     -and ($k[0].StartsWith(“[“) -ne $True)) { $h.Add($k[0], $k[1]) } }

Write-Output $localCommand
#$result = Invoke-Expression($localCommand)