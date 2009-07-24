From: Nicholas Tung <ntung@ntung.com>
Subject: Eclipse git plugin help -- diffs
Date: Fri, 24 Jul 2009 13:10:38 -0700
Message-ID: <4A6A153E.9020508@ntung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms040502020102090509020906"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 22:11:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUR6g-0008Rz-El
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 22:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbZGXUKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 16:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbZGXUKx
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 16:10:53 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:63331 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbZGXUKw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 16:10:52 -0400
Received: by ewy26 with SMTP id 26so2005223ewy.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type;
        bh=kwUxJGG/NiXYJTsN6Z2j3LS9tCTlKO4msQ4rQoXwti8=;
        b=vu+UJlPdvjdithNmb3Jb2yizd9xegMSjQhBOAkoD6z1llqWDiOBthMEzc5ILBa6PU5
         0AHTKRlLkx8l22k19+jFSsiDyP48DXgVYGsVrS3f48I6yzXdhwiUTnYaxqoln0z5ZYjU
         odeXBuveATDfM1jK6CU2FHBBC9lVbacySccWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type;
        b=uvWsSi30C5ADIOrSoOUB4IIWDfa36WeVXC8S45Xm06VCD0Hx6nishVuCsCChvFimZB
         AF/q1D0I4tK853cCwodlO7Rh6sEARFd2vppzds/r9ycHLnORY5RgVbcbRwC6QmiYpMLM
         dIRshBO4bjzhoG2lVd1YZ4GC+Dv/6FtvIahvg=
Received: by 10.210.138.6 with SMTP id l6mr4842448ebd.25.1248466251130;
        Fri, 24 Jul 2009 13:10:51 -0700 (PDT)
Received: from ?128.32.35.76? (dhcp-35-76.EECS.Berkeley.EDU [128.32.35.76])
        by mx.google.com with ESMTPS id 28sm3250143eye.0.2009.07.24.13.10.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 13:10:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123942>

This is a cryptographically signed message in MIME format.

--------------ms040502020102090509020906
Content-Type: multipart/mixed;
 boundary="------------070601090500050007080509"

This is a multi-part message in MIME format.
--------------070601090500050007080509
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

    I can't find the "quick diff" feature listed on the Eclipse git
