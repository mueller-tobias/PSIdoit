    <#
	.Synopsis
		Gets info from iDoit.
	
	.DESCRIPTION
		A detailed description of the Get-iDoitInfo function.
	
	.NOTES
		Additional information about the function.
#>
function Get-idoitCategoryInfo {
	[CmdletBinding()]
	param (
		$GlobalCategory,
		$SpecificCategory,
		$CategoryName
	)
	
		If($GlobalCategory){
			$_Params = @{
				catgID    = $GlobalCategory
			}	
		}
		If($GlobalCategory){
			$_Params = @{
				catsID    = $SpecificCategory
			}	
		}
		If($CategoryName){
			$_Params = @{
				category    = $CategoryName
			}	
		}

	
	$Result = Invoke-iDoit -Method "cmdb.category_info" -Data $_Params
	$Result
	
}