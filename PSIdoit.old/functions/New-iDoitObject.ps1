function New-iDoitObject {
	[CmdletBinding()]
	param
	(
        $Type,
        $Title,
        $Category,
        $Purpose,
        $CmdbStatus,
        $Description
	)
	
	process {
		$_Params = @{
            type    = $Type
            title = $Title
            category = $Category
            purpose = $Purpose
            cmdb_status = $CmdbStatus
            Description = $Description
		}
		
		$Result = Invoke-iDoit -Method "cmdb.object.create" -Data $_Params
		$Result
	}
}
