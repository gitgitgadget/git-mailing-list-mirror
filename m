From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Addition of "xmlto" to install documentation
Date: Sun, 14 Oct 2007 21:38:31 +0200
Organization: http://freemail.web.de/
Message-ID: <30629502.1192390711800.JavaMail.fmail@fmcert01.dlan.cinetic.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg="md5"; 
	boundary="----=_Part_13532_997623.1192390711800"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 22:04:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih9gi-0001ka-51
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 22:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682AbXJNUDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 16:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760826AbXJNUDg
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 16:03:36 -0400
Received: from fmmailgate07.web.de ([217.72.192.248]:46066 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757140AbXJNUDf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 16:03:35 -0400
X-Greylist: delayed 1502 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Oct 2007 16:03:35 EDT
Received: from web.de 
	by fmmailgate07.web.de (Postfix) with SMTP id CE8C02663;
	Sun, 14 Oct 2007 21:38:31 +0200 (CEST)
Received: from [80.140.80.78] by freemailng6003.web.de with HTTP;
 Sun, 14 Oct 2007 21:38:31 +0200
X-Provags-Id: V01U2FsdGVkX189UVAbzlt/mkTBxS8TOGo4ItxAsDnSrrd1Mm343u3BCC7Vh
 VoxoTeWwkx8Ng5xwzx0NtNFqXPurHlaC/CyGTnfKnoT8CZ312mCvfVtGpzRP
 w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60897>

------=_Part_13532_997623.1192390711800
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

> Well, it is not strictly necessary to build git, and not even 
> to install it, if you have the "man" branch.

Thanks for your reply.

I'll have to admit that I overlooked the hint for "the asciidoc/xmlto toolchain" because it was in a separate paragraph instead of another item in the system requirements enumeration. (The tool's version number does not look promising so far.)
I rebuilt Git on my system because I was notified that a newer release became available.

Regards,
Markus

------=_Part_13532_997623.1192390711800
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDjAMBggqhkiG9w0CBQUAMIAGCSqGSIb3DQEHAQAAoIID7TCC
A+kwggLRoAMCAQICBAQwrlIwDQYJKoZIhvcNAQEEBQAwgaAxCzAJBgNVBAYTAkRFMRIwEAYDVQQK
EwlXRUIuREUgQUcxFTATBgNVBAsTDFRydXN0IENlbnRlcjEaMBgGA1UEBxMRRC03NjIyNyBLYXJs
c3J1aGUxLTArBgNVBAMTJFdFQi5ERSBUcnVzdENlbnRlciBFTWFpbC1aZXJ0aWZpa2F0ZTEbMBkG
CSqGSIb3DQEJARYMdHJ1c3RAd2ViLmRlMB4XDTA2MTEwOTEzMTMxMVoXDTA3MTEwOTEzMTMxMVow
XjEKMAgGA1UEBhMBRDERMA8GA1UEBxMITWVocmhvb2cxFzAVBgNVBAMTDk1hcmt1cyBFbGZyaW5n
MSQwIgYJKoZIhvcNAQkBFhVtYXJrdXMuZWxmcmluZ0B3ZWIuZGUwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBALQirwzOds2RJ3FWVboXzFZ1yMIWZDUwYBRQbCAAXArzXoBCkm7SgETY99z0bUHP
Z+ExCGjSju812NvQaHvCvAmfgg9cpjyCY4wv82ikEuY7gdGIIWP3l2VSkrTjblPzd3A72UcK6Kae
ck9EUx7EV3+24XTUi7ODfT7tGsR+QkQlAgMBAAGjge8wgewwHQYDVR0OBBYEFOicGjwMb3oq1lAf
f4rk8Nczhq6uMB8GA1UdIwQYMBaAFFpkzNcIjXxhAsbLkgPXwrr53rzUMAwGA1UdEwEB/wQCMAAw
EQYJYIZIAYb4QgEBBAQDAgSwMCMGCWCGSAGG+EIBAgQWFhRodHRwczovL3RydXN0LndlYi5kZTAa
BglghkgBhvhCAQgEDRYLL0hpbGZlL0FHQi8wFgYJYIZIAYb4QgEDBAkWBy9ydi8/cz0wFgYJYIZI
AYb4QgEHBAkWBy9ybi8/cz0wGAYJYIZIAYb4QgEEBAsWCS9ydkNBLz9zPTANBgkqhkiG9w0BAQQF
AAOCAQEAF7ddQKVcy2gtHzmuJY0Fx0omO5RM1qrsFXEBb/S/2PTV9gy6qYdLtUw7WVqwX2homLGF
dZHu6cxCPoki4ES1jLvMl1+E130iyuHM364x2rD4Hkvo86sTnNpWRK08ZqeQIBMlBAUn4kjQophT
sgrxC416APUvjsJGvtnULtnsR1RDkv5JKdKbSxYfsrdH6hro7wtx8CONlz5jKTAjU9As9JOPuTJ+
HQsY7GoXoNuE/5Sgd1lSOBV0JUgFS8Ixx8+XSGGZF2Dq/LlMcfdDuDNrkQSNZePERciCNUMVEsZg
I6Pg13pXJ4sxRCYUnQehzmdGl8t8uGhQgRbGI6a52/ZCzjGCArowggK2AgEBMIGpMIGgMQswCQYD
VQQGEwJERTESMBAGA1UEChMJV0VCLkRFIEFHMRUwEwYDVQQLEwxUcnVzdCBDZW50ZXIxGjAYBgNV
BAcTEUQtNzYyMjcgS2FybHNydWhlMS0wKwYDVQQDEyRXRUIuREUgVHJ1c3RDZW50ZXIgRU1haWwt
WmVydGlmaWthdGUxGzAZBgkqhkiG9w0BCQEWDHRydXN0QHdlYi5kZQIEBDCuUjAMBggqhkiG9w0C
BQUAoIIBYzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNzEwMTQx
OTM4MzFaMB8GCSqGSIb3DQEJBDESBBD348VRZQwz4ysCvYGwjvmlMEkGCSqGSIb3DQEJDzE8MDow
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEo
MIG8BgsqhkiG9w0BCRACCzGBrKCBqTCBoDELMAkGA1UEBhMCREUxEjAQBgNVBAoTCVdFQi5ERSBB
RzEVMBMGA1UECxMMVHJ1c3QgQ2VudGVyMRowGAYDVQQHExFELTc2MjI3IEthcmxzcnVoZTEtMCsG
A1UEAxMkV0VCLkRFIFRydXN0Q2VudGVyIEVNYWlsLVplcnRpZmlrYXRlMRswGQYJKoZIhvcNAQkB
Fgx0cnVzdEB3ZWIuZGUCBAQwrlIwDQYJKoZIhvcNAQEBBQAEgYBfoH9N+AgMJa7MR77cFKNC6Ypq
v/dsiBRqxzsG2SqGMv4akUNjxFwZBV7coJ8ckQ2JPpEZ9r4U4vXFB8Kkv53k5A67IE8t6jcPW3ZK
f/0M33qfCv1+lgus3t/ssDzbOVe98D0ukIqw/4kAxopPl7nw24ziXRXUyR62lTK1Z8Re9gAAAAAA
AA==
------=_Part_13532_997623.1192390711800--
