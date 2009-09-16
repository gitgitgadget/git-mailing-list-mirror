From: =?ISO-8859-1?Q?David_F=F6rster?= <david.foerster@andrena.de>
Subject: System wide gitattributes
Date: Wed, 16 Sep 2009 13:50:03 +0200
Message-ID: <4AB0D0EB.5080105@andrena.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070404070606060401090505"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 14:09:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MntK6-0001PY-8H
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 14:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758740AbZIPMIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 08:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756052AbZIPMIs
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 08:08:48 -0400
Received: from andrena-gate.antech.de ([194.45.12.12]:48480 "EHLO
	mail.andrena.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145AbZIPMIr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 08:08:47 -0400
X-Greylist: delayed 1114 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2009 08:08:46 EDT
Received: from e180068017.adsl.alicedsl.de ([85.180.68.17]:53323 helo=[10.23.17.3])
	by mail.andrena.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <david.foerster@andrena.de>)
	id 1Mnt1Y-0006Ct-C8
	for git@vger.kernel.org; Wed, 16 Sep 2009 13:50:13 +0200
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090706)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128647>

This is a cryptographically signed message in MIME format.

--------------ms070404070606060401090505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

from the documentation I understand that things like external diff tools 
can be set up in a gitattributes file per repository (or subfolder).

Why is there no support for a ~/.gitattributes file? This would be very 
handy, for example to always get a textual diff of OpenDocument files.

Regards,
  - David

ps: Please cc, I'm not on the list.

--------------ms070404070606060401090505
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJWTCC
AwcwggJwoAMCAQICEDcd5gie7PrcRPlfCvRF5KQwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA5MDMzMDE2Mjk1MFoX
DTEwMDMzMDE2Mjk1MFowZjERMA8GA1UEBBMIRm9lcnN0ZXIxDjAMBgNVBCoTBURhdmlkMRcw
FQYDVQQDEw5EYXZpZCBGb2Vyc3RlcjEoMCYGCSqGSIb3DQEJARYZZGF2aWQuZm9lcnN0ZXJA
YW5kcmVuYS5kZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALq8RhBkgiWoh4Gg
5ddt9iY479dd80nB6LTYOw2cR7N8dP5VEW62Jtxq9F2JT0GoLh/PhJW1Z0ie+vh+i4cuk5wP
yYzOGfQMaz7qgMXIrcZcueanRumM4JppzhR0VuW9civ50hUo18ovlNAMKl1qwds5l4JhpSSV
eo5onm8krKHOvjaUsghGTyI4UxarH1rBUo5o8l/tRrDnKVJ4STwiZ3k96lWNxj1/6+z49w5M
aXXJ2rG5yeLIExGJNsDFvqGi+QKdO7HYGobjHHoLm2+uWP8DY89dbaco/zGnjE4N0E6linT1
IpyjqumW5Es74opggZldUze0iJl3AniC4bBKOQ0CAwEAAaM2MDQwJAYDVR0RBB0wG4EZZGF2
aWQuZm9lcnN0ZXJAYW5kcmVuYS5kZTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GB
AH5TPp1DcoDFJgpRtm+DE5LeRTsnqGnG06oW0jVZksQxzqbC853pVsWDm5h3Hnaifu6sIpSl
hGMTzM0zh2Nn8OQdyRD47sj+m+mpWxKxzWa1CdiEUSRVnA6ZsVM6P1JmrO52jeR+sL7t8j2g
8h+IVm4n5p9zJYLootv7f+UzEj9rMIIDBzCCAnCgAwIBAgIQNx3mCJ7s+txE+V8K9EXkpDAN
BgkqhkiG9w0BAQUFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRp
bmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vp
bmcgQ0EwHhcNMDkwMzMwMTYyOTUwWhcNMTAwMzMwMTYyOTUwWjBmMREwDwYDVQQEEwhGb2Vy
c3RlcjEOMAwGA1UEKhMFRGF2aWQxFzAVBgNVBAMTDkRhdmlkIEZvZXJzdGVyMSgwJgYJKoZI
hvcNAQkBFhlkYXZpZC5mb2Vyc3RlckBhbmRyZW5hLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAurxGEGSCJaiHgaDl1232Jjjv113zScHotNg7DZxHs3x0/lURbrYm3Gr0
XYlPQaguH8+ElbVnSJ76+H6Lhy6TnA/JjM4Z9AxrPuqAxcitxly55qdG6YzgmmnOFHRW5b1y
K/nSFSjXyi+U0AwqXWrB2zmXgmGlJJV6jmiebySsoc6+NpSyCEZPIjhTFqsfWsFSjmjyX+1G
sOcpUnhJPCJneT3qVY3GPX/r7Pj3DkxpdcnasbnJ4sgTEYk2wMW+oaL5Ap07sdgahuMcegub
b65Y/wNjz11tpyj/MaeMTg3QTqWKdPUinKOq6ZbkSzviimCBmV1TN7SImXcCeILhsEo5DQID
AQABozYwNDAkBgNVHREEHTAbgRlkYXZpZC5mb2Vyc3RlckBhbmRyZW5hLmRlMAwGA1UdEwEB
/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAflM+nUNygMUmClG2b4MTkt5FOyeoacbTqhbSNVmS
xDHOpsLznelWxYObmHcedqJ+7qwilKWEYxPMzTOHY2fw5B3JEPjuyP6b6albErHNZrUJ2IRR
JFWcDpmxUzo/Umas7naN5H6wvu3yPaDyH4hWbifmn3Mlguii2/t/5TMSP2swggM/MIICqKAD
AgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5n
MSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZy
ZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcN
AQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHy
v1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsY
Pge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0T
AQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20v
VGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQe
MBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD
6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZ
GwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC
3CEZNd4ksdMdRv9dX2VPMYIDcTCCA20CAQEwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECEDcd5gie7PrcRPlfCvRF5KQwCQYFKw4DAhoFAKCCAdAw
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDkwOTE2MTE1MDAz
WjAjBgkqhkiG9w0BCQQxFgQUNA0Ne9NfaR9uY9g/jbCxtlw0AlcwXwYJKoZIhvcNAQkPMVIw
UDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMC
AgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNV
BAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQD
EyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQNx3mCJ7s+txE+V8K9EXk
pDCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUg
Q29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgSXNzdWluZyBDQQIQNx3mCJ7s+txE+V8K9EXkpDANBgkqhkiG9w0BAQEFAASCAQBZfrkc
2/Zo/R648P2ydJLQmnUXdVIVHtBkpRiaOo2w+MzS9mRNb1Qxej8zI67AXjT8+D/FgRtkYbQj
rxY2B8Z6hXjdv4zKn+RO3FbZjKoUuBpkbaFOSWB0NKqbbIFOyQLO1Putx+h3GVbFbK52rB59
dUZEyhKJt9iehHqKE+H0kAoFe6VueW1N8phZcLIckU7mMN+S2D2cWprLVtBDpqOl6JhVYkYJ
4G8pxYflFWku9oYn6ws9D4M5jRcvspYDA9b0CpygLYQEh0QjwqVsbFguuvBGasUOcn+D7123
pt3IKnHgjl37h6zGae8/m47QhrJDGqAtSKNrbUkyYqT4BqYkAAAAAAAA
--------------ms070404070606060401090505--
