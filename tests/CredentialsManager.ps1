. .\SettingsManager.ps1

$CredTest1 = [CredentialsManager]::new()
$CredTest1.GetUsername()
$CredTest1.GetPassword()

# $CredTest2 = [Credentials]::new("user1234")
# $CredTest2.GetUsername()
# $CredTest2.GetPassword()

# Write-Output $CredTest1, $CredTest2

# $CredMgr = [CredentialManager]::new()
# Write-Output $CredMgr.Credentials.GetUsername()
# $CredMgr.Save()

# $CredMgr2 = [CredentialManager]::new("credential\credential.xml")
# Write-Output $CredMgr2.Creds.GetUsername()
# $CredMgr2.SaveCreds()