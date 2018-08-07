Function Test-iDoit() {
    <#
        .Synopsis
            INTERNAL - Validates the iDoit API Version and Connectivity
        .Parameter MinVersion
            Minimum required Version
    #>
	
	Param (
		[string]$MinVersion = "1.11"
	)
	
	If (!$script:_connectInitialized) {
		return "iDoit module is not initialized. Use 'Initialize-iDoit' first!"
	}
	else {
		try {
			$script:_iDoitInfo = Invoke-iDoit -Method "idoit.version" -ErrorAction Stop
			If (-not ($script:_iDoitInfo.Version -ge $MinVersion)) {
				Return "iDoit has not the Required Version: $MinVersion"
			}			
		}
		catch {
			Throw $_.ToString()
		}

	}
	Return $true

}

