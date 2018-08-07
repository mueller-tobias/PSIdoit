function Search-Idoit
{
	[CmdletBinding()]
	param
	(
		[String]$Query
	)
    
    $_Params = @{
		q = $Query
	}
	
    $Result = Invoke-iDoit -Method "idoit.search" -Data $_Params
    $Result | ForEach-Object {
        if ($_.PSObject.Properties.Name -contains 'documentId') {
            Add-ObjectDetail -InputObject $_ -TypeName 'iDoit.SearchResult'
        }
        else {
            $_
        }
    }
		
}
