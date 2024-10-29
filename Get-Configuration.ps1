Param (  # Parameters
    [String]$Hostname, # -Hostname fqdn.example.com
    [String]$Username, # -Username username
    [switch]$nopass
)

. $PSScriptRoot\scripts\SettingsManager.ps1

$System = [SettingsManager]::new()
$Credentials = [CredentialsManager]::new()

#plinkCmd
$plinkCmd = "plink.exe -batch"
$plinkCmd += " -P " + $System.Settings.Get("Port")
if(-not $nopass){
$plinkCmd += " -pw " + $Credentials.GetPassword()
}
$plinkCmd += " " + $Credentials.GetUsername() + "@" + $System.Settings.Get("Hostname")

$getConfigurationCmd = $plinkCmd + " -m " +$PSScriptRoot+ "\scripts\" + $System.Settings.Get("System") + "\configuration.sh"
Write-Output $getConfigurationCmd
Invoke-Expression -Command $getConfigurationCmd | Out-File -FilePath "configuration.txt"
$getCommandsCmd = $plinkCmd + " -m " +$PSScriptRoot+ "\scripts\" + $System.Settings.Get("System") + "\commands.sh"
Write-Output $getCommandsCmd
Invoke-Expression -Command $getCommandsCmd | Out-File -FilePath "commands.txt"

$System.Save()
$Credentials.Save()