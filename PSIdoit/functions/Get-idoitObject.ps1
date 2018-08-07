function Get-iDoitObject {
	[CmdletBinding()]
	param
	(
		[String]$ObjectType,
		[int[]]$ObjectID,
		[int]$IntType,
		[String]$ObjectTitle,
		[Switch]$Full,
		[int]$limit
	)
	
	$_Params = @{
		filter = @{
		}
	}
	
	if ($ObjectType) {
		$_Params.Filter += @{ type_title = $ObjectType }
	}
	if ($ObjectTitle) {
		$_Params.Filter += @{ title = $ObjectTitle }
	}
	if ($IntType) {
		$_Params.Filter += @{ type = $IntType }
	}
	if ($limit) {
		$_Params += @{ limit = $limit }
	}
	if ($ObjectID) {
		$_idFilter = @{
			ids = @{ }
		}
		foreach ($_ID in $ObjectID) {
			$_idFilter.ids += @{ id = $_ID }
		}
		$_Params.Filter += $_idFilter
	}
	
	
	$Result = Invoke-iDoit -Method "cmdb.objects.read" -Data $_Params
	
	if ($Full) {
		$Result | Get-iDoitObjectFull
	}
	Else {
		$Result | ForEach-Object {
			if ($_.PSObject.Properties.Name -contains 'id') {
				Add-ObjectDetail -InputObject $_ -TypeName 'iDoit.Object'
			}
			else {
				$_
			}
		}
	}
}
