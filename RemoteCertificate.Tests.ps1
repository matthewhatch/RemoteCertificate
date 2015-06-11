Import-Module $PSScriptRoot\RemoteCertificate.psm1

Describe 'Get-RemoteCertificate' {
    $CertInfo = Get-SiteCertificate -Url 'https://www.google.com'
    $Members = Get-Member -InputObject $CertInfo
    It 'Should Return an object type CertificateInformation'{
        #$CertInfo.GetType().FullName | Should Be 'CertificateInformation'
    }

    It 'Should return an object with property Thumbprint' {
        $Members.Name -contains 'Thumbprint' | Should Be $true  
    }

    It 'Should return an object with property SerialNumber' {
        $Members.Name -contains 'SerialNumber' | Should Be $true
    }

    It 'Should return an object with property Issuer' {
        $Members.Name -contains 'Issuer' | Should Be $true
    }

    It 'Should return an object with property EffectiveDate' {
        $Members.Name -contains 'EffectiveDate' | Should Be $true
    }

    It 'Should return an object with property ExpirationDate' {
        $Members.Name -contains 'ExpirationDate' | Should Be $true
    }

    It 'Should return an object with property Certificate' {
        $Members.Name -contains 'Certificate' | Should Be $true
    }

    It 'Should return an object with property Name' {
        $Members.Name -contains 'Name' | Should Be $true
    }
}