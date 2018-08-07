$Catg = Get-iDoitConstants -GlobalCategory

foreach ($_Catg in $Catg.PSObject.Properties | Where-Object { $_.MemberType -eq "NoteProperty" }) {
	Write-Verbose "Erstelle $($_Catg.Name)"
	. getable -Category $_Catg.Name -ParamNames ObjectID
}
#Write-Verbose $Catg.PSObject.Properties.Name
"C__CATG__STACK_PORT_OVERVIEW" | ForEach-Object {
    . getable $_ -ParamNames ObjectID
}

. getable -category "C__CATG__VRRP" -ParamNames ObjectID