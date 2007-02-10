From: Mukund <muks@mukund.org>
Subject: [PATCH] Fixed some typos in git-repack docs
Date: Sat, 10 Feb 2007 23:42:01 +0530
Message-ID: <45CE0AF1.50101@mukund.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig129E55A4927EF8C309DB24DF"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 10 20:04:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFxWq-0005hm-1J
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 20:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbXBJTEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 14:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbXBJTEr
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 14:04:47 -0500
Received: from lucifer.nerdfest.org ([216.243.209.218]:52358 "EHLO
	lucifer.nerdfest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbXBJTEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 14:04:47 -0500
X-Greylist: delayed 3157 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Feb 2007 14:04:46 EST
Received: from [192.168.1.31] ([59.93.78.41])
	(authenticated bits=0)
	by lucifer.nerdfest.org (8.13.1/8.13.1) with ESMTP id l1AIC279003979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 10 Feb 2007 12:12:05 -0600
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
X-Enigmail-Version: 0.94.2.0
X-Virus-Scanned: ClamAV 0.88.2/2546/Sat Feb 10 02:55:09 2007 on lucifer.nerdfest.org
X-Virus-Status: Clean
X-Spam-Status: No, score=4.0 required=9.0 tests=AWL,BAYES_00,RCVD_IN_DSBL,
	RCVD_IN_NJABL_DUL,RCVD_IN_NJABL_PROXY,RCVD_IN_XBL autolearn=no 
	version=3.0.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on 
	lucifer.nerdfest.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39255>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig129E55A4927EF8C309DB24DF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

---
 Documentation/git-repack.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 4a57ce8..d39abc1 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -30,9 +30,9 @@ OPTIONS
 	Instead of incrementally packing the unpacked objects,
 	pack everything available into a single pack.
 	Especially useful when packing a repository that is used
-	for a private development and there no need to worry
-	about people fetching via dumb protocols from it.  Use
-	with '-d'.
+	for private development and there is no need to worry
+	about people fetching via dumb file transfer protocols
+	from it.  Use with '-d'.
=20
 -d::
 	After packing, if the newly created packs make some
--=20
1.4.4.2


--=20
Banu -- Free software for science, media and graphics
http://www.banu.com/


--------------enig129E55A4927EF8C309DB24DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iQIVAwUBRc4K8Yjwm1VMKmz1AQrf7A//Xvp7hYIKLMjUCN8SSU8mX1XoijhaJCc3
DC4qWPYKfkQP9LpowRwp5anIYsbIpTf4T4aYeiSs8mkm7S53YaGl0M/BNEUt1iVC
OKInPtJ0i9B72/++NMPo/vlzqQYJKy3/taIBx2UHljNhiMFemdEWJYNqaBG+AJMn
HpkR+zKjS/2UQ9Yshycl3ipaOk2Szc/3Rdinwyfr+ngWm3B7w9aOVJfbtIANNTVq
GxYyYet80UEnGh3bCYjf5+ca/QPHUsbPub4fIVrV5dof8ZHbKvSz0zoKqv4LCDWV
BKpVR33bKUvxmdMCUUoN764ssbFvWNxKJLSSGFEvusRk9ri6Jgm1i7WWRNDtF3OA
jONUe1gj4X/CKxln1EBvLKDW177bKpA2yVRLqbt71uqxKHEL9v9IpSPfG/TskNWV
mFYGzx+ladvr3j31VXYPi2+SLcUb4RkdNEfthsHpX6CEehJET4B0WKtGEci3kt2d
Oiv09j3LUxhfPuNpdterS3o+jW1hznHPMFSE/yL4Nmz5aiF595+ESt5v9DWMoFZW
qJYyBCQn58EZsJ+Q4B/vTS6W4q2Enb55FU/pRhfT+khXMXtcA3QQmWrLFn4Bidz6
Zqm5ntZYNjePdVRrKhW13YEPEaMVf0Dj0dtc+436TKnxD1vHlEskewB9JvEPgHYT
uczf2GorybM=
=eMxb
-----END PGP SIGNATURE-----

--------------enig129E55A4927EF8C309DB24DF--
