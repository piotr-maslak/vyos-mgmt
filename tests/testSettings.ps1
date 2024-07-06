# Tests Settings
. .\SettingsManager.ps1

$CredMgr1 = [CredentialsManager]::new("settings\credentials.json")
$CredMgr2 = [CredentialsManager]::new("settings\credentials2.json")
$SetMgr2 = [SettingsManager]::new("settings\serial.json")
$SetMgr3 = [SettingsManager]::new("settings\ssh.json")

Write-Host $SetMgr3.Settings.Get("Hostname") -ForegroundColor Blue
Write-Host $SetMgr3.Settings.Get("Port") -ForegroundColor Blue
Write-Host $CredMgr1.GetUsername() -ForegroundColor Green
if($CredMgr1.GetPassword() -eq ""){
    Write-Host "nic" -ForegroundColor Red
}else{
    Write-Host $CredMgr1.GetPassword() -ForegroundColor Cyan
}

# --------------------------------------------

# Utworzenie obiektu Settings z hashtable
# Write-Error "Sets"
# $host1 = @{
#     Hostname = "rtr1.hp1.self.maslak.waw.pl"
#     Ssh      = @{
#         Port = "54398"
#     }
#     Serial   = @{
#         port   = "com1"
#         speed  = 9600
#         data   = 8
#         parity = 1
#     }
# }
# $Sets = [Settings]::new($host1)
#Write-Output $Sets | ConvertTo-Json -Depth 1


# Utworzenie obiektu Settings Manager
# Write-Error "SetMgr"
# $SetMgr = [SettingsManager]::new("settings.json")
# # $SetMgr = [SettingsManager]::new
# # Dodanie lub aktualizacja ustawień
# $SetMgr.Settings.Init(@{Hostname = "rtr1.hp1.self.maslak.waw.pl"})
# $SetMgr.Settings.Init(@{Ssh = @{Port = "54398"}})

# Write-Output $SetMgr.Settings  | ConvertTo-Json -Depth 1

# Write-Output $Sets
# Write-Output $SetMgr.Settings
# $test=$SetMgr.Settings.Get("Credentials")
# Write-Output $test | ConvertTo-Json -Depth 1

# Write-Output $SetMgr.GetSettings() | ConvertTo-Json -Depth 5
# $SetMgr.Settings.Set("Test2", "Test2")
# $SetMgr.Settings.Get("Test3")

# # Dodanie właściwości do zbioru settings poprzez zmienną Sets2
# Write-Error "Sets2"
# $Sets2 = $SetMgr.Settings;
# $Sets2.Set("Test3", "321")
# $SetMgr.Settings = $Sets2

# try {
#     $SetMgr.Settings.Test1 = "abc"
# }
# catch {
#     Write-Error "no property"
# }

# Write-Output $SetMgr.Settings.Serial.speed
# $SetMgr.Settings.Serial.speed = 115200
# Write-Output $SetMgr.Settings.Serial.speed

# # Zapisanie ustawień do pliku
# $SetMgr.SaveSettings()