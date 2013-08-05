From: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: Re: [PATCH 2/3] OS X: Fix redeclaration of die warning
Date: Mon, 05 Aug 2013 09:17:03 -0700
Message-ID: <64E52D7E-518B-47B4-A048-22BF326ACEF7@apple.com>
References: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
 <1375718364-13824-3-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1A81AA6D-633D-443D-9648-9F3CD427B08E";
 protocol="application/pkcs7-signature"; micalg=sha1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:17:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6NTT-0001If-IL
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab3HEQR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 12:17:28 -0400
Received: from crispin.apple.com ([17.151.62.50]:34447 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab3HEQRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 12:17:25 -0400
Received: from relay4.apple.com ([17.128.113.87])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTP id <0MR200IDQFVDAKN0@mail-out.apple.com> for git@vger.kernel.org;
 Mon, 05 Aug 2013 09:17:04 -0700 (PDT)
X-AuditID: 11807157-b7f1a6d000003e11-6e-51ffd00052bf
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)	by relay4.apple.com (Apple SCV relay)
 with SMTP id EC.62.15889.000DFF15; Mon, 05 Aug 2013 09:17:04 -0700 (PDT)
Received: from [10.0.20.112]
 (99-51-79-55.lightspeed.snjsca.sbcglobal.net [99.51.79.55])
 by koseret.apple.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPSA id <0MR200GL2FVVOG70@koseret.apple.com> for
 git@vger.kernel.org; Mon, 05 Aug 2013 09:17:04 -0700 (PDT)
In-reply-to: <1375718364-13824-3-git-send-email-brian@gernhardtsoftware.com>
X-Mailer: Apple Mail (2.1793.4)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsUiON1OXZfhwv9Ag73b1C26rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJXxaPpexoITDhWTNqk1MPbbdDFyckgImEgs2baEBcIWk7hwbz1b
	FyMXh5BAC5PEsnv3oJwjTBIHH3xkB3GYBaYwSjz8sx/I4eDgFTCQ+NzgA2IKC9hLnJ7LATKI
	DWjorT+nwYZyCvhIHOtewApiswioSjy/tQAszizgJtF/Yx9YnFfARqJ3+kxGiF29jBKXe+6B
	FYkIGErMffmbEeI6eYm23z/ZJjDyz0J2xiyEM2aBzdWWWLbwNTNImFlAR2LyQkaIsKnEk7fb
	2SBsa4mfcx5BxRUlpnQ/ZF/AyL6KUaAoNSex0kQvsaAgJ1UvOT93EyMoeBsKw3cw/ltmdYhR
	gINRiYdXgf1/oBBrYllxZe4hRhWgEY82rL7AKMWSl5+XqiTCO38LUJo3JbGyKrUoP76oNCe1
	+BCjNAeLkjivZejvQCGB9MSS1OzU1ILUIpgsEwenVAMj/1KHHeer2l0r3upfKps62aE59Gjx
	nAdz7fLPz29L41JNMuXe57H3ikW2646U2W6qBd/T9vzbNNfWVvxjf8Dj5a3n+EWyP+2b2HJ2
	ufPBPTI6z3pUl749Z6gaf6dkKqdn/dxNrS+mfEleqcEn83VOWLTm5fOXk1K2+JtIbpsgvufc
	11CzC7oKSizFGYmGWsxFxYkACBfBOmYCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231669>


--Apple-Mail=_1A81AA6D-633D-443D-9648-9F3CD427B08E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Thanks Brian,

Reviewed-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>

On Aug 5, 2013, at 8:59, Brian Gernhardt <brian@gernhardtsoftware.com> =
wrote:

> compat/apple-common-crypto.h uses die() in one of its macros, but was
> included in git-compat-util.h before the definition of die.
>=20
> Fix by simply moving the relevant block after the die/error/warning
> declarations.
>=20
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>=20
> Not sure if this is the best place to move it to, but it's the =
earliest it can
> be in the file without causing errors.  (Namely that clang has to =
guess what
> die() means in apple-common-crypto.h and guesses differently than the =
actual
> definition.)
>=20
> git-compat-util.h | 20 ++++++++++----------
> 1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/git-compat-util.h b/git-compat-util.h
> index af5f6bb..d60e28d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -129,16 +129,6 @@
> #include <poll.h>
> #endif
>=20
> -#ifndef NO_OPENSSL
> -#ifdef APPLE_COMMON_CRYPTO
> -#include "compat/apple-common-crypto.h"
> -#else
> -#include <openssl/evp.h>
> -#include <openssl/hmac.h>
> -#endif /* APPLE_COMMON_CRYPTO */
> -#include <openssl/x509v3.h>
> -#endif /* NO_OPENSSL */
> -
> #if defined(__MINGW32__)
> /* pull in Windows compatibility stuff */
> #include "compat/mingw.h"
> @@ -340,6 +330,16 @@ extern NORETURN void die_errno(const char *err, =
...) __attribute__((format (prin
> extern int error(const char *err, ...) __attribute__((format (printf, =
1, 2)));
> extern void warning(const char *err, ...) __attribute__((format =
(printf, 1, 2)));
>=20
> +#ifndef NO_OPENSSL
> +#ifdef APPLE_COMMON_CRYPTO
> +#include "compat/apple-common-crypto.h"
> +#else
> +#include <openssl/evp.h>
> +#include <openssl/hmac.h>
> +#endif /* APPLE_COMMON_CRYPTO */
> +#include <openssl/x509v3.h>
> +#endif /* NO_OPENSSL */
> +
> /*
>  * Let callers be aware of the constant return value; this can help
>  * gcc with -Wuninitialized analysis. We restrict this trick to gcc, =
though,
> --=20
> 1.8.4.rc1.384.g0976a17.dirty
>=20


--Apple-Mail=_1A81AA6D-633D-443D-9648-9F3CD427B08E
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
oIIBrzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMzA4MDUxNjE3
MDRaMCMGCSqGSIb3DQEJBDEWBBRju/ZDMwiaG6q3jW5f4V685A+CcTCBpQYJKwYBBAGCNxAEMYGX
MIGUMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2Vj
dXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3Mg
MSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0ECAwX0CTCBpwYLKoZIhvcNAQkQAgsxgZeg
gZQwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1
cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAx
IFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQIDBfQJMA0GCSqGSIb3DQEBAQUABIIBAMXZ
1bycSTZeGP6QfMl1ZqtmmCVLVrBv9EBSGlbpe+ld1gKNZ4DwLcGgifX1cd9hG6vqTiyRdQtKm6Vg
aESS7E1ESTdHlNmg8P26jAsv9pMKeEXyjkNcnslitFj+nR9dLYICMqwXQerseqN7sFoFSd7HEPmB
x6Xt5jF5jpOD01cW4fMHKCIHoSO6hIOwZ/Rb9BGoKk8MmpZNNHZy7CJaqlKeLPnt0oTym6QDGqFf
+uLswRJs1DURsYiebnZabLoqEpMO0DOSll0MgeFTmrZlCpY//+pQYLIQ81Pl1UGUEU1YNHKRkGAn
HG2zHNb8oPWx0Ghltao/NP34iJxyMB/gqWoAAAAAAAA=

--Apple-Mail=_1A81AA6D-633D-443D-9648-9F3CD427B08E--
