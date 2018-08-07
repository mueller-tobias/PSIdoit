function Search-IdoitObjectByCategory
{
	[CmdletBinding()]
	param
	(
        [String]$ObjectType,
        [String]$Category,
        [String]$Field,
        [String]$Value
	)

    Write-Verbose -Message "Get Objects for Type $ObjectType"
    if ([int]::Parse($ObjectType)) {
        Write-Verbose -Message "Get Object for intType $ObjectType"
        $_Objects = Get-iDoitObject -intType $ObjectType
    }
    Else {
        Write-Verbose -Message "Get Object for strType $ObjectType"
        $_Objects = Get-iDoitObject -ObjectType $ObjectType
    }

    foreach ($_Object in $_Objects) {
        Write-Verbose -Message "Get Category $Category for $($_Object.title)"
        $_CatEntry = Get-iDoitObjectCategory $_Object.Id -Category $Category
        If ($_CatEntry.$Field -like $Value) {
            Write-Verbose -Message "Found Object: $($_Object.Title)"
            $_CatEntry
        }
    }
}
