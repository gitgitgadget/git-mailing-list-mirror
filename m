Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B831F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758070AbcHCQ02 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:26:28 -0400
Received: from mail-out4.apple.com ([17.151.62.26]:52958 "EHLO
	mail-in4.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753852AbcHCQ00 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:26:26 -0400
Received: from relay4.apple.com (relay4.apple.com [17.128.113.87])
	by mail-in4.apple.com (Apple Secure Mail Relay) with SMTP id F6.9C.07433.21712A75; Wed,  3 Aug 2016 09:08:50 -0700 (PDT)
X-AuditID: 11973e12-f79b16d000001d09-0b-57a21712a97f
Received: from [17.153.67.3] (Unknown_Domain [17.153.67.3])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by relay4.apple.com (Apple SCV relay) with SMTP id 9A.0B.30081.11712A75; Wed,  3 Aug 2016 09:08:49 -0700 (PDT)
From:	Jeremy Huddleston Sequoia <jeremyhu@macports.org>
Message-Id: <944D9B54-6DB8-42E7-890D-38CB5D6DFFEF@macports.org>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_65F2A841-DD14-480D-8190-1073EF152E59";
 protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3207.2\))
Subject: Re: 2.9.2 test failures on macOS
Date:	Wed, 3 Aug 2016 09:08:49 -0700
In-Reply-To: <alpine.DEB.2.20.1608031632110.107993@virtualbox>
Cc:	git@vger.kernel.org
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <C4207508-629B-41DF-8E89-CDD1989BCF2E@macports.org>
 <alpine.DEB.2.20.1608031632110.107993@virtualbox>
X-Mailer: Apple Mail (2.3207.2)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsUi2FAYriskvijc4EcLs0XXlW4mi/7lXWwO
	TB4fPsZ5fN4kF8AUxWWTkpqTWZZapG+XwJXx5kYfc8Fi94rZm40bGA87djFyckgImEh8P3eV
	HcIWk7hwbz1bFyMXh5DAXkaJ/0/+M8MUHfr5FyoxkUmi8fMEsA42AXOJDw9OsILYvAL2Evcn
	PWYBKWIWmMIocffVIkaIhKHE7endYLawgKbEuhVHwWwWARWJKfebwGxOATuJlpeLmUBsZgFx
	iXVzz4MtEAHa3LizgQ3EFhIoluh88ZQJ4iJ5iUmtc8CWSQicYZN49PEK6wRGwVnIls9CsnwW
	2GBtiWULXzPPYuQAsnUkJi+ECptKPHm7nQ3Ctpb4OecRVFxRYkr3Q/YFjOyrGIVyEzNzdDPz
	TPQSCwpyUvWS83M3MYIiYbqd0A7GU6usDjEKcDAq8fBanF8QLsSaWFZcmXuIUZqDRUmc1/sU
	UEggPbEkNTs1tSC1KL6oNCe1+BAjEwenVAOjlC5j0/fw440mW5LqHix4eSW365dCWMXRFUde
	HJZ6/F5Td/aieoE6U42JF0/Yac2eF6giefuy5k5jp+V7Ttjf9VvHm2USHTdtWpSFns7+GPmC
	aXpXlocxa5syzOeZOrvzpKebr2fEo6krMxK/cXWuChTZ2Jcw57rVPaurdtIn3BweTdXLEl+l
	xFKckWioxVxUnAgAmyMxdmUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUiONOZWVdQfFG4wdqX1hZdV7qZLPqXd7E5
	MHl8+Bjn8XmTXABTFJdNSmpOZllqkb5dAlfGmxt9zAWL3StmbzZuYDzs2MXIySEhYCJx6Odf
	NghbTOLCvfVANheHkMBEJonGzxPYQRJsAuYSHx6cYAWxeQXsJe5PeswCUsQsMIVR4u6rRYwQ
	CUOJ29O7wWxhAU2JdSuOgtksAioSU+43gdmcAnYSLS8XM4HYzALiEuvmngdbIAJ0RePOBrAr
	hASKJTpfPGWCuEheYlLrHJYJjHyzkO2bhWTfLLBZ2hLLFr5mnsXIAWTrSExeCBU2lXjydjsb
	hG0t8XPOI6i4osSU7ofsCxjZVzEKFKXmJFaa6CUWFOSk6iXn525iBAVuQ2H4DsZ/y6wOMQpw
	MCrx8FqcXxAuxJpYVlyZe4hRBWjEow2rLzBKseTl56UqifD+ElkULsSbklhZlVqUH19UmpNa
	fIixCuj5icxSosn5wGjLK4k3NDExMDE2NjM2Njcxp4qwkjhv4vH54UIC6YklqdmpqQWpRTDL
	mTg4pRoYF6ZMfKWqdKtKyGLHpym17gW2H65FXU3ncTest1X8U5jTvLXp/jTb6a+NP06yyb7z
	48EdFinPU3wzPt6+eXi57rfAnp2dt088D1w6J+RHZXBi7Jy2ZY2c5xzOtc7wUw3liv73YdI8
	AaWpOwI3erX/Cj92Uf+HiXmYvOFRe5equ18vXtl1eHXweiWW4oxEQy3mouJEABwZwVnDAgAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--Apple-Mail=_65F2A841-DD14-480D-8190-1073EF152E59
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Aug 3, 2016, at 07:35, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> wrote:
>=20
> Hi Jeremy,
>=20
> On Wed, 3 Aug 2016, Jeremy Huddleston Sequoia wrote:
>=20
>> I have two test failures to report in git 2.9.2 on macOS:
>>=20
>>=20
>> t3210-pack-refs.sh has not changed between 2.8.4 and 2.9.2.  This =
test passed fine with 2.8.4, but it now fails with 2.9.2 at:
>>=20
>> not ok 26 - retry acquiring packed-refs.lock
>> #=09
>> #		LOCK=3D.git/packed-refs.lock &&
>> #		>"$LOCK" &&
>> #		test_when_finished "wait; rm -f $LOCK" &&
>> #		{
>> #			( sleep 1 ; rm -f $LOCK ) &
>> #		} &&
>> #		git -c core.packedrefstimeout=3D3000 pack-refs --all =
--prune
>> #
>>=20
>> =3D=3D=3D
>>=20
>> t3700-add.sh recently added the 'git add --chmod=3D-x stages an =
executable file with -x' test.  This test passes when run as a normal =
user but fails when run as root:
>>=20
>> $ ./t3700-add.sh
>> ...
>> # passed all 40 test(s)
>> 1..40
>>=20
>> $ sudo ./t3700-add.sh
>> ...
>> not ok 39 - git add --chmod=3D-x stages an executable file with -x
>> #=09
>> #		echo foo >xfoo1 &&
>> #		chmod 755 xfoo1 &&
>> #		git add --chmod=3D-x xfoo1 &&
>> #		case "$(git ls-files --stage xfoo1)" in
>> #		100644" "*xfoo1) echo pass;;
>> #		*) echo fail; git ls-files --stage xfoo1; (exit 1);;
>> #		esac
>> #=09
>> # failed 1 among 40 test(s)
>> 1..40
>=20
> I tried to write up all I know about debugging test failures here:
>=20
> =
https://github.com/git-for-windows/git/wiki/Running-Git's-regression-tests=
#running-individual-tests
>=20
> Could you give it a try and diagnose the breakage further? (The output =
you
> provided is unfortunately not enough to determine what went wrong.)

