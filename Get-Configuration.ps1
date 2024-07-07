Param (  # Parameters
    [String]$Hostname, # -Hostname fqdn.example.com
    [String]$Username # -Username username
)

. .\SettingsManager.ps1
$System = [SettingsManager]::new()
$Credentials = [CredentialsManager]::new()

# Leave this block as it contains Check Hostname Parameter 
# If ($Params.ContainsKey('Hostname') -eq $true) {
#     $Settings.hostname = $Hostname 
# }

# If ($Params.ContainsKey('Port') -eq $true) {
#         $Settings.ssh.port = $Port
# }

# putty.exe -ssh -P %port% %pw% %user%@%host%
# plink -batch -P %port% %pw% %user%@%host% -m %scrpath%\configuration.sh > %date%-configuration.cfg

# try {
$localCommand = "plink.exe -batch -P " + $System.Settings.Get("Port") + " -pw " + $Credentials.GetPassword() + " " + $Credentials.GetUsername() + "@" + $System.Settings.Get("Hostname") +" -m include-scripts\" + $System.Settings.Get("System")+ "\configuration.sh"
# }
# catch {
#     $localCommand = $puttyPath + " -ssh -P " + $Settings.ssh.port + " " + $Credentials.Username + "@" + $Settings.hostname
# }


$Settings | ConvertTo-Json | Out-File "settings.json"
Write-Output $localCommand
Invoke-Expression -Command $localCommand | Out-File -FilePath "configuration.txt"

