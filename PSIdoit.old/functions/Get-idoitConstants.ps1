<#
	.SYNOPSIS
		A brief description of the Get-iDoitConstants function.
	
	.DESCRIPTION
		A description of the file.
	
	.PARAMETER Type
		A description of the Type parameter.
	
	.PARAMETER GlobalCategory
		A description of the GlobalCategory parameter.
	
	.PARAMETER SpecificCategory
		A description of the SpecificCategory parameter.
	
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
function Get-iDoitConstants {
	[CmdletBinding(DefaultParameterSetName = 'GlobalCategory')]
	param
	(
		[Parameter(ParameterSetName = 'Type',
				   Mandatory = $true)]
		[switch]$Type,
		[Parameter(ParameterSetName = 'GlobalCategory',
				   Mandatory = $false)]
		[switch]$GlobalCategory,
		[Parameter(ParameterSetName = 'SpecificCategory',
				   Mandatory = $false)]
		[switch]$SpecificCategory
	)
	
	$Result = Invoke-iDoit -Method "idoit.constants"
	
	switch ($PsCmdlet.ParameterSetName) {
		'GlobalCategory' {
			if ($GlobalCategory) {
				$Result.categories.g
			}
		}
		'SpecificCategory' {
			if ($SpecificCategory) {
				$Result.categories.s
			}
			
		}
		'Type' {
			if ($Type) {
				$Result.objectTypes
			}
			
		}
	}
}


