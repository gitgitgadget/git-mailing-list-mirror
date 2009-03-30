From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCH 1/2] Add feature release instructions to MaintNotes addendum
Date: Mon, 30 Mar 2009 13:57:58 -0400
Message-ID: <49D10826.9080003@fastmail.fm>
References: <1238391319-4953-1-git-send-email-rocketraman@fastmail.fm> <7vr60fijn5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms020502080108030803000007"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 19:59:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoLlv-0000ss-QD
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 19:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbZC3R6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 13:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbZC3R6K
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 13:58:10 -0400
Received: from smtp123.rog.mail.re2.yahoo.com ([206.190.53.28]:27177 "HELO
	smtp123.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751293AbZC3R6J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 13:58:09 -0400
Received: (qmail 72233 invoked from network); 30 Mar 2009 17:58:06 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp123.rog.mail.re2.yahoo.com with SMTP; 30 Mar 2009 17:58:06 -0000
X-YMail-OSG: owfrCAgVM1nILn91U4S0obC02RZFhL5wvavukSKEnwdXAGTM1L8b8wUb2gCw6FBl4Q--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id BF89B21C0519;
	Mon, 30 Mar 2009 13:58:05 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 80npwMlqrL2l; Mon, 30 Mar 2009 13:57:58 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 4069721C051A;
	Mon, 30 Mar 2009 13:57:58 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vr60fijn5.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115179>

This is a cryptographically signed message in MIME format.

--------------ms020502080108030803000007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> rocketraman@fastmail.fm writes:
> 
>> + - The 'maint' branch is updated to the new release.
>> +
>> +     $ git branch -f maint master
> 
> It appears that you are trying to make this document into a canned set of
> insns for people who want a ready-to-cut-and-paste-without-thinking
> recipe, and I am perfectly fine with such a document, but as I mentioned
> already, "how to maintain git" is not a good place to do so.  You seem to
> have taken it as a joke, but I am serious.

I guess the smiley face when you said that threw me off :)

Based on your feedback, I'll withdraw my patch for MaintNotes -- my
intention in patching it was to provide more information for newbies
or people reading it out of curiosity, however you're absolutely right
-- it is not the right place for that type of information.

It does need more info in some of the other areas you mentioned and I
would love to help but I'm not knowledgeable enough to do so and I
fear I'll be more of a hindrance than a help.

Cheers,
Raman

