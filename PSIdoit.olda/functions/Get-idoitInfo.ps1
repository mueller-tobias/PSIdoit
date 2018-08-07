    <#
	.Synopsis
		Gets info from iDoit.
	
	.DESCRIPTION
		A detailed description of the Get-iDoitInfo function.
	
	.NOTES
		Additional information about the function.
#>
function Get-iDoitInfo {
	[CmdletBinding()]
	param ()
	
	If (!$script:_iDoitInfo) {
        $script:_iDoitInfo = Invoke-iDoit -Method "idoit.version"
	}
	
	$script:_iDoitInfo
}