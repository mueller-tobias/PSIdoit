function Get-iDoitObjectCategory
{
    [CmdletBinding(DefaultParameterSetName = 'Static')]
    param
    (
        [Parameter(ParameterSetName = 'Static',
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 1)]
        [Alias('id')]
        [string]$ObjectID,
        [Parameter(ParameterSetName = 'Dynamic',
            Mandatory = $true,
            Position = 2)]
        [Parameter(ParameterSetName = 'Static',
            Mandatory = $false)]
        [string]$Category = 'C__CATG__GLOBAL',
        [Parameter(ParameterSetName = 'Dynamic',
            Mandatory = $true)]
        [hashtable]$Parameters = @{ }
    )

    process
    {

        If ($Parameters.Count -gt 0)
        {
            $ObjectID = $Parameters.ObjectID
        }

        $_Params = @{
            category = $Category
            objID    = $ObjectID
        }
        $Result = Invoke-iDoit -Method "cmdb.category" -Data $_Params
        $Result | ForEach-Object {
            if ($_.PSObject.Properties.Name -contains 'id')
            {
                Add-ObjectDetail -InputObject $_ -TypeName 'iDoit.Object.Category'
            }
            else
            {
                $_
            }
        }
    }
}