Another report indicates that the second was a known failure already.  =
As for the first one:

~/tmp/test $ git init
Initialized empty Git repository in /Users/jeremy/tmp/test/.git/

~/tmp/test (master) $ touch .git/packed-refs.lock=20

~/tmp/test (master) $ git -c core.packedrefstimeout=3D3000 pack-refs =
--all --prune
fatal: Unable to create '/Users/jeremy/tmp/test/.git/packed-refs.lock': =
File exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.

--

I just tried this again with 2.8.4, and I see the same failure.  I =
could've sworn that 2.8.4 passed all tests when I tested it back in =
June.=

--Apple-Mail=_65F2A841-DD14-480D-8190-1073EF152E59
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIM5TCCBeIw
ggPKoAMCAQICEFy2SG5HDJjGf/aA22RK4o0wDQYJKoZIhvcNAQELBQAwfTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmlj
YXRlIFNpZ25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4X
DTE1MTIxNjAxMDAwNVoXDTMwMTIxNjAxMDAwNVowdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAO4PUIyVCSOErPVQao/WN6JOIf0yCWVHPq84+tUb94TQf8nhBAtX894vxFPjFzjh
sTOygm7QiHCcRyFv5PET+rDzzDuHE4O7Dc3wVrGLHprWOnzf5Fa9kdl/vz477cZgGl6Rl9M570D8
WhNdtyDBl8tMxCh2f5yQ2dffUz/UzZ/b/tUDtAGW+KGie3IdA6UiWvJBecYjRQwIPbWiikq1bjxy
S/TBRWDyKsEoYx4PrmBM438WzD9kFsGpp2gPWO3zkUgzWqXbhZQEQHA7V3TKQIo4huByp6zd9tyN
Cmu5Q0wFsi7UwwhEyrCPH8zsi9IpxLtVhFaXT8rZvLNa8EAeH/UCAwEAAaOCAWQwggFgMA4GA1Ud
DwEB/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB
/wIBADAyBgNVHR8EKzApMCegJaAjhiFodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmww
ZgYIKwYBBQUHAQEEWjBYMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5zdGFydHNzbC5jb20wMAYI
KwYBBQUHMAKGJGh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL2NhLmNydDAdBgNVHQ4EFgQU
mZerGDU6i1lFQ5iycnHI9PsJzxYwHwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwPwYD
VR0gBDgwNjA0BgRVHSAAMCwwKgYIKwYBBQUHAgEWHmh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3Bv
bGljeTANBgkqhkiG9w0BAQsFAAOCAgEAmUFBBM72JPVOMDR4Q7tX/UBsG8wB+JuMCCh/GYnTWMGY
cqDSltONYidNNijFvcsGDPeZ+O+9LU+Och9vb0zJWbQb89IeOCrsTCzV0Qkw8L1dO7E9/Zz4xYuT
KcGWi1bnjYmmtb6JNZ9lp/JS3MgpbWGTRgBInzNJKPwP773JH7RSGRu+UQImR2LX563QRojschfp
xyPWt9wUV+VZf989Prh2f2OmD2zSe4m6DhaxWQQrbfpad1mgwetmaAXsIjJndPSa6pjCQBIMNxG3
0DbWj8xz4PxDoZWYpEYHeAQq862yKgdkSom/oJ0CbdrqCWijmlfdEvV4LNzwvN+zhPQhJmOvzE0x
tMaWy4doUf6y0N7Aqx+emjg3rg60AavOZV8UWwwhEQ1EexWVIR7/otWkGmOfTT7tuoQ3ep6pLEg6
tpgnXaYnTwbhic/ZTV9p0chpLnQ7lleoCK+gGX2mL/oIE1znAgyWRczIVnSwuwj70SsUO704mFfu
JYKjr1fTJ2XNePTz7YrU8rKv6Dr+9M8e6vrcmi02uHKhYQnJYSMEsDhCYld8akHm75sLA1+wWlxg
CWSIW3VGza96aBIHLergMcNs8q+vVgiZk1FIc/5Nf00/3glGSapzIP+po3u7YlXWlECXAbSenKuf
plAzVAdX6IVvBDhWosxaT/9BWj+tnLUwggb7MIIF46ADAgECAhAX8MOmbUCDPWU+X4TKPzSUMA0G
CSqGSIb3DQEBCwUAMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYD
VQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20g
Q2xhc3MgMiBDbGllbnQgQ0EwHhcNMTYwMTI4MDUzNDA3WhcNMTgwMTI4MDUzNDA3WjBzMQswCQYD
VQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTERMA8GA1UEBwwIV29vZHNpZGUxGTAXBgNVBAMM
EEplcmVtaWFoIFNlcXVvaWExITAfBgkqhkiG9w0BCQEWEmplcmVteWh1QGdtYWlsLmNvbTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANJQpjXCVgn9Bf+x34nMseNlpLX3qKn9mGqv2uh2
gBPf++z3kXVI2c92FN/lEicsvvAnuo3q0RwJvh/Z++8dW+RRuAm58adZmXEJWwf90vLzH3hFDC4W
V6slcg3e5KvtcJ+u6BzT/WFRdDGEPqsYENI0OpEJK2NcfmRzkZ+CTitMp379Z7vV3ly3l72Y/I4E
UZgYSluez4qqwlljdOVgL7aTmrJuw2ZI5CoDpj2xiwvFxFm9vyfgyyh34p2sFhSR/AWZR5rsfyoM
fw0uJ7s7a5EgdOf/dS0eeqpohBAXvfHQ0AFq4Gx++bAxWCaogskAhTxGBoc9fn85CCyiwlrfNcZZ
6+L5rY+n7JoUHRYZjwYIBieI5YQ247GkN8R+fBjIrMCDl/+7uI/1Vg/hxstsrvUyLouuOl9k3WWu
PSiSHjKZGuNnZS4z1LXDBnOtUCsyjHs79L617AyFK3Mt+W5qdUK5ChPzNYL5IcNLkkLduy6WGsZH
39n9Lruemd6qr+T9Syd1x+Zz7+4xog6DFyML89nJT7mQ1MDUVEpyX2N1GvDCgnVJ7iOQB1mL7fKg
qEdLYkihyWy3SkJrmw/Ga+GOjr0DkmrUUWIYkAOF8mWKGoigayR3RMZhWDyRxpXyFF7jtphX9Fob
Td96tP4RWs9GrfD5BGVtdhVW97SW0A3D8UkxAgMBAAGjggKHMIICgzALBgNVHQ8EBAMCBLAwHQYD
VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0OBBYEFMXHiWE0gVse
XU627q/t4qVnbDu6MB8GA1UdIwQYMBaAFJmXqxg1OotZRUOYsnJxyPT7Cc8WMG8GCCsGAQUFBwEB
BGMwYTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDkGCCsGAQUFBzAChi1o
dHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50Mi5jcnQwOAYDVR0fBDEwLzAt
oCugKYYnaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDIuY3JsMIHjBgNVHREEgdsw
gdiBEmplcmVteWh1QGdtYWlsLmNvbYESamVyZW15aHVAYXBwbGUuY29tgRFqZXJlbXlodWRAbWFj
LmNvbYEVamVyZW15aHVAbWFjcG9ydHMub3JngRhqZXJlbXlodUBmcmVlZGVza3RvcC5vcmeBEGpl
cmVteWh1ZEBtZS5jb22BFGplcmVteWh1ZEBpY2xvdWQuY29tgRRqZXJlbXlAamVyZW15aHUuaW5m
b4EUamVyZW15QGh1ZHNjYWJpbi5jb22BFmplcmVteUBvdXRlcnNxdWFyZS5vcmcwIwYDVR0SBBww
GoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMFQGA1UdIARNMEswDAYKKwYBBAGBtTcGATA7Bgsr
BgEEAYG1NwECBDAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kw
DQYJKoZIhvcNAQELBQADggEBANa+oip18OvH6LflykKaMt8qN07CwhNKYvWcCeTCR2IDJsDUbVXB
9H8RqqAgEs7pEjRY+gdJSzf8wqPzJ5n6zpyeJH7p1Rsvdx9UEknqgJlmKjzOJ15GFWMjhWjlg05n
SKJsGmJrpIHVjxSeq+q5RVizyxYh1OyRisKmSrJdrmqHeBcKjlfQjFtdEt/LZrJ/qzH4WaRohdoN
C5vXwIxdczlEnZc1+ZfM5j39unU1GAskIgQCHrUJcublS53ysYKo6JhidGUytVB5O0k6J1J73dCZ
DOhlN/np0KmCWDYx8UgdJHhEyhyAKSWWltf2U4bPpEI4BbOKwegeRJJqK1oRW9cxggROMIIESgIB
ATCBiTB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UECxMgU3Rh
cnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENsYXNzIDIg
Q2xpZW50IENBAhAX8MOmbUCDPWU+X4TKPzSUMAkGBSsOAwIaBQCgggGZMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2MDgwMzE2MDg0OVowIwYJKoZIhvcNAQkEMRYE
FMxTpKVZyfATREZH4nUMJySHs8J8MIGaBgkrBgEEAYI3EAQxgYwwgYkwdTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24g
QXV0aG9yaXR5MSMwIQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1l
Pl+Eyj80lDCBnAYLKoZIhvcNAQkQAgsxgYyggYkwdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1lPl+Eyj80lDANBgkq
hkiG9w0BAQEFAASCAgCCMJCeej5vdEJZe5b1+dvlBXmPr9B1Jphu2BVgxfCarRpov+MjjOrp4XIh
pwlYYorR3BD9RWafhfOjyWhNU3Whaf3kNwd6CrbUbMlPU4K93RZRxvpkTkjVfN2myX+6BNbgHIXy
LBY7XgCxItD8NYLMSMFcX9hPgkib0Kd0p58CmabcQUqbbzwmcki/kmXIelR+QJmW2GvpyS5qIypr
BAEh8jmdSbyYPCzeMtP8n3I8p8Odvm4ZS/ruH2H+ktDhniweQxovq9zOUb982EsgfqHLXfRVOj21
61It74N+SmvfBk4d3NKzKmKmdyQdYZEeY7S1vRXEiDIzX0hPQkeFD38WM92kaePNXmOyTaRv2Ki6
p+fMHrHnk6tYlNyHTBnRHuzkkoamOthFf6ZkwkthhtXPYazPR3Es2FhyLCsHeJzq2lqNGduFE6a0
6JQZjYTrEG1ExUtdRjzNheTke2VMEKWS19AuCMfF7mz71kX0+nqlz9mryWpP2nCBFbYKkBVcm7jE
kasefuTue5MHOYpguE+tNG188QQVhl7GK8zIWC/8cfXFvXvLQCBDkWy/bqFDLGmtD7sVhHhLpZnq
6qXVhiYzOUu7ma1Udx9XDvylxUkJG2L4IYBBJ8rNLkEs5oy0yyrRlNucSoxn4M89Gnbi4GjzBldx
aMTZJx2zUgDZWNu1kQAAAAAAAA==
--Apple-Mail=_65F2A841-DD14-480D-8190-1073EF152E59--
