. .\SettingsManager.ps1

$CredTest = [CredentialsManager]::new()
$CredTest.GetUsername()
$CredTest.GetPassword()
$CredTest.Save()