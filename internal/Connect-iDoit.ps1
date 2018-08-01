function Connect-iDoit {

    [System.Net.NetworkCredential]$_UnsecureCredentials = $script:_connectCredentials.GetNetworkCredential()
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $_UnsecureCredentials.UserName,$_UnsecureCredentials.Password)))
    Remove-Variable "_UnsecureCredentials"

    $_LoginResult = Invoke-iDoit -Method "idoit.login" -Header @{"Authorization" = "Basic $base64AuthInfo" }
    $script:_connectSessionID = $_LoginResult.'session-id'
}