Param (  # Parameters
    [String]$Hostname, # -Hostname fqdn.example.com
    [String]$Username # -Username username
)

. .\SettingsManager.ps1
$System = [SettingsManager]::new()
$Credentials = [CredentialsManager]::new()

$localCommand = "putty.exe -ssh -P " + $System.Settings.Get("Port") + " -pw " + $Credentials.GetPassword() + " " + $Credentials.GetUsername() + "@" + $System.Settings.Get("Hostname")
$Credentials.Save()
$System.Save()
Write-Output $localCommand
Invoke-Expression($localCommand)