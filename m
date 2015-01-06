From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Software CM Tool Inquiry
Date: Tue, 6 Jan 2015 09:25:28 -0500
Organization: PD Inc
Message-ID: <016179F343EA4CAFBA26AC9A22AA07C9@black>
References: <3731758D3E7DE64E8AD464CD29B8CE8709D15E8F@NAEACRANXM02V.nadsusea.nads.navy.mil>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="----=_NextPart_000_0127_01D02992.B24B0790";
	micalg=SHA1;
	protocol="application/x-pkcs7-signature"
Cc: <git@vger.kernel.org>
To: "'Campbell, Polly R CTR Maritime EW Sys Div, WXMP'" 
	<polly.campbell.ctr@navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 06 15:28:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8V4r-0002ZU-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 15:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbbAFOZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 09:25:41 -0500
Received: from mail.pdinc.us ([67.90.184.27]:50942 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755236AbbAFOZk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 09:25:40 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id t06EPUr5026700;
	Tue, 6 Jan 2015 09:25:31 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <3731758D3E7DE64E8AD464CD29B8CE8709D15E8F@NAEACRANXM02V.nadsusea.nads.navy.mil>
Thread-Index: AdApuMhIF2Cv+Hu2QWG95mQcaSu1XAAAtwAQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262066>

This is a multi-part message in MIME format.

------=_NextPart_000_0127_01D02992.B24B0790
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Responses inline.
> -----Original Message-----
> From: Campbell, Polly R CTR Maritime EW Sys Div, WXMP
> Sent: Tuesday, January 06, 2015 8:58
> 
> To Whom It May Concern,
> 
> We are a software support activity for a system that is 
> loaded on a majority of the ships in the navy fleet; I am 
> looking for a CM software tool with the following 
> capabilities to meet our requirements:
> 
> -	Be able to upload unclassified and classified software 
> in a central location where everyone in our group could have 
> access to being able to see and/or pull down the media.  This 
> would require an instance on both enclaves, UNCLASS and CLASSIFIED.
> 

This list is not the best place to discuss that.

> -	Be able to see each item's contents along with 
> submitter, date submitted and size.

Yes git can do that, but...

> 
> -	Lots of storage available with robust 
> inventory/tracking system.  We would like to store a copy of 
> each hard drive in our systems for each configuration.
> 

Git is designed to be a source tracking system, but others do use it for large objects.

> -	Procedure accessibility: Procedures should be organized 
> in an accessible format so that when performing a task, the 
> individuals will be able to quickly find/access the actual 
> procedure needing to be used. 

Do you mean a form of workflow?

> 
> -	Software baselines will need to be tracked, both raw 
> source code, and the compiled install disk.
> We can exclude hard drives that are easy to recreate.
> 
> We are interested in reviewing software packages to determine 
> what will fit our needs.
> 

Again, git is an open source tool and project, not a vendor. You are not going to get a sources sought response from the project proper. If you would like I can help you off list, as this is type of work I supported for DISA and other COCOMs / Agencies.

> Thank you,
> Polly
> 
> 
> Polly Campbell
> Applied Logistics Services, Inc.
> Code WXM, Bldg. 3330S
> Crane Division NSWC
> 300 Hwy 361
> Crane, IN 47522-5001
> Office: 812.854.8206
> Fax: 812.854.6570
> Email: polly.campbell.ctr@navy.mil
> SIPR: polly.campbell@navy.smil.mil
> 
> 
> 

v/r,

Jason Pyeron
202-741-9397

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00. 

------=_NextPart_000_0127_01D02992.B24B0790
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
CmCGSAFlAwIBDAIwDAYKYIZIAWUDAgEMAzCBwAYDVR0fBIG4MIG1MCygKqAohiZodHRwOi8vY3Js
LmRpc2EubWlsL2NybC9FQ0FST09UQ0EyLmNybDCBhKCBgaB/hn1sZGFwOi8vY3JsLmdkcy5kaXNh
Lm1pbC9jbiUzZEVDQSUyMFJvb3QlMjBDQSUyMDIlMmNvdSUzZEVDQSUyY28lM2RVLlMuJTIwR292
ZXJubWVudCUyY2MlM2RVUz9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0O2JpbmFyeTCB0wYIKwYB
BQUHAQEEgcYwgcMwOgYIKwYBBQUHMAKGLmh0dHA6Ly9jcmwuZGlzYS5taWwvaXNzdWVkdG8vRUNB
Uk9PVENBMl9JVC5wN2MwgYQGCCsGAQUFBzAChnhsZGFwOi8vY3JsLmdkcy5kaXNhLm1pbC9jbiUz
ZEVDQSUyMFJvb3QlMjBDQSUyMDIlMmNvdSUzZEVDQSUyY28lM2RVLlMuJTIwR292ZXJubWVudCUy
Y2MlM2RVUz9jcm9zc0NlcnRpZmljYXRlUGFpcjtiaW5hcnkwDQYJKoZIhvcNAQEFBQADggEBAAgE
rwyRj0AJ3jSCiUPgB2NyvxQhKhjfcNXSZWCQB7Fm7Dz+Z7NwNmDtCUTzr1jjLWF+raQe/2wRqVqH
RRIP/43fg4Y4DczjW9l2AghSJwssI0mw+VvHKwMSfffRV5VkUUaLHjlzBMFKm+U6I8IYfXRDlivp
b4jDOsjVO4MbEE4A6qT+4xQkyKvu5bJhNOUMhmZH+6WfLKS+q4ZDQH8RUYPNFxB6MS5sQFPP+d7w
og8grAsJD3s3SZAImKWWOaYJK8975BjMGK/LWLAnsFAneKTCH15EfEHsKNyK+lhMATH0BugSey8e
OipODRXrXfNpQcBpNoxTgn9sR0pYBffWXiMwggZQMIIFOKADAgECAgJgijANBgkqhkiG9w0BAQUF
ADBwMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNFQ0Ex
IjAgBgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRpZXMxFTATBgNVBAMTDE9SQyBFQ0EgSFcg
NDAeFw0xNDAzMjExNDQ5NTVaFw0xNTAzMjExNDQ5NTVaMIGDMQswCQYDVQQGEwJVUzEYMBYGA1UE
ChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNFQ0ExDDAKBgNVBAsTA09SQzEPMA0GA1UECxMG
UEQgSW5jMS0wKwYDVQQDEyRQeWVyb24uSmFzb24uSi5PUkMxMDAwMDQwMDA5LkVuY3J5cHQwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCHVGq6phwNUEI94zOPAen5rvUdObUTzuwHMwEw
L9wmvWktZ0Zj8ONcWrYLfr+H9YSEf3H0rKbJinu8YXqP0KwKZPm7+5zMqfHW3nE95IyKSYaq9YiM
Fi1VBKijmxEdO5NZCpFANtCaa0GUI78GI6PrBK9Q2qTTSU281cmr4TXSBfg+D6c9Af+ZPCsqJnEi
nv75M4ujeYkgF5Q+yFY6xCfPWlOPSjkpCyFuDqLG7G8mI4BHTuCiPNazURh7uQVidqrm6lZgco+M
QifyvEw2FMKKI59YYTMuukwCmZXZHY7xgUsx1zY3UofZ7G75xCSIa+KIg3WiTwF4ZDlvkGbzJxgn
AgMBAAGjggLeMIIC2jAfBgNVHSMEGDAWgBRbVMHfW3fdLfTnYG0RuJrIXAzn6TAdBgNVHQ4EFgQU
o/cER+2FSXj3xSAACMzkFCxkMLYwggEjBggrBgEFBQcBAQSCARUwggERMB4GCCsGAQUFBzABhhJo
dHRwOi8vZXZhLm9yYy5jb20wMgYIKwYBBQUHMAKGJmh0dHA6Ly9lY2Eub3JjLmNvbS9jYUNlcnRz
L0VDQS1IVzQucDdjMIG6BggrBgEFBQcwAoaBrWxkYXA6Ly9lY2EtZHMub3JjLmNvbS9jbiUzZE9S
QyUyMEVDQSUyMEhXJTIwNCUyY291JTNkQ2VydGlmaWNhdGlvbiUyMEF1dGhvcml0aWVzJTJjb3Ul
M2RFQ0ElMmNvJTNkVS5TLiUyMEdvdmVybm1lbnQlMmNjJTNkVVM/Y0FDZXJ0aWZpY2F0ZTtiaW5h
cnksY3Jvc3NDZXJ0aWZpY2F0ZVBhaXI7YmluYXJ5MA4GA1UdDwEB/wQEAwIFIDAbBgNVHREEFDAS
gRBqcHllcm9uQHBkaW5jLnVzMDMGA1UdIAQsMCowDAYKYIZIAWUDAgEMATAMBgpghkgBZQMCAQwC
MAwGCmCGSAFlAwIBDAMwgfEGA1UdHwSB6TCB5jAroCmgJ4YlaHR0cDovL2VjYS5vcmMuY29tL0NS
THMvT1JDRUNBSFc0LmNybDCBtqCBs6CBsIaBrWxkYXA6Ly9lY2EtZHMub3JjLmNvbTozODkvY24l
M0RPUkMlMjBFQ0ElMjBIVyUyMDQlMkMlMjBvdSUzRENlcnRpZmljYXRpb24lMjBBdXRob3JpdGll
cyUyQyUyMG91JTNERUNBJTJDJTIwbyUzRFUuUy4lMjBHb3Zlcm5tZW50JTJDJTIwYyUzRFVTP2Nl
cnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q7YmluYXJ5MBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMC
VVMwDQYJKoZIhvcNAQEFBQADggEBAMHBMK1AgK67iB22i3RXU9GmWaWr3EN57rSCDL+KqBvkZqBm
K6NpnB+ka3kfhnv6KQCno2cQlup6miwd43td7J/WVTYxQCHhBWpf163SIl50ZvbtmNU/eFkhEu+Q
x+NQ6U8vf8Tur6RXheMlBW34FwJ3VrxpuF1vPg9ntUGfNl36sgcbNjc7rL/t8EhgXGVyKRQI4X4D
ZBw+txM425OFoY2RRkuf1rB8EMA1HPUsAMRt5rSgLLplt2mrbrMaiG7cO0SFQjgAGOgb2ZXrX/Mp
POu4R78vjhQacrzXSoAHoMG72QJ9C1Kn9FyhjYhDzSIsffQF48QRq1bciseiOBeSnh8wggabMIIF
g6ADAgECAgJgiTANBgkqhkiG9w0BAQUFADBwMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBH
b3Zlcm5tZW50MQwwCgYDVQQLEwNFQ0ExIjAgBgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRp
ZXMxFTATBgNVBAMTDE9SQyBFQ0EgSFcgNDAeFw0xNDAzMjExNDQ4NDVaFw0xNTAzMjExNDQ4NDVa
MH4xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0VDQTEM
MAoGA1UECxMDT1JDMQ8wDQYDVQQLEwZQRCBJbmMxKDAmBgNVBAMTH1B5ZXJvbi5KYXNvbi5KLk9S
QzEwMDAwNDAwMDkuSUQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCIL0F8IDr6w0UP
8SQyeCpzFSQCTX+1oekpZImxMYChSJaRY5NQUlRHh9gnTM1r49repFVI+HFOJogavB0zUS3TVXp0
r23kwgHWAjiiyagdwsfEgWObIx4FLUaVOYNYO777kxk/Nydo7S1+4qrV0DFpLuQC1Gsh9F4s8+9F
dUNjkLXjf04fBufMz3ks+O271KnbZKtdmroWtzUxO2w8B90JCQJQbOAwtiyXC6KTCf5QcucHUX04
fyBbKJxItSF13MAIxViGzK+/eWYdajW5Ni6EQ10LpOgJwCzYCCZONrPbFJ+EklJCF3DwzlnMoID9
zYFwVqSExIFV6uUlZ/xAOiaNAgMBAAGjggMvMIIDKzAfBgNVHSMEGDAWgBRbVMHfW3fdLfTnYG0R
uJrIXAzn6TAdBgNVHQ4EFgQUnGL5UXepgybvXuqzlqGkL1YvyH4wggEjBggrBgEFBQcBAQSCARUw
ggERMB4GCCsGAQUFBzABhhJodHRwOi8vZXZhLm9yYy5jb20wMgYIKwYBBQUHMAKGJmh0dHA6Ly9l
Y2Eub3JjLmNvbS9jYUNlcnRzL0VDQS1IVzQucDdjMIG6BggrBgEFBQcwAoaBrWxkYXA6Ly9lY2Et
ZHMub3JjLmNvbS9jbiUzZE9SQyUyMEVDQSUyMEhXJTIwNCUyY291JTNkQ2VydGlmaWNhdGlvbiUy
MEF1dGhvcml0aWVzJTJjb3UlM2RFQ0ElMmNvJTNkVS5TLiUyMEdvdmVybm1lbnQlMmNjJTNkVVM/
Y0FDZXJ0aWZpY2F0ZTtiaW5hcnksY3Jvc3NDZXJ0aWZpY2F0ZVBhaXI7YmluYXJ5MA4GA1UdDwEB
/wQEAwIGwDApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIwQQYDVR0R
BDowOIEQanB5ZXJvbkBwZGluYy51c6AkBgorBgEEAYI3FAIDoBYMFE9SQzEwMDAwNDAwMDlARE9E
RUNBMDMGA1UdIAQsMCowDAYKYIZIAWUDAgEMATAMBgpghkgBZQMCAQwCMAwGCmCGSAFlAwIBDAMw
gfEGA1UdHwSB6TCB5jAroCmgJ4YlaHR0cDovL2VjYS5vcmMuY29tL0NSTHMvT1JDRUNBSFc0LmNy
bDCBtqCBs6CBsIaBrWxkYXA6Ly9lY2EtZHMub3JjLmNvbTozODkvY24lM0RPUkMlMjBFQ0ElMjBI
VyUyMDQlMkMlMjBvdSUzRENlcnRpZmljYXRpb24lMjBBdXRob3JpdGllcyUyQyUyMG91JTNERUNB
JTJDJTIwbyUzRFUuUy4lMjBHb3Zlcm5tZW50JTJDJTIwYyUzRFVTP2NlcnRpZmljYXRlUmV2b2Nh
dGlvbkxpc3Q7YmluYXJ5MBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMCVVMwDQYJKoZIhvcNAQEF
BQADggEBAIdJ0/H8HR4YWUR+61QOVO7TZEcQ42QYzLU6910C8voTytaHKu1SWNMbsBaw/mmYK/ez
+mFuXO39eRUYmSoaZk9KmvTG4kALL21ETRdAIUmgLl039qDP3ASLyPHa9KLleJCmxNpK6QnRhvqp
MItvJX9Ly8nUdRTs9fiy5am4+Zh0lNaQNeelW70pEEWPbR1EXyD/vfueIccOic/A9NrGf7P1MjgF
qAhUbPuTwD5DiCcxItvi6uiIx3ykyM45TzEZSKZSWMwxMY3UGno4oEEtiJSEOhWYAj6hypGgm8xE
wAb/AGWgDYwdRl5zQm6v+f4OdLm85iX3oaztaaj+IKarJIcxggNqMIIDZgIBATB2MHAxCzAJBgNV
BAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0VDQTEiMCAGA1UECxMZ
Q2VydGlmaWNhdGlvbiBBdXRob3JpdGllczEVMBMGA1UEAxMMT1JDIEVDQSBIVyA0AgJgiTAJBgUr
DgMCGgUAoIIByTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNTAx
MDYxNDI1MjJaMCMGCSqGSIb3DQEJBDEWBBSTCW3LSA2Gk9A8dO2M6akkvY+h/zBYBgkqhkiG9w0B
CQ8xSzBJMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDAHBgUrDgMCGjAKBggqhkiG9w0CBTCBhQYJKwYBBAGCNxAEMXgwdjBwMQswCQYDVQQGEwJVUzEY
MBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNFQ0ExIjAgBgNVBAsTGUNlcnRpZmlj
YXRpb24gQXV0aG9yaXRpZXMxFTATBgNVBAMTDE9SQyBFQ0EgSFcgNAICYIowgYcGCyqGSIb3DQEJ
EAILMXigdjBwMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQL
EwNFQ0ExIjAgBgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRpZXMxFTATBgNVBAMTDE9SQyBF
Q0EgSFcgNAICYIowDQYJKoZIhvcNAQEBBQAEggEAdqJHGpIHR1lpu5PvY9OXCPO+uOqkHWMHUdfl
DmELI4bpu+jNZzA64k0P3uuVEWCJM2H8QUbbTGoRngTIEBu8PkPwbU5YNnYPpFnckIjH4+HtOlve
x4HpcUDFWq0dXRCoCCsH5enXXPZmWMqDj+1EGAL4gSjSHPujJSAkREJEeXFxyXuuFR2s2OyZTKpg
on4dtLhFHFIr6iU1lCkDHyJAVn/qfAArsCvStBx34xKvhlvyY17s7iVh8Bj/4fsPB0Eb3GWm/+Kn
KzfxrZ3vInBIiT+yepOOaadmkEkzuiuTpSlDM9Mr0p7ciHHOIF8cr01yxAhnBhT1ekSHim8qETh7
NQAAAAAAAA==

------=_NextPart_000_0127_01D02992.B24B0790--