website. I'm using version 0.5 (should be the latest). The history graph
and diffs for changes /_already committed_/ are very nice. I seem to be
able to execute a "diff from index" on a per-file basis; I'd like to see
changes made to all files (what's going to be committed), and possibly
diff with HEAD instead of the index.

    I'm happy with the command line, but I need to convince some
coworkers to switch from CVS and they're used to the (pretty nice)
synchronize view in Eclipse.

regards,
Nicholas
https://ntung.com

--------------070601090500050007080509
Content-Type: text/x-vcard; charset=utf-8;
 name="ntung.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ntung.vcf"

YmVnaW46dmNhcmQNCmZuOk5pY2hvbGFzIFR1bmcNCm46VHVuZztOaWNob2xhcw0KYWRyOjs7
O0JlcmtlbGV5O0NBOzk0NzA5O1VuaXRlZCBTdGF0ZXMNCmVtYWlsO2ludGVybmV0OmdhdG9h
dGlncmFkb0BnbWFpbC5jb20NCngtbW96aWxsYS1odG1sOlRSVUUNCnVybDpodHRwczovL250
dW5nLmNvbQ0KdmVyc2lvbjoyLjENCmVuZDp2Y2FyZA0KDQo=
--------------070601090500050007080509--

--------------ms040502020102090509020906
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIRNTCC
BN0wggPFoAMCAQICEHGS++YZX6xNEoV0cTSiGKcwDQYJKoZIhvcNAQEFBQAwezELMAkGA1UE
BhMCR0IxGzAZBgNVBAgMEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBwwHU2FsZm9yZDEa
MBgGA1UECgwRQ29tb2RvIENBIExpbWl0ZWQxITAfBgNVBAMMGEFBQSBDZXJ0aWZpY2F0ZSBT
ZXJ2aWNlczAeFw0wNDAxMDEwMDAwMDBaFw0yODEyMzEyMzU5NTlaMIGuMQswCQYDVQQGEwJV
UzELMAkGA1UECBMCVVQxFzAVBgNVBAcTDlNhbHQgTGFrZSBDaXR5MR4wHAYDVQQKExVUaGUg
VVNFUlRSVVNUIE5ldHdvcmsxITAfBgNVBAsTGGh0dHA6Ly93d3cudXNlcnRydXN0LmNvbTE2
MDQGA1UEAxMtVVROLVVTRVJGaXJzdC1DbGllbnQgQXV0aGVudGljYXRpb24gYW5kIEVtYWls
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsjmFpPJ9q0E7YkY3rs3BYHW8OWX5
ShpHornMSMxqmNVNNRm5pELlzkniii8efNIxB8dOtINknS4p1aJkxIW9hVE1eaROaJB7HHqk
kqgX8pgV8pPMyaQylbsMTzC9mKALi+VuG6JG+ni8om+rWV6lL8/K2m2qL+usobNqqrcuZzWL
eeEeaYji5kbNoKXqvgvOdjp6Dpvq/NonWz1zHyLmSGHGTPNpsaguG7bUMSAsvIKKjqQOpdeJ
Q/wWWq8dcdcRWdq6hw2v+vPhwvCkxWeM1tZUOt4KpLoDd7NlyP0e03RiqhjKaJMeoYV+9Udl
y/hNVyh00jT/MLbu9mIwFIws6wIDAQABo4IBJzCCASMwHwYDVR0jBBgwFoAUoBEKIz6W8Qfs
4q8p74Klf9AwpLQwHQYDVR0OBBYEFImCZ33EnSZwAEu0UEh83j2uBG59MA4GA1UdDwEB/wQE
AwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAR
BgNVHSAECjAIMAYGBFUdIAAwewYDVR0fBHQwcjA4oDagNIYyaHR0cDovL2NybC5jb21vZG9j
YS5jb20vQUFBQ2VydGlmaWNhdGVTZXJ2aWNlcy5jcmwwNqA0oDKGMGh0dHA6Ly9jcmwuY29t
b2RvLm5ldC9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2VzLmNybDARBglghkgBhvhCAQEEBAMCAQYw
DQYJKoZIhvcNAQEFBQADggEBAJ2Vyzy4fqUJxB6/C8LHdo45PJTGEKpPDMngq4RdiVTgZTvz
bRx8NywlVF+WIfw3hJGdFdwUT4HPVB1rbEVgxy35l1FM+WbKPKCCjKbI8OLp1Er57D9Wyd12
jMOCAU9sAPMeGmF0BEcDqcZAV5G8ZSLFJ2dPV9tkWtmNH7qGL/QGrpxp7en0zykX2OBKnxog
L5dMUbtGB8SKN04g4wkxaMeexIud6H4RvDJoEJYRmETYKlFgTYjrdDrfQwYyyDlWjDoRUtNB
pEMD9O3vMyfbOeAUTibJ2PU54om4k123KSZB6rObroP8d3XK6Mq1/uJlSmM+RMTQw16Hc6mY
HK9/FX8wggYmMIIFDqADAgECAhEAqa1epYqMa0ELiI7BQaEH8DANBgkqhkiG9w0BAQUFADCB
rjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQHEw5TYWx0IExha2UgQ2l0eTEe
MBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQLExhodHRwOi8vd3d3LnVz
ZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50IEF1dGhlbnRpY2F0
aW9uIGFuZCBFbWFpbDAeFw0wOTA2MTgwMDAwMDBaFw0xMDA2MTgyMzU5NTlaMIHYMTUwMwYD
VQQLEyxDb21vZG8gVHJ1c3QgTmV0d29yayAtIFBFUlNPTkEgTk9UIFZBTElEQVRFRDFGMEQG
A1UECxM9VGVybXMgYW5kIENvbmRpdGlvbnMgb2YgdXNlOiBodHRwOi8vd3d3LmNvbW9kby5u
ZXQvcmVwb3NpdG9yeTEfMB0GA1UECxMWKGMpMjAwMyBDb21vZG8gTGltaXRlZDEWMBQGA1UE
AxMNTmljaG9sYXMgVHVuZzEeMBwGCSqGSIb3DQEJARYPbnR1bmdAbnR1bmcuY29tMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvNCsg2Mafy/6kD7EIon8HAfzUrra0ENKUrN9
1ie0bZf57o+L3BNknxm1FwcQdc8tfRq0Y813YL1Ld0XqEh2JelqmdG1LhPV8tlkC1YNKyR7w
/UfFjOpcXK2VYfYsJ2s0X9PmaacQYvcvRsJcAhByqJdGSqmmiu8D92/CXAGyTtxSM4UNSndi
xGiMS+cdXXgamHEihwgaDBmd3LszNjTxVlx8lSzil+62/Q1u54K9DymN/rZHtJIIUh2OB6jA
Tziwhc+u/VEQe/JRBXRjEZtm5gZ+E44/2efzb/P/fJN9QITCxyP/aoDMGHkpD6oQginThitb
Q/vT9Zqg13jMQw7VgwIDAQABo4ICETCCAg0wHwYDVR0jBBgwFoAUiYJnfcSdJnAAS7RQSHze
Pa4Ebn0wHQYDVR0OBBYEFJNCm2Pyir6HC46MKVb0nrEjWotKMA4GA1UdDwEB/wQEAwIFoDAM
BgNVHRMBAf8EAjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgB
hvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwgaUGA1UdHwSBnTCBmjBMoEqgSIZGaHR0
cDovL2NybC5jb21vZG9jYS5jb20vVVROLVVTRVJGaXJzdC1DbGllbnRBdXRoZW50aWNhdGlv
bmFuZEVtYWlsLmNybDBKoEigRoZEaHR0cDovL2NybC5jb21vZG8ubmV0L1VUTi1VU0VSRmly
c3QtQ2xpZW50QXV0aGVudGljYXRpb25hbmRFbWFpbC5jcmwwbAYIKwYBBQUHAQEEYDBeMDYG
CCsGAQUFBzAChipodHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9VVE5BQUFDbGllbnRDQS5jcnQw
JAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAaBgNVHREEEzARgQ9udHVu
Z0BudHVuZy5jb20wDQYJKoZIhvcNAQEFBQADggEBAGjmuvSOuvZ8qweMWZbuYPRs1r8qq4Er
RJitD/HLE8ELm0yPMUruoOiQQkIHDTot0aS++dKwc/3Z2U5INW64QmJuPAy6VL8p8y3+lQKf
h/DearU6sxLTM0L3YHx11am1Mu7pW6TUQuPAjro/AwILull0tbiwUQPJA0Dkau6Hb6LJeWau
lIXAwCfy6vWcIvItE9SKFfYRyiYJWAQlU5Qd1KdWgL22rprdGCimGEXdjRKR6H0BA073s/8k
h8G4knDvgYZHdfL6oWgBz6p4m+TQLOyieD7ioGaVU2yLM6awuu2VoFSU4D6nrjOz7PV1Wx5X
PTEqLqHLTPGe07YPX4lBU7gwggYmMIIFDqADAgECAhEAqa1epYqMa0ELiI7BQaEH8DANBgkq
hkiG9w0BAQUFADCBrjELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQHEw5TYWx0
IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQLExho
dHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbDAeFw0wOTA2MTgwMDAwMDBaFw0xMDA2MTgyMzU5
NTlaMIHYMTUwMwYDVQQLEyxDb21vZG8gVHJ1c3QgTmV0d29yayAtIFBFUlNPTkEgTk9UIFZB
TElEQVRFRDFGMEQGA1UECxM9VGVybXMgYW5kIENvbmRpdGlvbnMgb2YgdXNlOiBodHRwOi8v
d3d3LmNvbW9kby5uZXQvcmVwb3NpdG9yeTEfMB0GA1UECxMWKGMpMjAwMyBDb21vZG8gTGlt
aXRlZDEWMBQGA1UEAxMNTmljaG9sYXMgVHVuZzEeMBwGCSqGSIb3DQEJARYPbnR1bmdAbnR1
bmcuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvNCsg2Mafy/6kD7EIon8
HAfzUrra0ENKUrN91ie0bZf57o+L3BNknxm1FwcQdc8tfRq0Y813YL1Ld0XqEh2JelqmdG1L
hPV8tlkC1YNKyR7w/UfFjOpcXK2VYfYsJ2s0X9PmaacQYvcvRsJcAhByqJdGSqmmiu8D92/C
XAGyTtxSM4UNSndixGiMS+cdXXgamHEihwgaDBmd3LszNjTxVlx8lSzil+62/Q1u54K9DymN
/rZHtJIIUh2OB6jATziwhc+u/VEQe/JRBXRjEZtm5gZ+E44/2efzb/P/fJN9QITCxyP/aoDM
GHkpD6oQginThitbQ/vT9Zqg13jMQw7VgwIDAQABo4ICETCCAg0wHwYDVR0jBBgwFoAUiYJn
fcSdJnAAS7RQSHzePa4Ebn0wHQYDVR0OBBYEFJNCm2Pyir6HC46MKVb0nrEjWotKMA4GA1Ud
DwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIx
AQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzAp
BggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwgaUGA1UdHwSBnTCB
mjBMoEqgSIZGaHR0cDovL2NybC5jb21vZG9jYS5jb20vVVROLVVTRVJGaXJzdC1DbGllbnRB
dXRoZW50aWNhdGlvbmFuZEVtYWlsLmNybDBKoEigRoZEaHR0cDovL2NybC5jb21vZG8ubmV0
L1VUTi1VU0VSRmlyc3QtQ2xpZW50QXV0aGVudGljYXRpb25hbmRFbWFpbC5jcmwwbAYIKwYB
BQUHAQEEYDBeMDYGCCsGAQUFBzAChipodHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9VVE5BQUFD
bGllbnRDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAaBgNV
HREEEzARgQ9udHVuZ0BudHVuZy5jb20wDQYJKoZIhvcNAQEFBQADggEBAGjmuvSOuvZ8qweM
WZbuYPRs1r8qq4ErRJitD/HLE8ELm0yPMUruoOiQQkIHDTot0aS++dKwc/3Z2U5INW64QmJu
PAy6VL8p8y3+lQKfh/DearU6sxLTM0L3YHx11am1Mu7pW6TUQuPAjro/AwILull0tbiwUQPJ
A0Dkau6Hb6LJeWaulIXAwCfy6vWcIvItE9SKFfYRyiYJWAQlU5Qd1KdWgL22rprdGCimGEXd
jRKR6H0BA073s/8kh8G4knDvgYZHdfL6oWgBz6p4m+TQLOyieD7ioGaVU2yLM6awuu2VoFSU
4D6nrjOz7PV1Wx5XPTEqLqHLTPGe07YPX4lBU7gxggRgMIIEXAIBATCBxDCBrjELMAkGA1UE
BhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMV
VGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5j
b20xNjA0BgNVBAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBF
bWFpbAIRAKmtXqWKjGtBC4iOwUGhB/AwCQYFKw4DAhoFAKCCAnAwGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDkwNzI0MjAxMDM4WjAjBgkqhkiG9w0BCQQx
FgQUOVBSTkL+plac9F9arRt6t+mkOY0wXwYJKoZIhvcNAQkPMVIwUDALBglghkgBZQMEAQIw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMIHVBgkrBgEEAYI3EAQxgccwgcQwga4xCzAJBgNVBAYTAlVTMQswCQYD
VQQIEwJVVDEXMBUGA1UEBxMOU2FsdCBMYWtlIENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJV
U1QgTmV0d29yazEhMB8GA1UECxMYaHR0cDovL3d3dy51c2VydHJ1c3QuY29tMTYwNAYDVQQD
Ey1VVE4tVVNFUkZpcnN0LUNsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgRW1haWwCEQCprV6l
ioxrQQuIjsFBoQfwMIHXBgsqhkiG9w0BCRACCzGBx6CBxDCBrjELMAkGA1UEBhMCVVMxCzAJ
BgNVBAgTAlVUMRcwFQYDVQQHEw5TYWx0IExha2UgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJU
UlVTVCBOZXR3b3JrMSEwHwYDVQQLExhodHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xNjA0BgNV
BAMTLVVUTi1VU0VSRmlyc3QtQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBFbWFpbAIRAKmt
XqWKjGtBC4iOwUGhB/AwDQYJKoZIhvcNAQEBBQAEggEAtclrPc74CZVKBvumYjgn9n7WeJus
CtfsxsrPT0qFvan8wkElDc/pM9I5bOvBxHi8Q7807cf895nU+cqFIHdLaiLNTQ9EUQ3mnueP
8DGP36MJC0VnNXO058cdX8EjokKQ22K+VGUI6+zxBljtEpLnTOvqm9X5lSoyIGUa7ZiMZQmp
hN/7PWdwhNlumEOilsg552i8QPZF0NgB/0VR+Hci0MT8hlKOuB4xwXPp/0KD9bZprYtbkHTw
MHLTc5Ykeh/VO5UhE9BYX9tPiOrVpKJBzLGCniKn60Bm9riEeFazDjLQIYT8GI8/OGCIVEim
cFLSedGtPV5dVGv6kpl5NCQ6PAAAAAAAAA==
--------------ms040502020102090509020906--
