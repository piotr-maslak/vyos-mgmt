Param ( # Input parameters
    [String]$Username,
    [switch]$withPass,
    [String]$Hostname,
    [Int]$Port
)

$Params = @{} # Grab parameters to a hash table
foreach ($paramName in $PSBoundParameters.Keys) { 
    $Params[$paramName] = $PSBoundParameters[$paramName]
}

$Settings = . .\Get-Settings.ps1 @Params        # Settings with Params
$Credentials = . .\Get-Credentials.ps1 @Params  # Credentials with Params

# If ($Port -ne "") {
#     If ($null -eq $Settings.ssh.port) {
#         $Settings.Add("ssh", @{ "port" = $Port })
#     }
#     else {
#         $Settings.ssh.port = $Port
#     }
# }

if($PSBoundParameters.ContainsKey('Port') -eq $true){
    If ($null -eq $Settings.ssh.port) {
        $Settings.Add("ssh", @{ "port" = $Port })
    }
    Else {
        $Settings.ssh.port = $Port
    }
}   



$Settings | ConvertTo-Json | Out-File "settings.json"

# $Serial = @{
#     port   = "com1"
#     speed  = 9600
#     data   = 8
#     parity = 1
# }

# $Settings.Add("serial", $Serial);

$puttyPath = "putty.exe"
try {
    $localCommand = $puttyPath + " -ssh -P " + $Settings.ssh.port + " -pw " + $(ConvertFrom-SecureString -SecureString $Credentials.Password -AsPlainText) + " " + $Credentials.Username + "@" + $Settings.hostname
}
catch {
    Write-Error "Brak poświadczeń"
}

# putty.exe -ssh -P %port% %pw% %user%@%host%

#Write-Output $localCommand
$result = Invoke-Expression($localCommand)
return $result