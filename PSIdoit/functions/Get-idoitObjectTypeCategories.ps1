<#
	.SYNOPSIS
		A brief description of the Get-iDoitConstants function.

	.DESCRIPTION
		A description of the file.

	.PARAMETER Type
		A description of the Type parameter.

	.PARAMETER TypeID
		A description of the TypeID parameter.

	.PARAMETER TypeID
		A description of the Type parameter.

	.PARAMETER ShowType
		A description of the ShowType parameter.

	.PARAMETER ShowCategory
		A description of the ShowCategory parameter.

	.NOTES
		===========================================================================
		Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.153
		Created on:   	02.08.2018 11:47
		Created by:   	s2041
		Organization:
		Filename:     	Get-idoitCategories.ps1
		===========================================================================
#>
function Get-idoitObjectTypeCategories {
	[CmdletBinding(DefaultParameterSetName = 'Type')]
	param
	(
		[Parameter(ParameterSetName = 'Type',
				   Mandatory = $true)]
		[string]$Type
	)

	process {

		$_Params = @{
			type = $Type
		}

		$Result = Invoke-iDoit -Method "cmdb.object_type_categories" -Data $_Params

		$_List = @()

		foreach ($_Property in $Result.Psobject.Properties | Where-Object {$_.MemberType -eq "NoteProperty"}) {
			$_List += $_Property.Value | ForEach-Object {
				if ($_.PSObject.Properties.Name -contains 'id') {
					Add-ObjectDetail -InputObject $_ -TypeName 'iDoit.Category'
				}
				else {
					$_
				}
			}
		}

		$_List
	}
}


