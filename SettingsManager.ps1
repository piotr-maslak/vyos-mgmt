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
        else {
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
    [string]$FileName
    [string]$FolderName = "settings"
    [Settings]$Settings

    SettingsManager() {
        $this.Init($this.FolderName, "system.json")
    }

    SettingsManager([string]$FileName) {
        $this.Init($this.FolderName, $FileName)
    }
    
    SettingsManager([string]$FolderName, [string]$FileName) {
        $this.Init($FolderName, $FileName)
    }

    Init([string]$FolderName, [string]$FileName) {
        $this.FileName = $FileName
        $this.FolderName = $FolderName
        $path = $FolderName + "\" + $FileName
        If (Test-Path $path) {
            $this.Settings = Get-Content $path | Out-String | ConvertFrom-Json -AsHashtable 
        }
        Else {
            $this.Settings = [Settings]::new()
        }
    }

    Save() {
        if (-not (Test-Path -Path $this.FolderName)) {
            New-Item -ItemType Directory -Path $this.FolderName
        }
        $path = $this.FolderName + "\" + $this.FileName
        $json = $this.Settings | ConvertTo-Json -Depth 5
        $json | Out-File $path
    }

    [Settings]GetSettings() {
        return($this.Settings)
    }
}

class CredentialsManager {
    [string]$FileName
    [string]$FolderName = "settings"
    [Settings]$Settings

    CredentialsManager() {
        $this.Init($this.FolderName, "credentials.json")
    }

    CredentialsManager([string]$FileName) {
        $this.Init($this.FolderName, $FileName)
    }

    CredentialsManager([string]$FolderName, [string]$FileName) {
        $this.Init($FolderName, $FileName)
    }
    
    Init([string]$FolderName, [string]$FileName) {
        $this.FileName = $FileName
        $this.FolderName = $FolderName
        $path = $FolderName + "\" + $FileName
        If (Test-Path $path) {
            $this.Settings = Get-Content $path | Out-String | ConvertFrom-Json -AsHashtable 
        }
        Else {
            $this.Settings = [Settings]::new()
        }
    }

    Save() {
        if (-not (Test-Path -Path $this.FolderName)) {
            New-Item -ItemType Directory -Path $this.FolderName
        }
        $path = $this.FolderName + "\" + $this.FileName
        $this.Settings | ConvertTo-Json -Depth 5 | Out-File $path
    }

    [String]GetUsername() {
        return $this.Settings.Get("Username")
    }

    [String]GetPassword() {
        if ($this.Settings.Exist("Password")) {
            try {
                return ConvertFrom-SecureString -SecureString $(ConvertTo-SecureString $this.Settings.Get("Password")) -AsPlainText
            }
            catch {
                return ""
            }
        }
        else {
            $Password = Read-Host -AsSecureString -Prompt "Enter Password"
            $this.Settings.Set("Password", $(ConvertFrom-SecureString -SecureString $Password))
            return ConvertFrom-SecureString -SecureString $(ConvertTo-SecureString $this.Settings.Get("Password")) -AsPlainText 
        }
    }
}