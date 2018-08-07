function Set-iDoitCredentials {
    param (
        [System.Management.Automation.PSCredential]$Credentials
    )
    $script:_connectCredentials = $Credentials
}