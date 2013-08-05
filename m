From: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: Re: [PATCH 1/3] Makefile: Fix APPLE_COMMON_CRYPTO with BLK_SHA1
Date: Mon, 05 Aug 2013 09:16:43 -0700
Message-ID: <43C3B9F4-9E43-4BE0-B683-8AF6E2E46EC6@apple.com>
References: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
 <1375718364-13824-2-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2C8C8111-AA11-4562-BB90-F06B9CCF1866";
 protocol="application/pkcs7-signature"; micalg=sha1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:17:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6NTo-0001VK-C5
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab3HEQQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 12:16:59 -0400
Received: from mail-out.apple.com ([17.151.62.51]:62333 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab3HEQQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 12:16:57 -0400
Received: from relay2.apple.com ([17.128.113.67])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTP id <0MR2003TPFVH0V20@mail-out.apple.com> for git@vger.kernel.org;
 Mon, 05 Aug 2013 09:16:45 -0700 (PDT)
X-AuditID: 11807143-b7fb46d00000227e-97-51ffcfec7019
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)	by relay2.apple.com (Apple SCV relay)
 with SMTP id 47.40.08830.CEFCFF15; Mon, 05 Aug 2013 09:16:44 -0700 (PDT)
Received: from [10.0.20.112]
 (99-51-79-55.lightspeed.snjsca.sbcglobal.net [99.51.79.55])
 by koseret.apple.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPSA id <0MR200GL2FVVOG70@koseret.apple.com> for
 git@vger.kernel.org; Mon, 05 Aug 2013 09:16:44 -0700 (PDT)
In-reply-to: <1375718364-13824-2-git-send-email-brian@gernhardtsoftware.com>
X-Mailer: Apple Mail (2.1793.4)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsUiON1OXffN+f+BBos7LSy6rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJWxecE9toLPFhWzzm9gbGC8a9rFyMkhIWAiMXHlPEYIW0ziwr31
	bF2MXBxCAi1MEpMfP2WGcI4wSex7spYJxGEWmMIo8fzhSaAMBwevgIHE5wYfkG5hAQ+J/zMX
	gE1iA5p6689pFhCbU8BH4saapWwgNouAqkTnjzXMIDazgJtE/419rCA2r4CNxN81P6GW9TJK
	LN83hR0kISJgKDH35W+o8+Ql2n7/ZJvAyD8L2R2zEO6YBTZXXmL72zlgYWYBHYnJCxkhwqYS
	T95uZ4OwrSV+znkEFVeUmNL9kH0BI/sqRoGi1JzESiO9xIKCnFS95PzcTYygAG4odN7BeGyZ
	1SFGAQ5GJR5eBfb/gUKsiWXFlbmHGFWARjzasPoCoxRLXn5eqpII7/wtQGnelMTKqtSi/Pii
	0pzU4kOM0hwsSuK8FqG/A4UE0hNLUrNTUwtSi2CyTBycUg2MvZtUmDlmVy9++Gf2zMJffm33
	846buP5ud84wO1I9W3DxXZNVzXqMXXyfpfpeN+jPspVvubJxzrcfMz+3zy1bcvH8i8fXW66I
	HBIXFHfiYO04OvXGX8ndV9JYRILezVzl/+D0O5GZ5dxWkzImLG5Xkrl1V3D6vmO/db/f/PHj
	4IYU1f3+fz9YeCmxFGckGmoxFxUnAgDq/6zdaAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231670>


--Apple-Mail=_2C8C8111-AA11-4562-BB90-F06B9CCF1866
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Thanks Brian,

Reviewed-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>

On Aug 5, 2013, at 8:59, Brian Gernhardt <brian@gernhardtsoftware.com> wrote:

