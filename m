From: Michael Gaber <Michael.Gaber@gmx.net>
Subject: [git-svn] howto select a part of the tree
Date: Tue, 12 May 2009 21:58:36 +0200
Message-ID: <4A09D4EC.6050002@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060602010106050902040509"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 21:59:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3y7z-0005d3-HZ
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 21:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbZELT6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 15:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbZELT6y
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 15:58:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:52695 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751075AbZELT6y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 15:58:54 -0400
Received: (qmail invoked by alias); 12 May 2009 19:58:41 -0000
Received: from unknown (EHLO [192.168.178.66]) [95.222.249.246]
  by mail.gmx.net (mp069) with SMTP; 12 May 2009 21:58:41 +0200
X-Authenticated: #1286246
X-Provags-ID: V01U2FsdGVkX18F/nkHRLIFssTqI7l36WEvIdYiieGI3XM5skKNIy
	RgXPqgdh1BrGqr
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118948>

This is a cryptographically signed message in MIME format.

--------------ms060602010106050902040509
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have the following setup and would like to know it my thought workflow 
would be easily doable with git-svn.

I have a repository which contains at the moment 5 eclipse projects. two 
of them are directly in the svn root and i'm not interested in them. the 
other three are mine and I'd like to use them as separate eclipse 
projects as i currently do when i check them out as seperate projects 
into the workspace with subversive.

is this possible or should i just forget it.

Regards Michael

