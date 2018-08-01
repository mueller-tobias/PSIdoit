Function Invoke-iDoit() {
    <#
        .Synopsis
            INTERNAL - HTTP-POST against iDoit
        .Parameter Data
            Hashtable with parameters
    #>
	
	Param (
		[Parameter(Mandatory = $true)]
		[string]$Method,
		[PSCustomObject]$Data,
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
			"method" = $Method
			"params" = @{
				apikey = $script:_connectApiKey
			}
		}

		$Body = ConvertTo-Json $Hash

		If ($script:_connectSessionID) {
			$Header = @{"X-RPC-Auth-Session" = $script:_connectSessionID }
		}

		# Get Data from iDoit API
		If (-not ($script:_connectCredentials) -and $script:_connectApiKey) {
			$_rest = Invoke-RestMethod -Method Post -Uri $script:_connectUri -Body $Body -ContentType "application/json-rpc ; charset=utf-8"
		}
		ElseIf ($script:_connectCredentials -and $script:_connectApiKey) {
			$_rest = Invoke-RestMethod -Method Post -Uri $script:_connectUri -Body $Body -ContentType "application/json-rpc ; charset=utf-8" -Headers $Header
		}

		# Check the Results
		if ($_rest.result) {
			$_rest.result
		}
		else {
			$ErrorObject = New-Object System.Net.WebSockets.WebSocketException $_rest.error.message
			$ErrorObject.ErrorCode = $_rest.code
			Throw $ErrorObject
		}


<# 		If ($Data.Count -gt 0) {
			$_rest = Invoke-RestMethod -Uri $_uri -Body $Data -Credential $script:_connectCredentials -Method Get -ContentType "application/json" -TimeoutSec $script:_ConnectionTimeout
		}
		else {
			$_rest = Invoke-RestMethod -Uri $_uri -Credential $script:_connectCredentials -Method Get -ContentType "application/json" -TimeoutSec $script:_ConnectionTimeout
		}
		
		If ($_rest) {
			return $_rest
		}
		else {
			return $true
		} #>
	}
	
	catch {
<# 		Try {
			$_response = ConvertFrom-Json $_
		}
		
		Catch {
			$_response = $false
		}
		
		If ($_response) {
			Throw $_response.Message
		}
		else {
			Throw $_
		}
		
		return $false #>
	}
}