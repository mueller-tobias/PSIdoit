Function Get-iDoitVersion() {
    <#
        .Synopis
            Checks for supported iDoit version and returns the version (e.g. "v1.0").
    #>
	
	Param (
	)
	
	If (!$script:_iDoitInfo) {
        $script:_iDoitInfo = Invoke-iDoit -Method "idoit.version"
	}
	
	Write-Verbose "iDoit $($script:_iDoitInfo.Version)"
	$script:_iDoitInfo.Version
	
}