#[CmdletBinding()]
Param (
    [switch]$withPass,
    [String]$Username
)

If (Test-Path ".\credentials.xml") {
    $Credentials = Import-CliXml -Path 'credentials.xml'
}
Else {
    $Credentials = [PSCredential]::empty
}

# $Username param           yes | no →
# $Username credentials     yes | no →
# withPass                  yes | no →

# Write-Host "Credentials.UserName :" $Credentials.UserName
# Write-Host "Username :" $Username



If ($null -eq $Credentials.UserName) {
    If ($PSBoundParameters.ContainsKey('Username') -eq $false){
        $Username = Read-Host -Prompt "Enter Username" 
    }
    $Credentials = [PSCredential]::new($Username, (new-object System.Security.SecureString))
    $Credentials | Export-CliXml -Path 'credentials.xml'
}
Else {
    If ($PSBoundParameters.ContainsKey('Username') -eq $false){
        $Username = $Credentials.UserName
    }
}


If ($withPass) {
    $Password = Read-Host -AsSecureString -Prompt "Enter Password"
    $Credentials = [PSCredential]::new($Username, $Password)
    $Credentials | Export-CliXml -Path 'credentials.xml'
}

Return $Credentials