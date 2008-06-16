From: Alejandro Mery <amery@geeks.cl>
Subject: Re: [PATCH] git-am: head -1 is obsolete and doesn't work on some
 new systems
Date: Mon, 16 Jun 2008 22:43:53 +0200
Message-ID: <4856D089.1050608@geeks.cl>
References: <1213646544.908600.7895.nullmailer@rafaella.geeks.cl> <m3tzftnn28.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070009090007030901080708"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:58:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8LmZ-0004P2-2K
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 22:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757079AbYFPU5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 16:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757032AbYFPU5c
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 16:57:32 -0400
Received: from hu-out-0506.google.com ([72.14.214.228]:15651 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576AbYFPU5b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 16:57:31 -0400
Received: by hu-out-0506.google.com with SMTP id 28so6390239hub.21
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 13:57:29 -0700 (PDT)
Received: by 10.78.203.20 with SMTP id a20mr2778004hug.99.1213649038296;
        Mon, 16 Jun 2008 13:43:58 -0700 (PDT)
Received: from ?192.168.6.57? ( [85.57.67.224])
        by mx.google.com with ESMTPS id 39sm9644104hui.60.2008.06.16.13.43.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 13:43:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <m3tzftnn28.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85233>

This is a cryptographically signed message in MIME format.

--------------ms070009090007030901080708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jakub Narebski wrote:
> <amery@geeks.cl> writes:
> 
>> From 25cb047690dd6101527cdfa6198dd6a6f93bf095 Mon Sep 17 00:00:00 2001
> 
> This line is not needed (unless you use git-send-mail, or import patch
> as mbox to your MUA), and it should be removed.
> 
>> From: Alejandro Mery <amery@geeks.cl>
>> Date: Mon, 16 Jun 2008 20:27:14 +0200
>> Subject: [PATCH] git-am: head -1 is obsolete and doesn't work on some new systems
> 
> These headers should go as mailing list headers, which mean that your
> MUA should generate proper from (if it cannot, the From: would have to
> stay), and subject should go as email subject.

I'm really sorry about this, I was trying to send what git-format-patch 
generated using ubuntu's nullmailer, but it didn't work as expected (no 
git-send-email on this thing)

I'll have to fight more before sending another patch from here.

Alejandro Mery

--------------ms070009090007030901080708
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIRBjCC
BXkwggNhoAMCAQICAlcBMA0GCSqGSIb3DQEBBQUAMFQxFDASBgNVBAoTC0NBY2VydCBJbmMu
MR4wHAYDVQQLExVodHRwOi8vd3d3LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFz
cyAzIFJvb3QwHhcNMDgwNjEyMTQ0OTU5WhcNMTAwNjEyMTQ0OTU5WjCBgTEnMCUGA1UEAxQe
QWxlamFuZHJvIEpvc+kgTWVyeSBQZWxsZWdyaW5pMR0wGwYJKoZIhvcNAQkBFg5hbWVyeUBn
ZWVrcy5jbDE3MDUGCSqGSIb3DQEJARYoN2RjMGI3ZDkwZjNhMDgzN2E3OTUyMzg4ODg1YTky
YTk5MTdiNjIzZjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJLTwc7dRIwAi3Bx
F0Bg16YLg+VhPnflzKW9qQ/Aaglm+RpzT6B6RnSRGd5C3nP8U9fQ7/pTI0oqY/cTDX15hcm+
mJ2L9jSDr2VScSZHzOj5jfdPywkVtFaz23QHtYMnlGSLY04LcZBAkJx3RrQNusrtzvmcshtI
waUXfPXre+5MJjZABkVbwBQXWFrLkUjvLX4oGsmxFJP2LELrL6Ar3WAmXXfS6sEmqiPS0T5G
EsyJ+64nTVy3hNO/9S6cpbVbPFpHf/F1QjkWg21jmOFJ+/XG4rXiePaQ452Y7f0JdFMPEEkH
ChgwFM8pIYIEpc9w9WJNPsGXGoG15SVnIZJDkvMCAwEAAaOCASUwggEhMAwGA1UdEwEB/wQC
MAAwVgYJYIZIAYb4QgENBEkWR1RvIGdldCB5b3VyIG93biBjZXJ0aWZpY2F0ZSBmb3IgRlJF
RSBoZWFkIG92ZXIgdG8gaHR0cDovL3d3dy5DQWNlcnQub3JnMEAGA1UdJQQ5MDcGCCsGAQUF
BwMEBggrBgEFBQcDAgYKKwYBBAGCNwoDBAYKKwYBBAGCNwoDAwYJYIZIAYb4QgQBMDIGCCsG
AQUFBwEBBCYwJDAiBggrBgEFBQcwAYYWaHR0cDovL29jc3AuY2FjZXJ0Lm9yZzBDBgNVHREE
PDA6gQ5hbWVyeUBnZWVrcy5jbIEoN2RjMGI3ZDkwZjNhMDgzN2E3OTUyMzg4ODg1YTkyYTk5
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
4IUTl5y7rC+HVVgX1D9nCIUQiad5SDSKPscGp8RlXZNiI+rNdPmVmi3N9mLtNAqmg2toUtlc
Okx3KL6xU7+ZQzJFvf5JY9ZlXRv4H8nqYl10YW75xpdc7tQ61zODa+qvg0eUd3s8TwNIEKR0
MIIGCDCCA/CgAwIBAgIBATANBgkqhkiG9w0BAQQFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wNTEw
MTQwNzM2NTVaFw0zMzAzMjgwNzM2NTVaMFQxFDASBgNVBAoTC0NBY2VydCBJbmMuMR4wHAYD
VQQLExVodHRwOi8vd3d3LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFzcyAzIFJv
b3QwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCrSTURSHzSJn5TlM9Dqd0o10Iq
i/OHeBlYfA+e2ol94fvrcpANdKGWZKufoCSZc9riVXbHF3v1BKxGuMO+f2SNEGwk82GcwPKQ
+lHm9WkBY8MPVuJKQs/iRIwlKKjFeQl9RrmK8+nzNCkIReQcn8uUBByBqBSzmGXEQ+xOgo0J
0b2qW42S0OzekMV/CsLj6+YxWl50PpczWejDAz1gM7/30W9HxM3uYoNSbi4ImqTZFRiRpoWS
R7CuSOtttyHshRpocjWr//AQXcD0lKdq1TuSfkyQBX6TwSyLpI5idBVxbgtxA+qvFTia1NIF
cm+M+SvrWnIl+TlG43IbPgTDZCciECqKT1inA62+tC4T7V2qSNfVfdQqe1z6RgRQ5MwOQluM
7dvyz/yWk+DbETZUYjQ4jwxgmzuXVjit89Jbi6Bb6k6WuHzX1aCGcEDTkSm3ojyt9Yy7zxqS
iuQ0e8DYbF/pCsLDpyCaWt8sXVJcukfVm+8kKHA4IC/VfynAskEDaJLM4JzMl0tF7zoQCqtw
OpiVcK01seqFK6QcgCExqa5geoAmSAC4AcCTY1UikTxW56/bOiXzjzFU6iaLgVn5odFTEcV7
nQP2dBHgbbEsPyyGkZlxmqZ3izRg0RS0LKydr4wQ05/EavhvE/xzWfdmQnQeiuP43NJvmJzL
R5iVQAX76QIDAQABo4G/MIG8MA8GA1UdEwEB/wQFMAMBAf8wXQYIKwYBBQUHAQEEUTBPMCMG
CCsGAQUFBzABhhdodHRwOi8vb2NzcC5DQWNlcnQub3JnLzAoBggrBgEFBQcwAoYcaHR0cDov
L3d3dy5DQWNlcnQub3JnL2NhLmNydDBKBgNVHSAEQzBBMD8GCCsGAQQBgZBKMDMwMQYIKwYB
BQUHAgEWJWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZy9pbmRleC5waHA/aWQ9MTAwDQYJKoZIhvcN
AQEEBQADggIBAH8IiKHaGlBJ2on7oQhy84r3HsQ6tHlbIDCxRd7CXdNlafHCXVRUPIVfuXtC
kcKZ/RtRm6tGpaEQU55tiKxzbiwzpvD0nuB1wT6IRanhZkP+VlrRekF490DaSjrxC1uluxYG
5sLnk7mFTZdPsR44Q4Dvmw2M77inYACHV30eRBzLI++bPJmdr7UpHEV5FpZNJ23xHGzDwlVk
s7wU4vOkHx4y/CcVBc/dLq4+gmF78CEQGPZE6lM5+dzQmiDgxrvgu1pPxJnIB721vaLbLmIN
QjRBvP+LivVRIqqIMADisNS8vmW61QNXeZvo3MhN+FDtkaVSKKKs+zZYPumUK5FQhxvWXtaM
zPcPEAxSTtAWYeXlCmy/F8dyRlecmPVsYGN6b165Ti/Iubm7aoW8mA3t+T6XhDSUrgCvoeXn
km5OvfPi2RSLXNLrAWygF6UtEOucekq9ve7O/e0iQKtwOIj1CodqwqsFYMlIBdpTwd5Ed2qz
8zw87YC8pjhKKSRf/lk7myV6VmMAZLldpGJ9VzZPrYPvH5JToI53V93lYRE9IwCQTDz6o2CT
BKOvNfYOao9PSmCnhQVsRqGP9Md246FZV/dxssRuFFxtbUFm3xuTsdQAw+7Lzzw9IYCpX2Nl
/N3gX6T0K/CFcUHUZyX7GrGXrtaZghNB0m6lG5kngOcLqagAMYIDGzCCAxcCAQEwWjBUMRQw
EgYDVQQKEwtDQWNlcnQgSW5jLjEeMBwGA1UECxMVaHR0cDovL3d3dy5DQWNlcnQub3JnMRww
GgYDVQQDExNDQWNlcnQgQ2xhc3MgMyBSb290AgJXATAJBgUrDgMCGgUAoIIBljAYBgkqhkiG
9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wODA2MTYyMDQzNTNaMCMGCSqG
SIb3DQEJBDEWBBSjm7vVu8Wl19JAsZ49JTfvjaBExDBfBgkqhkiG9w0BCQ8xUjBQMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwaQYJKwYBBAGCNxAEMVwwWjBUMRQwEgYDVQQKEwtDQWNl
cnQgSW5jLjEeMBwGA1UECxMVaHR0cDovL3d3dy5DQWNlcnQub3JnMRwwGgYDVQQDExNDQWNl
cnQgQ2xhc3MgMyBSb290AgJXATBrBgsqhkiG9w0BCRACCzFcoFowVDEUMBIGA1UEChMLQ0Fj
ZXJ0IEluYy4xHjAcBgNVBAsTFWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzEcMBoGA1UEAxMTQ0Fj
ZXJ0IENsYXNzIDMgUm9vdAICVwEwDQYJKoZIhvcNAQEBBQAEggEAFCwyKp42AGyT7c0RHOn8
009xVbL3Qbm3hNpI3Sakq7ND9gwb8MFTM2B/Exy4AsMbR/mgzJSau5MNme7oSG0J6gnz/2G0
1sbetSflRfvAYCzRaZ7UxjcK7uROy0V5knNNsd+m5y+JIf6JPXdefpTwSrh4ptnMns8rDkrO
LSQrtJAnD++0TkJieM1W1R2MtG64dF8ODZHi9Xru8+yfH3Tu63AVp9FEldJhcZZLRrhfwpjB
BWrD0HPzFCdUsEJUwwtFglbhxuU+SycL1ew/CqHSs6WvotrsHg3fxQrYPIZ5hpLR6pO5EjRM
MVvtXxrF/4feHb1ROidTDOkYGIXFB5acegAAAAAAAA==
--------------ms070009090007030901080708--