--------------ms060602010106050902040509
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKdjCC
BTcwggMfoAMCAQICAwa1/DANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wOTA0
MTAxNzIzNDlaFw0xMTA0MTAxNzIzNDlaMD4xFjAUBgNVBAMTDU1pY2hhZWwgR2FiZXIxJDAi
BgkqhkiG9w0BCQEWFU1pY2hhZWwuR2FiZXJAZ214Lm5ldDCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBANlvNCEKkhAhmwIpzXamq89nexUPZxbvGR05bN8NlABb/ZkrsUzq56ni
E4uA61Uuwz3stsXXPN5SOV+oJABDWgvgUsk4fZavEMbP7Kk5iJpZf+ZYDc+z+cYEgxLcQ/v2
I3j5r7sdT8L6KuB4mvJaQ2WLMcAzyE4J3b39IzPHjrKkTWHyNQP8UUVEJ8qIZ3oCNAYYkTar
2nKv9uCz//ne40luTpPaEi4vrV5x3F9VKLVLWp1pjceE2xC6wSRlF9ZouOhk6aefTeJ0zMCK
yiCxhk/4pDM5GfXePU7a05uP7NWtvFPPVt8ahIXoX4J4mRdxByijW1wIAqP2ghjL0IHWHlcC
AwEAAaOCAQEwgf4wDAYDVR0TAQH/BAIwADBWBglghkgBhvhCAQ0ESRZHVG8gZ2V0IHlvdXIg
b3duIGNlcnRpZmljYXRlIGZvciBGUkVFIGhlYWQgb3ZlciB0byBodHRwOi8vd3d3LkNBY2Vy
dC5vcmcwQAYDVR0lBDkwNwYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEE
AYI3CgMDBglghkgBhvhCBAEwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8v
b2NzcC5jYWNlcnQub3JnMCAGA1UdEQQZMBeBFU1pY2hhZWwuR2FiZXJAZ214Lm5ldDANBgkq
hkiG9w0BAQUFAAOCAgEAZy8jWlhd7lK824fomYsYCfGMwjgvJs8iW72U1ewbrc8FAd9974aS
cXBjz/eMQnAbwQUbAEcWrOnV+g1DVXLsN7i+ZSHyyHSpTIQ317MzWCw4WL8wxvf4SH1cssx8
jxbZQP6hSqNCXdeDr+EQEQ+FPvN2fIcCZLlKa8Pjh0SqL5PUZGKTN4/BGKO3pbiyUBHg0XlV
fF+rlJAkE9ybc4Y06rfXH1/BbgLxo6YgkJRoeysIKqyU/psOmVnEkxV9LPnJ/HS3iItCOZfI
6ziAc/i71WOgk2aLvIAfQ+T70sdHMkmYUPKNDgzA+bYJiD99n9GV2reDtbX3haDp6epOZKHt
257ZE9L4e3CprFw5zrvv/UEvFw3QsVelcr14FIwKOemLAXIfME4yuH8T9+O/joXDfscjoV89
j4jlGfVoUZfRoDn0MDgWNHU0tW1ZUsHhs4EE5GKS4Mf8aoWUEjxvEK/2BXitjyYBSU6GBxmg
1rsz1jJ1mUUKZT5EdLCmNH1Fwj6+l2a5XvHaKKf4crs8mNrH9kIWd8TvG56iqK0Ae1Dqi16s
KEtpe3yj1E6doSOJ4zwww78IW1euw68EBrx/+2YqdrT8S+W+oyFXnO8psZBJFgatDbeEzD76
A9tlb23O6XIjyu5O+RlQSkGsXe9FqZcNr3uAlEWl6QwfpAUvTu4SxUUwggU3MIIDH6ADAgEC
AgMGtfwwDQYJKoZIhvcNAQEFBQAweTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0
cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5
MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5vcmcwHhcNMDkwNDEwMTcyMzQ5WhcN
MTEwNDEwMTcyMzQ5WjA+MRYwFAYDVQQDEw1NaWNoYWVsIEdhYmVyMSQwIgYJKoZIhvcNAQkB
FhVNaWNoYWVsLkdhYmVyQGdteC5uZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDZbzQhCpIQIZsCKc12pqvPZ3sVD2cW7xkdOWzfDZQAW/2ZK7FM6uep4hOLgOtVLsM97LbF
1zzeUjlfqCQAQ1oL4FLJOH2WrxDGz+ypOYiaWX/mWA3Ps/nGBIMS3EP79iN4+a+7HU/C+irg
eJryWkNlizHAM8hOCd29/SMzx46ypE1h8jUD/FFFRCfKiGd6AjQGGJE2q9pyr/bgs//53uNJ
bk6T2hIuL61ecdxfVSi1S1qdaY3HhNsQusEkZRfWaLjoZOmnn03idMzAisogsYZP+KQzORn1
3j1O2tObj+zVrbxTz1bfGoSF6F+CeJkXcQcoo1tcCAKj9oIYy9CB1h5XAgMBAAGjggEBMIH+
MAwGA1UdEwEB/wQCMAAwVgYJYIZIAYb4QgENBEkWR1RvIGdldCB5b3VyIG93biBjZXJ0aWZp
Y2F0ZSBmb3IgRlJFRSBoZWFkIG92ZXIgdG8gaHR0cDovL3d3dy5DQWNlcnQub3JnMEAGA1Ud
JQQ5MDcGCCsGAQUFBwMEBggrBgEFBQcDAgYKKwYBBAGCNwoDBAYKKwYBBAGCNwoDAwYJYIZI
AYb4QgQBMDIGCCsGAQUFBwEBBCYwJDAiBggrBgEFBQcwAYYWaHR0cDovL29jc3AuY2FjZXJ0
Lm9yZzAgBgNVHREEGTAXgRVNaWNoYWVsLkdhYmVyQGdteC5uZXQwDQYJKoZIhvcNAQEFBQAD
ggIBAGcvI1pYXe5SvNuH6JmLGAnxjMI4LybPIlu9lNXsG63PBQHffe+GknFwY8/3jEJwG8EF
GwBHFqzp1foNQ1Vy7De4vmUh8sh0qUyEN9ezM1gsOFi/MMb3+Eh9XLLMfI8W2UD+oUqjQl3X
g6/hEBEPhT7zdnyHAmS5SmvD44dEqi+T1GRikzePwRijt6W4slAR4NF5VXxfq5SQJBPcm3OG
NOq31x9fwW4C8aOmIJCUaHsrCCqslP6bDplZxJMVfSz5yfx0t4iLQjmXyOs4gHP4u9VjoJNm
i7yAH0Pk+9LHRzJJmFDyjQ4MwPm2CYg/fZ/Rldq3g7W194Wg6enqTmSh7due2RPS+Htwqaxc
Oc677/1BLxcN0LFXpXK9eBSMCjnpiwFyHzBOMrh/E/fjv46Fw37HI6FfPY+I5Rn1aFGX0aA5
9DA4FjR1NLVtWVLB4bOBBORikuDH/GqFlBI8bxCv9gV4rY8mAUlOhgcZoNa7M9YydZlFCmU+
RHSwpjR9RcI+vpdmuV7x2iin+HK7PJjax/ZCFnfE7xueoqitAHtQ6oterChLaXt8o9ROnaEj
ieM8MMO/CFtXrsOvBAa8f/tmKna0/EvlvqMhV5zvKbGQSRYGrQ23hMw++gPbZW9tzulyI8ru
TvkZUEpBrF3vRamXDa97gJRFpekMH6QFL07uEsVFMYIDhzCCA4MCAQEwgYAweTEQMA4GA1UE
ChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlD
QSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2Vy
dC5vcmcCAwa1/DAJBgUrDgMCGgUAoIIB2zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0wOTA1MTIxOTU4MzZaMCMGCSqGSIb3DQEJBDEWBBSitNMYwnQh8JVu
EgP/7tLMUyBmeDBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBkQYJKwYBBAGCNxAE
MYGDMIGAMHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsTFWh0dHA6Ly93d3cuY2FjZXJ0
Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhvcml0eTEhMB8GCSqGSIb3DQEJ
ARYSc3VwcG9ydEBjYWNlcnQub3JnAgMGtfwwgZMGCyqGSIb3DQEJEAILMYGDoIGAMHkxEDAO
BgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsTFWh0dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UE
AxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhvcml0eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBj
YWNlcnQub3JnAgMGtfwwDQYJKoZIhvcNAQEBBQAEggEAa3wv84jhrNDq5RK1u9poHwp1AdDf
TW3zsS9CaDEbOfoDU2ZYeOhF8qc5eFLgDVf0dWPmgrS22rSZNJ9bZy0ujHxgrpzaqYzcRXFU
BPkhHvZaWXWucJ18YhGrsUl8KKhOk46c5qULNx6hsPwPZc3UO78Y0KAgiMklCCM7zbokqK3L
I2pUDu4PcWb+g+rb5y+RH86uvA5i2APBAS0hxJtASCuveVmVtUB8zADiM6+/NNFd7vh1tBXD
wTxnTy0jiYjufOuTq4GJIV79KZ+bW8GVOX4lFrd6Z5xrM0hox5NFaL6B3lgBXg074qdM5DhE
WS8bjmmG3ZHS859VRD3b8qrd6AAAAAAAAA==
--------------ms060602010106050902040509--
