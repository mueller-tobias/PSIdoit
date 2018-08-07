<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.153
	 Created on:   	03.08.2018 12:16
	 Created by:   	s2041
	 Organization: 	
	 Filename:     	Scaffold.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

function script:gettable {
	param ([parameter(Position = 0)]
		[string]$Category,
		[string[]]$ParamNames = @(),
		[string[]]$CommonFlags = @(),
		[string]$Preferred = 'Any',
		[string]$Verb = 'Get',
		[string]$Noun = ($Category -replace '^\.\.\/', '' -replace 's$', ''),
		[string]$CmdName = "$Verb-$Noun"
	)
	process {
		if ($ParamNames.Count) { $first = $ParamNames[0] }
		. ([scriptblock]::Create(
				"function $CmdName{[cmdletbinding(DefaultParameterSetName='By$preferred')]" + "param(" +
				((&{
							$ParamNames | ForEach-Object {
								"[Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='By{0}'$(
									if ($first -eq $_) { ',ValueFromPipeline,Position=0' }
								))]`${0}" -F $_
							}
							$CommonFlags | ForEach-Object { '[Parameter()][switch]${0}' -F $_ }
						}) -join ',') +
				")process{Get-iDoitObjectCategory -Category $Category -Parameters `$PSBoundParameters}}"
			))
	}
}
function script:getiDoitCategory {
	param ([parameter(Position = 0)]
		[string]$Category,
		[string[]]$ParamNames = @(),
		[string[]]$CommonFlags = @(),
		[string]$Preferred = 'Any',
		[string]$Verb = 'Get',
		[string]$Noun = ($Category.Replace("__", "")),
		[string]$CmdName = "$Verb-$Noun"
	)
	process {
		. ([scriptblock]::Create(
				"function $CmdName{[cmdletbinding(DefaultParameterSetName='By$preferred')]" + "param(" +
				((&{
							$ParamNames | ForEach-Object {
								"[Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName='By{0}')]`${0}" -F $_
							}
							$CommonFlags | ForEach-Object { '[Parameter()][switch]${0}' -F $_ }
						}) -join ',') +
				")process{Get-iDoitObjectCategory -Category $Category -Parameters `$PSBoundParameters}}"
			))
	}
}

Set-Alias getable getiDoitCategory -Scope script