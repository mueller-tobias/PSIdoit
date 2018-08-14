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

    Write-PSFMessage -Level SomewhatVerbose -Message "Get Objects for Type $ObjectType"
    if ([int]::Parse($ObjectType)) {
        Write-PSFMessage -Level SomewhatVerbose -Message "Get Object for intType $ObjectType"
        $_Objects = Get-iDoitObject -intType $ObjectType
    }
    Else {
        Write-PSFMessage -Level SomewhatVerbose -Message "Get Object for strType $ObjectType"
        $_Objects = Get-iDoitObject -ObjectType $ObjectType
    }

    foreach ($_Object in $_Objects) {
        Write-PSFMessage -Level SomewhatVerbose -Message "Get Category $Category for $($_Object.title)"
        $_CatEntry = Get-iDoitObjectCategory $_Object.Id -Category $Category
        If ($_CatEntry.$Field -like $Value) {
            Write-PSFMessage -Level SomewhatVerbose -Message "Found Object: $($_Object.Title)"
            $_CatEntry
        }
    }
}
