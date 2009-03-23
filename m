From: David Reitter <david.reitter@gmail.com>
Subject: Importing Bzr revisions
Date: Sun, 22 Mar 2009 23:33:34 -0400
Message-ID: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; boundary=Apple-Mail-20--373506972; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 04:35:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llawq-0007BK-Gv
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 04:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbZCWDdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 23:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836AbZCWDdn
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 23:33:43 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:43577 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726AbZCWDdn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 23:33:43 -0400
Received: by ey-out-2122.google.com with SMTP id 4so473093eyf.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 20:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:mime-version:subject:date:x-mailer;
        bh=dqn9iw+lUMW08N4bLCaqDyK/EqSqimpg6Si5wgMJ3RM=;
        b=ZWw7sn2ltf9Ej/jV4iLmQj4P6E0fvGXaWXlOqwodgn49zg9fBRZm2MdrNPCcUTXA7Q
         VpaEG1u5Goz5ZO2rsBecYpZOhoNU80CdKxezUJQvz0mMuIuECaa2EIiy3fJU8QL98Djo
         EgtoVXUczOEb6IMBBgesNsy5omOhj65O0xOuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:mime-version:subject:date:x-mailer;
        b=LKCQGlcjyYuf+SSQSPTcvLXCG8WKnWTIeHhpN60um2WPEnegMYrJApZbIRco0ybd4B
         tWkCe0ltIi29HzTEuAPodPKPB1vMOs9gH19Mc1lXrMoG7Q7bjmx0ji9L/8pMb+LeJJ+/
         u8+8axcT/BJj6w+MyAq1VmeWdt5Pm/zTOq88M=
Received: by 10.210.45.17 with SMTP id s17mr5043213ebs.74.1237779220258;
        Sun, 22 Mar 2009 20:33:40 -0700 (PDT)
Received: from ?192.168.1.42? (pool-72-65-195-138.pitbpa.east.verizon.net [72.65.195.138])
        by mx.google.com with ESMTPS id 24sm321932eyx.58.2009.03.22.20.33.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 20:33:39 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114239>


--Apple-Mail-20--373506972
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Suppose I have a bzr branch that has been converted (somehow) to a git  
branch, is it then possible to merge new revisions from the bzr branch  
into the git one?
How would I go about doing that?

Thanks
- David

PS.: please cc me in replies.
--Apple-Mail-20--373506972
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFxDCCAn0w
ggHmoAMCAQICED6shx13jEDrq0eL8FRq5ykwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MTIwOTAyMDgwMVoXDTA5MTIwOTAyMDgw
MVowYjEQMA4GA1UEBBMHUmVpdHRlcjEOMAwGA1UEKhMFRGF2aWQxFjAUBgNVBAMTDURhdmlkIFJl
aXR0ZXIxJjAkBgkqhkiG9w0BCQEWF2RhdmlkLnJlaXR0ZXJAZ21haWwuY29tMIGfMA0GCSqGSIb3
DQEBAQUAA4GNADCBiQKBgQDOdo6kAwlkBxUb8dj4saMbYg4SVng8CUePFn3cjjWrakBTbUVa4Z0n
wlUxr7AitEeKhBy5nGhu96+jKUPrCwYNRCZ0l2ovvuGq4z1m1nZ5/c8WvFlVhieuxXMUfmb/O7D3
IojoX6iS8n5MNNU2IWNNT/AD3vOl6DKgOtOw4J9y+QIDAQABozQwMjAiBgNVHREEGzAZgRdkYXZp
ZC5yZWl0dGVyQGdtYWlsLmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAIjI8yEW
wkiEfA9PMgpjnD6KyCXT0iZjHhW2PkR53yZZLUoTboHnKgsFwYp/gzzIL8J5cvZaRUyMUzXDufPP
dRmxxCs2jXXLDD/8bvdvOuMzqgYoFA73fAfsC8S6qUL1PayZ90J8CZHNhDwqWqOA56T+DdKUegJT
sqoHKh6OnypTMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkEx
FTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3
dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEk
MCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJz
b25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVow
YjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEB
AQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU
5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8C
AQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFs
RnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2
YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aU
nX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3dqZw5
jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAo8wggKLAgEB
MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4x
LDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA+rIcdd4xA66tH
i/BUaucpMAkGBSsOAwIaBQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTA5MDMyMzAzMzMzNFowIwYJKoZIhvcNAQkEMRYEFIIFKn7PtJR9MZU6tkldisDLzWUF
MIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQPqyHHXeMQOurR4vwVGrnKTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpB
MSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQPqyHHXeMQOurR4vwVGrnKTANBgkqhkiG9w0B
AQEFAASBgBffy5K/Fyq8pwxnpgPIa6gLe7NJOysraRUnVkknGaKyiX9abM9ZdkZh/CPnFOA/g3tl
IZ8cUV0KwIzly2dNkE7bnOT/eOGoEREGDZ/xwjAiF300EokTplTMfvl23L4auu3G4Gh2xZ5BDiMV
VcWWzuNk3F+jG03q62eomDP/GQCEAAAAAAAA

--Apple-Mail-20--373506972--