> It used to be that APPLE_COMMON_CRYPTO did nothing when BLK_SHA1 was
> set.  But APPLE_COMMON_CRYPTO is now used for more than just SHA1 (see
> 3ef2bca) so make sure that the appropriate libraries are always set.
> 
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
> Makefile | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 82f2e22..7051956 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1182,6 +1182,9 @@ ifdef NEEDS_SSL_WITH_CRYPTO
> else
> 	LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
> endif
> +ifdef APPLE_COMMON_CRYPTO
> +	LIB_4_CRYPTO += -framework Security -framework CoreFoundation
> +endif
> endif
> ifdef NEEDS_LIBICONV
> 	ifdef ICONVDIR
> @@ -1413,7 +1416,6 @@ ifdef PPC_SHA1
> 	LIB_H += ppc/sha1.h
> else
> ifdef APPLE_COMMON_CRYPTO
> -	LIB_4_CRYPTO += -framework Security -framework CoreFoundation
> 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
> 	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
> else
> -- 
> 1.8.4.rc1.384.g0976a17.dirty
> 


--Apple-Mail=_2C8C8111-AA11-4562-BB90-F06B9CCF1866
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIMezCCBjQw
ggQcoAMCAQICAR4wDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0
Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxKTAn
BgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3MTAyNDIxMDE1NVoX
DTE3MTAyNDIxMDE1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSsw
KQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFy
dENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMcJg8zOLdgasSmkLhOrlr6KMoOMpohBllVHrdRvEg/q6r8jR+EK
75xCGhR8ToREoqe7zM9/UnC6TS2y9UKTpT1v7RSMzR0t6ndl0TWBuUr/UXBhPk+Kmy7bI4yW4urC
+y7P3/1/X7U8ocb8VpH/Clt+4iq7nirMcNh6qJR+xjOhV+VHzQMALuGYn5KZmc1NbJQYclsGkDxD
z2UbFqE2+6vIZoL+jb9x4Pa5gNf1TwSDkOkikZB1xtB4ZqtXThaABSONdfmv/Z1pua3FYxnCFmdr
/+N2JLKutIxMYqQOJebr/f/h5t95m4JgrM3Y/w7YX9d7YAL9jvN4SydHsU6n65cCAwEAAaOCAa0w
ggGpMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRTcu2SnODaywFc
fH6WNU7y1LhRgjAfBgNVHSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRa
MFgwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYh
aHR0cDovL3d3dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6
Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5j
b20vc2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBAAqDCH14qywG
XLhjjF6uHLkjd02hcdh9hrw+VUsv+q1eeQWB21jWj3kJ96AUlPCoEGZ/ynJNScWy6QMVQjbbMXlt
UfO4n4bGGdKo3awPWp61tjAFgraLJgDk+DsSvUD6EowjMTNx25GQgyYJ5RPIzKKR9tQW8gGK+2+R
HxkUCTbYFnL6kl8Ch507rUdPPipJ9CgJFws3kDS3gOS5WFMxcjO5DwKfKSETEPrHh7p5shuuNktv
sv6hxHTLhiMKX893gxdT3XLS9OKmCv87vkINQcNEcIIoFWbP9HORz9v3vQwR4e3ksLc2JZOAFK+s
sS5XMEoznzpihEP0PLc4dCBYjbvSD7kxgDwZ+Aj8Q9PkbvE9sIPP7ON0fz095HdThKjiVJe6vofq
+n6b1NBc8XdrQvBmunwxD5nvtTW4vtN6VY7mUCmxsCieuoBJ9OlqmsVWQvifIYf40dJPZkk9YgGT
zWLpXDSfLSplbY2LL9C9U0ptvjcDjefLTvqSFc7tw1sEhF0n/qpA2r0GpvkLRDmcSwVyPvmjFBGq
Up/pNy8ZuPGQmHwFi2/14+xeSUDG2bwnsYJQG2EdJCB6luQ57GEnTA/yKZSTKI8dDQa8Sd3zfXb1
9mOgSF0bBdXbuKhEpuP9wirslFe6fQ1t5j5R0xi72MZ8ikMu1RQZKCyDbMwazlHiMIIGPzCCBSeg
AwIBAgIDBfQJMA0GCSqGSIb3DQEBBQUAMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRD
b20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYG
A1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwHhcN
MTMwMjE0MjMxOTE3WhcNMTQwMjE2MTE1MDMyWjBbMRkwFwYDVQQNExAxUVdxcVVpMDM4akNJNjFn
MRswGQYDVQQDDBJqZXJlbXlodUBhcHBsZS5jb20xITAfBgkqhkiG9w0BCQEWEmplcmVteWh1QGFw
cGxlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANNXcBKUXy6NXfdfBm3YDsnN
sZUBAZ8vr33/Kvo4+kPD8EOGq0LBL4g5r+habwQLBVqgOhNu0EED9VCRBUZNBLJNR1PfBM6uq0O+
pT/FBRB+SRsU1XMX+jt/KLfXCP6Hn9oeLSVzeSIlzd3Br+B9CWXGNjxmH1vL/UBod8uHxxLROo9D
s571b+P0loxBhU6nO7HCVptmxiiRkKiBg9MMdZNyfJ/KzuKp9LXXldsKIB1Y1LCnfHXZBv5JRmEG
923PEcnyRsL3yJ4SphW2PmqUMX52Lkq/krv4XqkFl+h9/EazQPE/ZHlg5lXYIQtfoTpNimN2j9eD
RENyNHVs1VLl+bcCAwEAAaOCAtgwggLUMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQW
MBQGCCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQUx1VzKpzWhoOIJzYm9M0VPPHHbwEwHwYD
VR0jBBgwFoAUU3Ltkpzg2ssBXHx+ljVO8tS4UYIwHQYDVR0RBBYwFIESamVyZW15aHVAYXBwbGUu
Y29tMIIBTAYDVR0gBIIBQzCCAT8wggE7BgsrBgEEAYG1NwECAzCCASowLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0
Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBp
c3N1ZWQgYWNjb3JkaW5nIHRvIHRoZSBDbGFzcyAxIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9m
IHRoZSBTdGFydENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBw
dXJwb3NlIGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMDYG
A1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUxLWNybC5jcmwwgY4G
CCsGAQUFBwEBBIGBMH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIv
Y2xhc3MxL2NsaWVudC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2Vy
dHMvc3ViLmNsYXNzMS5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3RhcnRz
c2wuY29tLzANBgkqhkiG9w0BAQUFAAOCAQEASDGjzbcC5ZuYswFmMum7uQyoLX1BQx4KRSIVKvrr
wwX3vX0lDuC/R5m1CmVJR0kw//oPw8smN/kDPTe2yUTrE9E3xwH462aPK1/pKeZIpg7Fo82CYmYV
GMDFYCoarzUPK/mwlxmvO0w6X8GyXC89s7nYHpWNmrvirAN0I8kghLaRYbkcug0SM33j9C60AP19
Fnsv2RwOw5UMI791TeKuPlTV1izHTMm1POBCu3TIWs58MGvDgMO+0xe0jlHNdMDlr7PGs33wyCeF
o/R0Nz3rN2CjWZVVrcH/M+AUsFX7xA0XNo1s6rxNeC9ncu8McbpI56AUJJJUtjbRIgdbyEKnnjGC
A28wggNrAgEBMIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkG
A1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRD
b20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwX0CTAJBgUrDgMCGgUA
oIIBrzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMzA4MDUxNjE2
NDNaMCMGCSqGSIb3DQEJBDEWBBTHga9xHiSjS7BX49kMLnH/QLuG6TCBpQYJKwYBBAGCNxAEMYGX
MIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2Vj
dXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3Mg
MSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwX0CTCBpwYLKoZIhvcNAQkQAgsxgZeg
gZQwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1
cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAx
IFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQIDBfQJMA0GCSqGSIb3DQEBAQUABIIBADno
D0rZPNo6nEvBwMBOJx99meQdGwo0Eb66ceEBEb4MS9dRawq+pPX1KxRkk0ZCTdEwCHPuKnyEmoro
74MBpDgXvoLp9wt8lNrkyCtQ/zzs2t8PjuxXvBJ2njH0zFLWKPU9y7JGQ2P7N5YwQaHSCY1Jc3Ya
99KaQ2gNPNAw6o4i837XUfTYSXU/JAVPk9okW717J0oGGe2k7KJ5wtm0aCSzOGMVvA5SiQJduAqk
6TLqlv/OJkFEYcKHmkgibAe+UhypvItQ/0QNZjhaY18KXUgZrRNx5szyAb+z/dV0d6ZP2MjU78gy
wRMS5UVYEKSoVyt+Qzpc6sYGXbw43jYeLlQAAAAAAAA=

--Apple-Mail=_2C8C8111-AA11-4562-BB90-F06B9CCF1866--
