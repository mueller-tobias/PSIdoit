Function Write-VersionRequirements {
    # Change the variable below (ProjectPath) to your modules location
    $ProjectPath = "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\bConnect" 

    Save-Module -Name VersionAnalyzerRules -Path "$env:TEMP"
    $VersionRequirements = Invoke-ScriptAnalyzer -Path "$ProjectPath" -Recurse -CustomRulePath "$env:TEMP\VersionAnalyzerRules" -ErrorAction SilentlyContinue

    If ($VersionRequirements) {
        If ($VersionRequirements.RuleName.Contains('Test-OS10Command')) {
            $RequiredOS = 'Windows 10/Windows Server 2016'
        } ElseIf ($VersionRequirements.RuleName.Contains('Test-OS62Command')) {
            $RequiredOS = 'Windows 8.1/Windows Server 2012 R2'
        } Else {
            $RequiredOS = 'Windows 7/Windows Server 2008 R2'
        }

        If ($VersionRequirements.RuleName.Contains('Test-PowerShellv5Command')) {
            $RequiredWMF = 'WMF 5'
        } ElseIf ($VersionRequirements.RuleName.Contains('Test-PowerShellv4Command')) {
            $RequiredWMF = 'WMF 4'
        } ElseIf ($VersionRequirements.RuleName.Contains('Test-PowerShellv3Command')) {
            $RequiredWMF = 'WMF 3'
        } Else {
            $RequiredWMF = 'WMF 2'
        }
    } Else {
        $RequiredOS = 'Windows 7/Windows Server 2008 R2'
        $RequiredWMF = 'WMF 2'
    }

    Write-Host -Object " "
    Write-Host -Object "The Required OS Version is: " -NoNewline -ForegroundColor Yellow
    Write-Host -Object "$RequiredOS" -ForegroundColor Green
    Write-Host -Object "The Required WMF Version is: " -NoNewline -ForegroundColor Yellow
    Write-Host -Object "$RequiredWMF" -ForegroundColor Green
    Write-Host -Object " "
}

Write-VersionRequirements
