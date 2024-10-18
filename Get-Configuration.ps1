Param (  # Parameters
    [String]$Hostname, # -Hostname fqdn.example.com
    [String]$Username # -Username username
)

. .\include-scripts\SettingsManager.ps1
$System = [SettingsManager]::new()
$Credentials = [CredentialsManager]::new()



$getConfigurationCmd = "plink.exe -batch -P " + $System.Settings.Get("Port") + " -pw " + $Credentials.GetPassword() + " " + $Credentials.GetUsername() + "@" + $System.Settings.Get("Hostname") +" -m include-scripts\" + $System.Settings.Get("System")+ "\configuration.sh"
$getCommandsCmd = "plink.exe -batch -P " + $System.Settings.Get("Port") + " -pw " + $Credentials.GetPassword() + " " + $Credentials.GetUsername() + "@" + $System.Settings.Get("Hostname") +" -m include-scripts\" + $System.Settings.Get("System")+ "\commands.sh"
Write-Output $getConfigurationCmd
Write-Output $getCommandsCmd
Invoke-Expression -Command $getConfigurationCmd | Out-File -FilePath "configuration.txt"
Invoke-Expression -Command $getCommandsCmd | Out-File -FilePath "commands.txt"
$System.Save()
$Credentials.Save()