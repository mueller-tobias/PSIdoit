Describe "Testing Get-IdoitInfo Function" {
    Context "Checking Get-iDoitInfo for the correct return values" {
        It "Reads Version Infos from the API" {
            $iDoitInfo = Get-iDoitInfo
            $iDoitInfo.Type | Should -BeIn @('PRO','OPEN')
            $iDoitInfo.Version | Should Not Be Null
            $Username = $(Get-iDoitCredentials).Username
            Write-PSFMessage -Level Important -Message "Credentials = $Username"
            If (Get-iDoitCredentials) {
                $iDoitInfo.Login.Username | Should  Be $Username
            }
            else {
                $iDoitInfo.Login.Username | Should Be "systemapi"
            }
        }
    }
}