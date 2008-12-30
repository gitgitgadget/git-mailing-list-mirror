From: Michael Gaber <Michael.Gaber@gmx.net>
Subject: Re: why still no empty directory support in git
Date: Tue, 30 Dec 2008 15:21:21 +0100
Message-ID: <495A2E61.3030702@gmx.net>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com> <alpine.DEB.1.00.0812301308530.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms090005030209070403020006"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 15:22:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHfUe-0000Te-73
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 15:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbYL3OVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 09:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbYL3OVZ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 09:21:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:47518 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752069AbYL3OVY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 09:21:24 -0500
Received: (qmail invoked by alias); 30 Dec 2008 14:21:22 -0000
Received: from e181201212.adsl.alicedsl.de (EHLO [192.168.178.68]) [85.181.201.212]
  by mail.gmx.net (mp047) with SMTP; 30 Dec 2008 15:21:22 +0100
X-Authenticated: #1286246
X-Provags-ID: V01U2FsdGVkX1+wEz91KeuwY57JGyxfbyWiMlMf3JpQu5xwYBAeXQ
	/zob7VkBu78ffF
User-Agent: Thunderbird 2.0.0.18 (X11/20081121)
In-Reply-To: <alpine.DEB.1.00.0812301308530.30769@pacific.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104187>

This is a cryptographically signed message in MIME format.

--------------ms090005030209070403020006
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Johannes Schindelin schrieb:
> Hi,
> 
> On Tue, 30 Dec 2008, Ping Yin wrote:
> 
>> Yes, i know this topic has been discussed for many times.
> 
> We have empty directory support in Git.  It works like this: for 
> directories that you do want to keep, you add an empty .gitignore file.
> 
> No problem at all,
> Dscho

well if i understood him correctly his use-case would soon remove that
.whatever-file so it doesn't solve the problem

Michael

--------------ms090005030209070403020006
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKdjCC
BTcwggMfoAMCAQICAwOSGTANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wNzA1
MTExODI5NDlaFw0wOTA1MTAxODI5NDlaMD4xFjAUBgNVBAMTDU1pY2hhZWwgR2FiZXIxJDAi
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
hkiG9w0BAQUFAAOCAgEAzOZBrP0g6O72GC4sUht1eAe6QIKHlf4j+c2+mOOB1MHnIi1NHIvD
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
ChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlD
QSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2Vy
dC5vcmcCAwOSGTAJBgUrDgMCGgUAoIIB6DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0wODEyMzAxNDIxMjFaMCMGCSqGSIb3DQEJBDEWBBTagmeTi+bvwlua
DHltXTMLXscMGjBfBgkqhkiG9w0BCQ8xUjBQMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAO
BggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgw
gZEGCSsGAQQBgjcQBDGBgzCBgDB5MRAwDgYDVQQKEwdSb290IENBMR4wHAYDVQQLExVodHRw
Oi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkx
ITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZwIDA5IZMIGTBgsqhkiG9w0BCRAC
CzGBg6CBgDB5MRAwDgYDVQQKEwdSb290IENBMR4wHAYDVQQLExVodHRwOi8vd3d3LmNhY2Vy
dC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmluZyBBdXRob3JpdHkxITAfBgkqhkiG9w0B
CQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZwIDA5IZMA0GCSqGSIb3DQEBAQUABIIBAAQitZABMi6c
YiME6zuiJxMpmWfgHZCSAjTGsfg/L46KrDu4CvMhZaq2C7PpXTiYhgs70RV3+yXXzxrfjlI/
8w9g9AsdWNIp41TGFCR8wUjiF4oj3B7JrpVpJZPiMTclPmzUqkGu63Ub4vWntgtw4DsmDTJt
P7tviBhkzMVlXe6rdgfunT20xcG2Y5KNIDvjXCAJCFzx5wbUQDf1KZfoSzPxMHA2YYS/eDSt
7nLSJwfIAm7RmMYAKexfx3AKmnn79wFaUxwfNc8Kwqw94aU1BI+6pTisPjeHw0iLKfILnrXX
/lG3qIrOO+rR9S2WJxGPMjtQ0cbmpRNJxI59fDR8orYAAAAAAAA=
--------------ms090005030209070403020006--
