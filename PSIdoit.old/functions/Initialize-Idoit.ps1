<#
	.Synopsis
		Initialize the connection to bConnect.
	
	.DESCRIPTION
		A detailed description of the Initialize-idoit function.
	
	.Parameter Server
		Hostname/FQDN/IP of the baramundi Management Server.
	
	.Parameter Port
		Port of bConnect (default: 443).
	
	.Parameter ApiKey
		PSCredential-object with permissions in the bMS.
	
	.PARAMETER Credentials
		A description of the Credentials parameter.
	
	.PARAMETER AcceptSelfSignedCertifcate
		A description of the AcceptSelfSignedCertifcate parameter.
	
	.Parameter AcceptSelfSignedCertificate
		Switch to ignore untrusted certificates.
	
	.NOTES
		Additional information about the function.
#>
function Initialize-idoit {
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$Server,
		[string]$Port = "443",
		[Parameter(ParameterSetName = 'ApiKey',
				   Mandatory = $true)]
		[Parameter(ParameterSetName = 'Login',
				   Mandatory = $true)]
		[string]$ApiKey,
		[Parameter(ParameterSetName = 'Login',
				   Mandatory = $true)]
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
	
	if ($Credentials) {
		Connect-iDoit
	}
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
		
#		Push-Location $PSScriptRoot\..\internal
#		'iActions' | ForEach-Object {
#			Write-Verbose "Loading $_.ps1"
#			. "./$_.ps1"
#		}
		#		Pop-Location
		$Catg = Get-iDoitConstants -GlobalCategory
		
		foreach ($_Catg in $Catg.PSObject.Properties | Where-Object { $_.MemberType -eq "NoteProperty" }) {
			Write-Verbose "Erstelle $($_Catg.Name)"
			. getable -Category $_Catg.Name -ParamNames ObjectID
		}
		Export-ModuleMember -function "Get-*"
	}
}