--------------ms020502080108030803000007
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKGTCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENv
bnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVy
c29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5
NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9Vvy
Gna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOC
dz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhh
d3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQAD
gYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8wggNnMIIC0KADAgECAhBU/SX2GbjrIMg6UrYRoqOb
MA0GCSqGSIb3DQEBBQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQTAeFw0wODA1MDEwNDMyMDFaFw0wOTA1MDEwNDMyMDFaMIGXMR8wHQYDVQQDExZU
aGF3dGUgRnJlZW1haWwgTWVtYmVyMSQwIgYJKoZIhvcNAQkBFhVyYW1hbkByb2NrZXRyYW1h
bi5jb20xJjAkBgkqhkiG9w0BCQEWF3JvY2tldHJhbWFuQGhvdG1haWwuY29tMSYwJAYJKoZI
hvcNAQkBFhdyb2NrZXRyYW1hbkBmYXN0bWFpbC5mbTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAOzsL+xNYuQv+BSN3nYWiCMLd33FIZMZs782Rk27CJLCRJN8h4rmf8V2hlPM
FC9mg7x8DiJNkwt+FnJ9ayE1uYiHkyx0QeT1i4IKhig1VxB2R04Q0SmBa5QnOkBfp9/V7WOZ
oldzeTRCBib7RnAc275Ias4mSqyXc0Gl9mHlRRjWW266QDhe4udXNYWETZFa4khVBarr7dcl
deJnqwfqn0aRDDY6YUt4zfoT6g673afdYAUQ5+4HzEfBYNabbaCaKdv8a30yYA3C7p7lZRd3
9F234TPMXpBGPTLqJiBPG3LAivEMQ8TAclk3s3bu0Gsp4tWSHRKWDFJdo1iJBMiDnf8CAwEA
AaNkMGIwUgYDVR0RBEswSYEVcmFtYW5Acm9ja2V0cmFtYW4uY29tgRdyb2NrZXRyYW1hbkBo
b3RtYWlsLmNvbYEXcm9ja2V0cmFtYW5AZmFzdG1haWwuZm0wDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQUFAAOBgQAB0pniXcBoCggijnmSxtUf/frrLZlHKYDUnSeKNg96Yb0pzz3Fp5Kv
wLE4hPCBZ3w/doyii8U6NVvPtPa7sKgnnyt7Zx1o/j0U7B+FqGkawyGt8p47K+zfu5ZqQt3o
3d0+K7sXjYRGmYcmgwqHFrz4HVvfAxuZZmUvRW4/q6n4/jCCA2cwggLQoAMCAQICEFT9JfYZ
uOsgyDpSthGio5swDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MDUwMTA0MzIwMVoXDTA5MDUwMTA0MzIwMVowgZcx
HzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBNZW1iZXIxJDAiBgkqhkiG9w0BCQEWFXJhbWFu
QHJvY2tldHJhbWFuLmNvbTEmMCQGCSqGSIb3DQEJARYXcm9ja2V0cmFtYW5AaG90bWFpbC5j
b20xJjAkBgkqhkiG9w0BCQEWF3JvY2tldHJhbWFuQGZhc3RtYWlsLmZtMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Owv7E1i5C/4FI3edhaIIwt3fcUhkxmzvzZGTbsIksJE
k3yHiuZ/xXaGU8wUL2aDvHwOIk2TC34Wcn1rITW5iIeTLHRB5PWLggqGKDVXEHZHThDRKYFr
lCc6QF+n39XtY5miV3N5NEIGJvtGcBzbvkhqziZKrJdzQaX2YeVFGNZbbrpAOF7i51c1hYRN
kVriSFUFquvt1yV14merB+qfRpEMNjphS3jN+hPqDrvdp91gBRDn7gfMR8Fg1pttoJop2/xr
fTJgDcLunuVlF3f0XbfhM8xekEY9MuomIE8bcsCK8QxDxMByWTezdu7Qayni1ZIdEpYMUl2j
WIkEyIOd/wIDAQABo2QwYjBSBgNVHREESzBJgRVyYW1hbkByb2NrZXRyYW1hbi5jb22BF3Jv
Y2tldHJhbWFuQGhvdG1haWwuY29tgRdyb2NrZXRyYW1hbkBmYXN0bWFpbC5mbTAMBgNVHRMB
Af8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAAHSmeJdwGgKCCKOeZLG1R/9+ustmUcpgNSdJ4o2
D3phvSnPPcWnkq/AsTiE8IFnfD92jKKLxTo1W8+09ruwqCefK3tnHWj+PRTsH4WoaRrDIa3y
njsr7N+7lmpC3ejd3T4ruxeNhEaZhyaDCocWvPgdW98DG5lmZS9Fbj+rqfj+MYIDcTCCA20C
AQEwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkg
THRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEFT9
JfYZuOsgyDpSthGio5swCQYFKw4DAhoFAKCCAdAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMDkwMzMwMTc1NzU4WjAjBgkqhkiG9w0BCQQxFgQUdw3TG8bU
19P08uocat5iiiVFk58wXwYJKoZIhvcNAQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcN
AwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMC
AgEoMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUg
Q29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgSXNzdWluZyBDQQIQVP0l9hm46yDIOlK2EaKjmzCBhwYLKoZIhvcNAQkQAgsxeKB2MGIx
CzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSww
KgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQVP0l9hm46yDI
OlK2EaKjmzANBgkqhkiG9w0BAQEFAASCAQDT+p5rky3AmLo4WBGb838hkDD6PfmtX/8VA0lz
Uu2K2L3hOCHxdXNA3nC7bINI8YWZm5K416ICxtZhJsBp6Ig8MB+UHq0GnvvJ1rt2W2YoonKL
G49fID4gvKJCNIGfxMccq/VaqmLcj/7dj/QTGNmKtOeYNtt7BxP40Hvqp9/DYA4yK/TpO7vG
kFERS+NJnjh+HXK3bWhynWjKQHxFendTVyripU6REPsNOFcm23jlSM1CPHojXFtUI9vWRR7Z
AvBT1vIu+EuUL5bzgr4ozq91wtJ4b0k+vzfPLiQrh1qeGMBDai9zMkDGpZqeaAtpQXt4aqG5
mqXURDe4V+q5GPNxAAAAAAAA
--------------ms020502080108030803000007--
