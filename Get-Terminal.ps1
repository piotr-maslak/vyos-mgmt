Param (  # Parameters
    [String]$Hostname, # -Hostname fqdn.example.com
    [String]$Username # -Username username
)

. .\SettingsManager.ps1
$SSH = [SettingsManager]::new("settings/ssh.json")
$Credentials = [CredentialsManager]::new()

$localCommand = "putty.exe -ssh -P " + $SSH.Settings.Get("Port") + " -pw " + $Credentials.GetPassword() + " " + $Credentials.GetUsername() + "@" + $SSH.Settings.Get("Hostname")

Invoke-Expression($localCommand)