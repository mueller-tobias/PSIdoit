function Get-iDoitObjectFull {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true,
				   ValueFromPipeline = $true)]
		[PSCustomObject]$Object
	)

	Process {
		Write-Verbose -Message "Get Categories for Object Type $($Object.type)"
		$_ObjectCategories = Get-idoitObjectTypeCategories -Type $Object.type

		$_List = @()

		foreach ($_Category in $_ObjectCategories) {
			Write-Verbose -Message "Get Category $($_Category.const) for Object $($Object.Id)"
			$_Cat = @{$_Category.const = Get-iDoitObjectCategory -ObjectID $Object.Id -Category $_Category.const}
			$_List += $_Cat
		}

		$_List
	}

	<#$Result = Invoke-iDoit -Method "cmdb.objects.read" -Data $_Params
	$Result | ForEach-Object {
		if ($_.PSObject.Properties.Name -contains 'id') {
			Add-ObjectDetail -InputObject $_ -TypeName 'iDoit.Object'
		}
		else {
			$_
		}
	}#>
}
