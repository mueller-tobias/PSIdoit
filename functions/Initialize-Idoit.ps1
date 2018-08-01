Function Initialize-idoit() {
    <#
        .Synopsis
            Initialize the connection to bConnect.
        .Parameter Server
            Hostname/FQDN/IP of the baramundi Management Server.
        .Parameter Port
            Port of bConnect (default: 443).
        .Parameter ApiKey
            PSCredential-object with permissions in the bMS.
        .Parameter AcceptSelfSignedCertificate
            Switch to ignore untrusted certificates.
    #>
	
	Param (
		[Parameter(Mandatory = $true)]
		[string]$Server,
		[string]$Port = "443",
		[string]$ApiKey,
		[System.Management.Automation.PSCredential]$Credentials,
		[switch]$AcceptSelfSignedCertifcate
	)
	
	If ($AcceptSelfSignedCertifcate) {
		[System.Net.ServicePointManager]::CertificatePolicy = New-Object ignoreCertificatePolicy
	}
	
	$_uri = "https://$($Server):$($Port)/src/jsonrpc.php"

	$script:_connectInitialized = $true
	$script:_connectUri = $_uri
	$script:_connectCredentials = $Credentials
	$script:_connectApiKey = $ApiKey

	Connect-iDoit
	$Test = Test-iDoit
		
	If ($Test -ne $true) {
		$script:_connectInitialized = $false
		$script:_connectUri = ""
		$script:_connectCredentials = ""
		$script:_connectApiKey = $ApiKey
		$ErrorObject = New-Object System.Net.WebSockets.WebSocketException "$Test"
		Throw $ErrorObject
	}
	else {
		Write-Verbose -Message "Verbindung mit $Server hergestellt."
		Write-Verbose -Message "i-Doit Version: $($script:_iDoitInfo.Version)"
		Write-Verbose -Message "Logged in: $($script:_iDoitInfo.Login.Name) (UserID: $($script:_iDoitInfo.Login.UserID))"
	}
}