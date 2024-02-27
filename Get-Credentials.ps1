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

# $Username                 yes | no
# $Credentials              yes | no
# withPass                  yes | no

# Write-Host "Credentials.UserName :" $Credentials.UserName
# Write-Host "Username :" $Username

If ($Username -eq "") {
    If ($null -eq $Credentials.UserName) {
        $Username = Read-Host -Prompt "Enter Username" 
        $Credentials = [PSCredential]::new($Username, (new-object System.Security.SecureString))
        $Credentials | Export-CliXml -Path 'credentials.xml'
    }
    Elseif ($null -ne $Credentials.UserName) {
        $Username = $Credentials.UserName
    }
}
Else {
    $Credentials = [PSCredential]::new($Username, (new-object System.Security.SecureString))
    $Credentials | Export-CliXml -Path 'credentials.xml'
}

If ($withPass) {
    $Password = Read-Host -AsSecureString -Prompt "Enter Password"
    $Credentials = [PSCredential]::new($Username, $Password)
    $Credentials | Export-CliXml -Path 'credentials.xml'
}

Return $Credentials