From: "Laflen, Brandon (GE, Research)" <laflenb@ge.com>
Subject: fatal: Unable to find remote helper for 'http'
Date: Wed, 12 May 2010 11:08:27 -0400
Message-ID: <811C439C44639E429301EB1083399FA302F1853F@CINMLVEM12.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_01B3_01CAF1C3.72990C70"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 12 17:14:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCDdd-0006D0-Rn
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 17:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab0ELPOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 11:14:15 -0400
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:57506 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab0ELPOP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 11:14:15 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 May 2010 11:14:14 EDT
Received: from source ([4.78.218.129]) (using TLSv1) by exprod5ob104.postini.com ([64.18.4.12]) with SMTP
	ID DSNKS+rFxj1N5QHiPvDLpsa/uM8Kq88475kN@postini.com; Wed, 12 May 2010 08:14:14 PDT
X-GEattachmentname: smime.p7s
X-GEattachmentsize: 4411
Received: from unknown (HELO cinmlef06.e2k.ad.ge.com) ([3.159.213.37])
  by Cinmlip06.e2k.ad.ge.com with ESMTP; 12 May 2010 11:09:09 -0400
Received: from CINMLVEM12.e2k.ad.ge.com ([3.159.214.56]) by cinmlef06.e2k.ad.ge.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 12 May 2010 11:09:08 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: fatal: Unable to find remote helper for 'http'
Thread-Index: Acrx5PmC2iV8gbF9TL6CZBFCN+nRcQ==
X-OriginalArrivalTime: 12 May 2010 15:09:08.0344 (UTC) FILETIME=[11E3FF80:01CAF1E5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146953>

This is a multi-part message in MIME format.

------=_NextPart_000_01B3_01CAF1C3.72990C70
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I recently compiled git on a red-hat linux system.  There were not compile
errors.  But, when I try to use git to clone a repository, I receive the
following error:

	fatal: Unable to find remote helper for 'http'

I am behind a firewall and cannot use the "git" protocol.  I have
exhaustively tried variations of the http_proxy environmental variable,
without any visible difference.  As far as I am aware, there is no other
information to help me debug this problem.  Can someone please help me?


Thank you!


------=_NextPart_000_01B3_01CAF1C3.72990C70
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIOJTCCBIUw
ggNtoAMCAQICDwCnrgABAALhcPntw5ZiFzANBgkqhkiG9w0BAQUFADBZMQswCQYDVQQGEwJVUzEh
MB8GA1UEChMYR2VuZXJhbCBFbGVjdHJpYyBDb21wYW55MScwJQYDVQQDEx5HZW5lcmFsIEVsZWN0
cmljIENvbXBhbnkgQ0EgSUkwHhcNMTAwMzI2MjAwMDE3WhcNMTMwMzI2MjAwMDE3WjCBhjEhMB8G
A1UEChMYR2VuZXJhbCBFbGVjdHJpYyBDb21wYW55MRUwEwYDVQQLEwxHRSBDb3Jwb3JhdGUxEjAQ
BgNVBAUTCTIwMDAxNzM1MDEXMBUGA1UEAxMOQnJhbmRvbiBMYWZsZW4xHTAbBgkqhkiG9w0BCQEW
DmxhZmxlbmJAZ2UuY29tMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDV41jvDXI3hZJ+3N9n
VJCqpcEj9Ix/aikuzjpPLlExUan/rzjGtwHCat1g0YFNZEVa8LMTihr1wXtLq70V1j9mrFU+fSU4
bPH1d4zf7OLNLE4OTltTFs+REAQ1tUn5H92VBGvw51AA5jcbELxi40Mm944KGJITQ0FU7HVxoObK
nQIDAQABo4IBnjCCAZowSAYIKwYBBQUHAQEEPDA6MDgGCCsGAQUFBzABhixodHRwOi8vb2NzcC5n
ZS1JSS50Y2NsYXNzMi1JSS50cnVzdGNlbnRlci5kZTCBlwYDVR0jBIGPMIGMoXqkeDB2MQswCQYD
VQQGEwJERTEcMBoGA1UEChMTVEMgVHJ1c3RDZW50ZXIgR21iSDEiMCAGA1UECxMZVEMgVHJ1c3RD
ZW50ZXIgQ2xhc3MgMiBDQTElMCMGA1UEAxMcVEMgVHJ1c3RDZW50ZXIgQ2xhc3MgMiBDQSBJSYIO
HsAAAQACtSlPIGgUUMswDgYDVR0PAQH/BAQDAgTwMB0GA1UdDgQWBBRRJppCVsZO4ucUpLPzYFzX
Oi29SDBLBgNVHR8ERDBCMECgPqA8hjpodHRwOi8vd3d3LnRydXN0Y2VudGVyLmRlL2NybC92Mi90
Y19jbGFzczJfTDFfQ0FfR0VfSUkuY3JsMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAZ
BgNVHREEEjAQgQ5sYWZsZW5iQGdlLmNvbTANBgkqhkiG9w0BAQUFAAOCAQEAbjgSfy2fAdp/HzCV
v9TW7nzotQ7+c/mZBMokTtdqt3ciiOZ3BBXH2yUk58ygMyJerP9FKh3QXSs2ZUFKlF1dFlspDfML
3/SgD8gUA9KGuGkEBA7y0VQhthztwuXuQlBaOZTcJWciJN7kh/QDj55pyF6LPKZGl/0ufdJgIBc0
t5ll+ANeSBiGB+MYGQo3GxgSz/x+bc1NbT6D8OORla0M6M9PA9OZZfsoTnJ03I71dIuG0oaphvZ3
fdAkmv8uzW0bg0yiLRMUOCbpFH0k3CAzL2mtaGHpP1uzZZjDVydoTPfpjOv8ydV5dcPAJRDDCQfW
VBYV6O+72dGb7LtTqbODwzCCBKowggOSoAMCAQICDi5qAAEAAh/XUiEsEVw7MA0GCSqGSIb3DQEB
BQUAMHYxCzAJBgNVBAYTAkRFMRwwGgYDVQQKExNUQyBUcnVzdENlbnRlciBHbWJIMSIwIAYDVQQL
ExlUQyBUcnVzdENlbnRlciBDbGFzcyAyIENBMSUwIwYDVQQDExxUQyBUcnVzdENlbnRlciBDbGFz
cyAyIENBIElJMB4XDTA2MDExMjE0Mzg0M1oXDTI1MTIzMTIyNTk1OVowdjELMAkGA1UEBhMCREUx
HDAaBgNVBAoTE1RDIFRydXN0Q2VudGVyIEdtYkgxIjAgBgNVBAsTGVRDIFRydXN0Q2VudGVyIENs
YXNzIDIgQ0ExJTAjBgNVBAMTHFRDIFRydXN0Q2VudGVyIENsYXNzIDIgQ0EgSUkwggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCrgIebjvDDfIfX6CSCEbM83UNi7vjDRdro4aBf0Sqy6pNo
37TI1kPpxHVZf/zhHfgxcCMbiJ4nuXv9OtLJqekUL5C+A1LBSc32/eQIZgtXiqJCoLjVf2lckDKy
lw3KStxGPgJViVPjGlrLNsYHVveMzxH0TLswcASVpfY5jP1zgQh9iV4yHiKpIkVLsGYuMMyfZf38
y4Gp8eA7r6OG0YnqxEV5UF2u6SF0kk2LWYKPlOPpSvHnSbAU4/Viy9VyvR+50p+gzaj6AcjZDd/a
/Eeds8hU30lK8SGp/hhO7kjUGbvvfeTinctbtm7/481a53SCBbqAJTjL5Gmer0GqGoT1AgMBAAGj
ggE0MIIBMDAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQU46tUTICh
21ZDt5FKy/OCehNcCKswge0GA1UdHwSB5TCB4jCB36CB3KCB2YY1aHR0cDovL3d3dy50cnVzdGNl
bnRlci5kZS9jcmwvdjIvdGNfY2xhc3NfMl9jYV9JSS5jcmyGgZ9sZGFwOi8vd3d3LnRydXN0Y2Vu
dGVyLmRlL0NOPVRDJTIwVHJ1c3RDZW50ZXIlMjBDbGFzcyUyMDIlMjBDQSUyMElJLE89VEMlMjBU
cnVzdENlbnRlciUyMEdtYkgsT1U9cm9vdGNlcnRzLERDPXRydXN0Y2VudGVyLERDPWRlP2NlcnRp
ZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT8wDQYJKoZIhvcNAQEFBQADggEBAIzX337uG4AQs4P1
2xHqa0uokhjZ9wc59Sy+BnV6aFMVHOpK7V78I7IToNMJ//b2LmtBcXnN4m39rllrhR24TiKa7WY5
bkuU5lX8CxuLd8FTE2aJ2SjWi/NFSmO3/XsLYV24bb7D3Ft50u2G5aJNvl50fGrtFjgff1iBWhrr
MogtsvM5d4CvXrZhdSnbI02IylAoy4XS0xCiWW7Tk1QAeqJGlYYFnKkZmOUxcgwA4mfZQOAkM3tv
LLlcq2WdLKx26jWZ9Ze5DyTsx3YhKGWuV+gHiHVKVqDSBTqk5o2SiCzz8uHBxmHbQcXHm/cOGlFF
wmFr3GQnF4xat9p0KM2X5L0wggTqMIID0qADAgECAg4ewAABAAK1KU8gaBRQyzANBgkqhkiG9w0B
AQUFADB2MQswCQYDVQQGEwJERTEcMBoGA1UEChMTVEMgVHJ1c3RDZW50ZXIgR21iSDEiMCAGA1UE
CxMZVEMgVHJ1c3RDZW50ZXIgQ2xhc3MgMiBDQTElMCMGA1UEAxMcVEMgVHJ1c3RDZW50ZXIgQ2xh
c3MgMiBDQSBJSTAeFw0wODA1MDgxMTM4MjBaFw0yNTEyMzEyMjU5NTlaMFkxCzAJBgNVBAYTAlVT
MSEwHwYDVQQKExhHZW5lcmFsIEVsZWN0cmljIENvbXBhbnkxJzAlBgNVBAMTHkdlbmVyYWwgRWxl
Y3RyaWMgQ29tcGFueSBDQSBJSTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAN3EFluK
unJnRRBtTM0lSmTDHxxHJPRGFuYZNpjfCbaLqiSBvCvV7x9PEqDXMi2UI2as2wGcw3zaNnbv9EU0
FTeCsYbjEBeDxINLLnXwYMxUFBdDrOEG4xs9PuibkmaDiA/kWKsydaJKMQysE9ysDz8vniRETc7q
HtMX+x/k/RF9bIB9eFe57ntFO1TvuAo7eX9cjJdjwyQ4j6nooxgbS9ZEryHq0VHRReKLhZd0IpkU
tBs3uIOk7Aa6HZDLWz30ogJmcXkqiK7x/HzPAgP11jshX0ygYIm9Fc/2KHM18kmDGlQI4TGnfx4e
4KBkAPf7v4HRUPNrABqxIdu2MfPjN+0CAwEAAaOCAZEwggGNMIGVBggrBgEFBQcBAQSBiDCBhTBP
BggrBgEFBQcwAoZDaHR0cDovL3d3dy50cnVzdGNlbnRlci5kZS9jZXJ0c2VydmljZXMvY2FjZXJ0
cy90Y19jbGFzc18yX2NhX0lJLmNydDAyBggrBgEFBQcwAYYmaHR0cDovL29jc3AudGNjbGFzczIt
SUkudHJ1c3RjZW50ZXIuZGUwHwYDVR0jBBgwFoAU46tUTICh21ZDt5FKy/OCehNcCKswDwYDVR0T
AQH/BAUwAwEB/zBKBgNVHSAEQzBBMD8GCSqCFAAsAQEBAjAyMDAGCCsGAQUFBwIBFiRodHRwOi8v
d3d3LnRydXN0Y2VudGVyLmRlL2d1aWRlbGluZXMwDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQV
uwKpCYhgCHKQWmaWSLAZvoocujBGBgNVHR8EPzA9MDugOaA3hjVodHRwOi8vd3d3LnRydXN0Y2Vu
dGVyLmRlL2NybC92Mi90Y19jbGFzc18yX2NhX0lJLmNybDANBgkqhkiG9w0BAQUFAAOCAQEAndA+
6h34wI6SaGn++LTny56uPuvvv635XVPL7AJ+/+KgaCfrrbtXAqbxBewpOgGp1M2LXtBRufD+eCuw
+5h1UvrQ1tynrDQDvn2Tq0hNj3ZVAQPefbRW5K23Or6UoDLFUq+lRzR4ptQVS48hgn8ennKMQPQl
+YJa1ndE/5t8dK96qxZu9dbVK0iw69GGkeafJvJB9nLEjBtVbt7Jbn9kpYUBiz5LeSVQVvfVg1D+
xZqDs1lJp3n4LzRwr24qliX3Ewnt/YJxT7GYL2+vizuPwUENURMhFB4g/WX33/tV7IJmni69BdCF
7EnYwlk5CNwd+xO3iqe6vB2rbg1aJh24DjGCAtgwggLUAgEBMGwwWTELMAkGA1UEBhMCVVMxITAf
BgNVBAoTGEdlbmVyYWwgRWxlY3RyaWMgQ29tcGFueTEnMCUGA1UEAxMeR2VuZXJhbCBFbGVjdHJp
YyBDb21wYW55IENBIElJAg8Ap64AAQAC4XD57cOWYhcwCQYFKw4DAhoFAKCCAcIwGAYJKoZIhvcN
AQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTAwNTEyMTUwODI3WjAjBgkqhkiG9w0B
CQQxFgQULoGuZhUdGUlbeciCkIXX2ku8aGswZwYJKoZIhvcNAQkPMVowWDAKBggqhkiG9w0DBzAO
BggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwBwYF
Kw4DAhowCgYIKoZIhvcNAgUwewYJKwYBBAGCNxAEMW4wbDBZMQswCQYDVQQGEwJVUzEhMB8GA1UE
ChMYR2VuZXJhbCBFbGVjdHJpYyBDb21wYW55MScwJQYDVQQDEx5HZW5lcmFsIEVsZWN0cmljIENv
bXBhbnkgQ0EgSUkCDwCnrgABAALhcPntw5ZiFzB9BgsqhkiG9w0BCRACCzFuoGwwWTELMAkGA1UE
BhMCVVMxITAfBgNVBAoTGEdlbmVyYWwgRWxlY3RyaWMgQ29tcGFueTEnMCUGA1UEAxMeR2VuZXJh
bCBFbGVjdHJpYyBDb21wYW55IENBIElJAg8Ap64AAQAC4XD57cOWYhcwDQYJKoZIhvcNAQEBBQAE
gYCHQGmVXK6BhzUzulNrRCh+SpFeFSGylnlX3MBBCxhFCSI03Pj7iUjOOwtI5NdA5foEO4uwCi+P
2qKk2sewiyYPYYh4ic5k2/IVeNn3jRwrFS1fhzIqalqzIzj6MmbknMTlpHjkQLQFpdV+CSiG9chH
077MX0KL3B7CgcNqIiEgEgAAAAAAAA==

------=_NextPart_000_01B3_01CAF1C3.72990C70--
