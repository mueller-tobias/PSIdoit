Import-Module psidoit -force
#Import-Module SaltoExport -Force

Initialize-iDoit -Server "it-idoit.b1shba.intern" -AcceptSelfSignedCertifcate  -ApiKey "md0p5opek" -Credential "s2041" -Verbose
Get-iDoitObject -ObjectID 81  -Full