function Set-iDoitCredential {
    param (
        [System.Management.Automation.PSCredential]$Credentials
    )
    $script:_connectCredentials = $Credentials
}
