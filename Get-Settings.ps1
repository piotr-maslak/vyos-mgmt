#[CmdletBinding()]
Param (
    [String]$Hostname
)

If (Test-Path ".\settings.json") { $Settings = Get-Content '.\settings.json' | Out-String | ConvertFrom-Json -AsHashtable }
Else {
    $Settings = @{
        hostname = "";
    }
}

If ($PSBoundParameters.ContainsKey('Hostname') -eq $true) { $Settings.hostname = $Hostname }
Elseif ($Settings.hostname -eq "") { $Settings.hostname = Read-Host "Please enter hostname" }

$Settings | ConvertTo-Json | Out-File "settings.json"

return $Settings