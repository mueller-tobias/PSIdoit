function Get-iDoitReport
<#
.SYNOPSIS
    Receives a List of i-doit Reports or Runs the specified report
.DESCRIPTION
    Receives a List of i-doit Reports or Runs the specified report.

    When the Cmdlet is called without -ReportID Parameter you'll get
    a list of all reports in i-doit the api user has access.

    When the Cmdlet is called with the ReportID the API will return
    the result of those report
.PARAMETER ReportID
    The valid ID of an i-doit Report
.EXAMPLE
    PS C:\> Get-iDoitReport

    Receives a list of all Reports the API User has access
.EXAMPLE
    PS C:\> Get-iDoitReport -ReportID 12

    Runs Report with the ID 12 and receives the result of those report
.OUTPUTS
    [PSCustomObject]
#>
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