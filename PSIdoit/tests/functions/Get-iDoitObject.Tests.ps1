Describe "Testing Get-IdoitObject Function" {
    Context "Checking Get-iDoitObject returns some object" {
        It "Reads all the Objects from the iDoit API" {
            $iDoitObjects = Get-iDoitObject -limit 10
            $iDoitObjects.Count | Should  Be 10
        }
    }
}