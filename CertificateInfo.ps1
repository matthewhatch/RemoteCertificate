$CertificateInfo = @'
using System;

public class CertificateInformtation
{

    public string Name { get; set; }
    public string PublicKey { get; set; }
    public string SerialNumber { get; set; }
    public string Thumbprint { get; set; }
    public string Issuer { get; set; }
    public DateTime EffectiveDate { get; set; }
    public DateTime ExpirationDate { get; set; }

    public CertificateInformtation(){}

    public double ExpiresIn()
    {
        DateTime today = DateTime.Today;
        return (ExpirationDate - today).TotalDays;

    }
}
    
'@