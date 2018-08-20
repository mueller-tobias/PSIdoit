function Get-iDoitReport
{
    param (
        $ReportID
    )

    If ($ReportID)
    {
        $_Params = @{
            id = $ReportID
        }
    }

    If ($_Params.Count -gt 0)
    {
        Invoke-iDoit -Method "cmdb.reports.read" -Data $_Params
    }
    else
    {
        Invoke-iDoit -Method "cmdb.reports.read" -Data $_Params | Sort-Object -Property {[int]$_.ID}
    }

}