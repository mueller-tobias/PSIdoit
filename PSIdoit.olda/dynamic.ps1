function gettable {
	param ([parameter(Position = 0)]
		[string]$Controller,
		[string[]]$ParamNames = @(),
		[string[]]$CommonFlags = @(),
		[string]$Preferred = 'Any',
		[string]$Verb = 'Get',
		[string]$Noun = ($Controller -replace '^\.\.\/', '' -replace 's$', ''),
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
								))][guid]`${0}" -F $_
							}
							$CommonFlags | ForEach-Object { '[Parameter()][switch]${0}' -F $_ }
						}) -join ',') +
				")process{Invoke-Connect -Controller $Controller -Parameters `$PSBoundParameters}}"
			))
	}
}



