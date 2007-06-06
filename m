From: Josh Triplett <josh@freedesktop.org>
Subject: [PATCH] Fix typo in git-mergetool
Date: Tue, 05 Jun 2007 21:24:19 -0700
Message-ID: <466636F3.8020606@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF9B77E6F083AA00A1EC7A1EC"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 06:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvn5D-0005P8-1v
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 06:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbXFFEZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 00:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754053AbXFFEZF
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 00:25:05 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:32930 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbXFFEZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 00:25:03 -0400
Received: (qmail 3441 invoked from network); 6 Jun 2007 04:25:01 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail6.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 6 Jun 2007 04:25:01 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49242>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF9B77E6F083AA00A1EC7A1EC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 git-mergetool.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index e62351b..bb21b03 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2006 Theodore Y. Ts'o
 #
 # This file is licensed under the GPL v2, or a later version
-# at the discretion of Junio C Hammano.
+# at the discretion of Junio C Hamano.
 #
=20
 USAGE=3D'[--tool=3Dtool] [file to merge] ...'
--=20
1.5.2.1



--------------enigF9B77E6F083AA00A1EC7A1EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZjbzGJuZRtD+evsRAvlXAKC+DIOno36yLJ758jW5ghK6gFGpaACdGSuU
aYob46gacO55q4O088TFb7g=
=xnRE
-----END PGP SIGNATURE-----

--------------enigF9B77E6F083AA00A1EC7A1EC--
