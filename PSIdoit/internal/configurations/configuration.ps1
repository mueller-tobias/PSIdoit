<#
This is an example configuration file

By default, it is enough to have a single one of them,
however if you have enough configuration settings to justify having multiple copies of it,
feel totally free to split them into multiple files.
#>

<#
# Example Configuration
Set-PSFConfig -Module 'bConnect' -Name 'Example.Setting' -Value 10 -Initialize -Validation 'integer' -Handler { } -Description "Example configuration setting. Your module can then use the setting using 'Get-PSFConfigValue'"
#>

#Path to an Configuration JSON File
$ConfigurationFile = "$($(Get-PSFConfig -Module 'Schriesheim-IT' -Name 'ConfigurationRepository').Value)\PSIdoit\PSIdoit.json"

Set-PSFConfig -Module 'PSiDoit' -Name 'iDoit.ApiKey' -Value '' -Initialize -Validation 'String' -Handler { } -Description "API Key der für die Verbindung zur REST API benötigt wird." -ModuleExport
Set-PSFConfig -Module 'PSiDoit' -Name 'iDoit.User' -Value '' -Initialize -Validation 'String' -Handler { } -Description "Benutzername der für die Verbindung zur REST API benötigt wird." -ModuleExport
Set-PSFConfig -Module 'PSiDoit' -Name 'iDoit.Server' -Value '' -Initialize -Validation 'String' -Handler { } -Description "Server auf die iDoit REST API ausgeführt wird." -ModuleExport


If ($ConfigurationFile)
{
    Import-PSFConfig -Path $ConfigurationFile
}