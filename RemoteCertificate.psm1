<#
    .SYNOPSIS
        Returns Certificate information from a specific URL

    .DESCRIPTION
        Returns Certificate Name, Thumbprint, SerialNumber, Expiration Date, Public Key, Issuer, and Effective Date
        for a spcific sites certificate

    .PARAMETER URL
        URL of the site to retrieve certificate information

#>

Function Get-SiteCertificate{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string[]]
        $Url
    )
    
    BEGIN{

        #load c# classes
        . $PSScriptRoot\CertificateInfo.ps1

        #disabling the cert validation check. This is what makes this whole thing work with invalid certs...
        [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

        if (-not ([System.Management.Automation.PSTypeName]'CertificateInformtation').Type){
            Write-Verbose 'Addding Type CertificateInfo'
            Add-Type -TypeDefinition $CertificateInfo
        }
    }
    
    PROCESS{
        $url | Foreach{
            Write-Verbose "Checking $_"
        
            $req = [Net.HttpWebRequest]::Create($_)
            $req.Timeout = 10000
    
            try {
                $req.GetResponse() | Out-Null
            } 
            catch{
                throw
            }

            $properties = @{
                Name = $req.ServicePoint.Certificate.GetName()
                Certificate = $req.ServicePoint.Certificate.GetRawCertDataString()
                SerialNumber = $req.ServicePoint.Certificate.GetSerialNumberString()
                Thumbprint = $req.ServicePoint.Certificate.GetCertHashString()
                EffectiveDate = Get-Date($req.ServicePoint.Certificate.GetEffectiveDateString())
                Issuer = $req.ServicePoint.Certificate.GetIssuerName()
                ExpirationDate = Get-Date($req.ServicePoint.Certificate.GetExpirationDateString())
            }

            $Cert = New-Object -TypeName CertificateInformtation -Property $properties
            Write-Output $Cert
        }
    }
}
