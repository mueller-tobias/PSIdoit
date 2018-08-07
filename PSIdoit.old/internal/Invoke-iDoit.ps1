<#
	.Synopsis
		INTERNAL - HTTP-POST against iDoit
	
	.DESCRIPTION
		A detailed description of the Invoke-iDoit function.
	
	.PARAMETER Method
		A description of the Method parameter.
	
	.Parameter Data
		Hashtable with parameters
	
	.PARAMETER Header
		A description of the Header parameter.
	
	.NOTES
		Additional information about the function.
#>
function Invoke-iDoit {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$Method,
		[hashtable]$Data,
		[hashtable]$Header
	)
	
		If ($verbose) {
		$ProgressPreference = "Continue"
	}
	else {
		$ProgressPreference = "SilentlyContinue"
	}
	

	try {
		
		$hash = @{
			"jsonrpc" = "2.0"
			"method"  = $Method
			"params"  = @{
				apikey = $script:_connectApiKey
			}
		}
		
		if ($Data.Count -ge 1) {
			$hash.params += $Data
		}
		
		$Body = ConvertTo-Json $Hash -Depth 4
		
		If ($script:_connectSessionID) {
			$Header = @{ "X-RPC-Auth-Session" = $script:_connectSessionID }
		}
		
		# Get Data from iDoit API
		If (-not ($script:_connectCredentials) -and $script:_connectApiKey) {
			$_rest = Invoke-RestMethod -Method Post -Uri $script:_connectUri -Body $Body -ContentType "application/json-rpc ; charset=utf-8"
		}
		ElseIf ($script:_connectCredentials -and $script:_connectApiKey) {
			$_rest = Invoke-RestMethod -Method Post -Uri $script:_connectUri -Body $Body -ContentType "application/json-rpc ; charset=utf-8" -Headers $Header
		}
	}
		
	catch {
		Throw $_
		}

		# Check the Results
		if ($_rest.result) {
			$_rest.result
		}
		ElseIf ($_rest.error) {
			$ErrorObject = New-Object System.Net.WebSockets.WebSocketException ($_rest.error.code, "$($_rest.error.message) - $($_rest.error.data.error)")
			Throw $ErrorObject
		}
		else {
			Write-Verbose "Nothing found for $Method"
		}

	

}
