class Settings {
    # Kontruktor
    Settings() {
        $this.Init(@{})
    }
    # Kontruktor
    Settings([hashtable]$Properties) {
        $this.Init($Properties)
    }
    # Shared initializer method
    [void] Init([hashtable]$Properties) {
        foreach ($Property in $Properties.Keys) {
            if ($this.PSObject.Properties[$Property]) {
                $this.$Property = $Properties[$Property]
            }
            else {
                $this | Add-Member -MemberType NoteProperty -Name $Property -Value $Properties[$Property]
            }
        }
    }
    # Setter
    [void] Set($propertyName, $propertyValue) {
        if ($this.PSObject.Properties[$PropertyName]) {
            $this.$propertyName = $propertyValue
        }
        else {
            $this | Add-Member -MemberType NoteProperty -Name $PropertyName -Value $propertyValue
        }
    }
    # Getter
    [String] Get($propertyName) {
        if ($this.PSObject.Properties[$PropertyName]) {
            return $this.$propertyName
        }
        else {
            $propertyValue = Read-Host "Enter value for" $PropertyName
            $this | Add-Member -MemberType NoteProperty -Name $PropertyName -Value $propertyValue
            return $this.$propertyName
        }
    }
    # Checker
    [bool] Exist($propertyName) {
        if ($this.PSObject.Properties[$PropertyName]) {
            return $true
        }
        else{
            return $false
        }
    }
    # Printer
    [String]toString() {
        $to_string = "properties:"
        foreach ($property in $this.PSObject.Properties) {
            $to_string = $to_string + ",$($property.Name):$($property.Value)"
        }
        return $to_string
    }
}

class SettingsManager {
    [string]$FilePath
    [Settings]$Settings

    SettingsManager() {
        $this.Init("settings/settings.json")
    }

    SettingsManager([string]$SettingsFilePath) {
        $this.Init($SettingsFilePath)
    }

    Init([string]$SettingsFilePath) {
        $this.FilePath = $SettingsFilePath;
        If (Test-Path $SettingsFilePath) {
            $this.Settings = Get-Content $SettingsFilePath | Out-String | ConvertFrom-Json -AsHashtable 
        }
        Else {
            $this.Settings = [Settings]::new()
        }
    }

    Save() {
        $json = $this.Settings | ConvertTo-Json -Depth 5
        $json | Out-File $this.FilePath
    }

    [Settings]GetSettings() {
        return($this.Settings)
    }
}

class CredentialsManager {
    [string]$FilePath
    [Settings]$Settings

    CredentialsManager() {
        $this.Init("settings/credentials.json")
    }

    CredentialsManager([string]$CredentialsFilePath) {
        $this.Init($CredentialsFilePath)
    }
    
    Init([string]$CredentialsFilePath) {
        $this.FilePath = $CredentialsFilePath
        If (Test-Path $CredentialsFilePath) {
            $this.Settings = Get-Content $CredentialsFilePath | Out-String | ConvertFrom-Json -AsHashtable 
        }
        Else {
            $this.Settings = [Settings]::new()
        }
    }

    Save() {
        $this.Settings | ConvertTo-Json -Depth 5 | Out-File $this.FilePath
    }

    [String]GetUsername() {
        return $this.Settings.Get("Username")
    }

    [String]GetPassword() {
        if($this.Settings.Exist("Password")){
            try {
                return ConvertFrom-SecureString -SecureString $(ConvertTo-SecureString $this.Settings.Get("Password")) -AsPlainText
            }
            catch {
                return ""
            }
        }else{
            $Password = Read-Host -AsSecureString -Prompt "Enter Password"
            $this.Settings.Set("Password",$(ConvertFrom-SecureString -SecureString $Password))
            return ConvertFrom-SecureString -SecureString $(ConvertTo-SecureString $this.Settings.Get("Password")) -AsPlainText 
        }
    }
}