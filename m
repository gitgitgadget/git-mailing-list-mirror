From: Josh Triplett <josh@freedesktop.org>
Subject: [PATCH 1/2] Add missing reference to GIT_COMMITTER_DATE in git-commit-tree
 documentation
Date: Sat, 28 Apr 2007 18:40:12 -0700
Message-ID: <4633F77C.6030605@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB6BF8C3AF7C3B54C50297067"
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 03:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhyOv-0001y6-PU
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 03:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbXD2Bka (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 21:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbXD2Bka
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 21:40:30 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:44049 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbXD2BkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 21:40:15 -0400
Received: (qmail 31567 invoked from network); 29 Apr 2007 01:40:14 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail1.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 29 Apr 2007 01:40:14 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45808>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6BF8C3AF7C3B54C50297067
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 Documentation/git-commit-tree.txt |    1 +
 Documentation/git.txt             |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit=
-tree.txt
index cf25507..1571dbb 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -60,6 +60,7 @@ either `.git/config` file, or using the following envir=
onment variables.
 	GIT_AUTHOR_DATE
 	GIT_COMMITTER_NAME
 	GIT_COMMITTER_EMAIL
+	GIT_COMMITTER_DATE
=20
 (nb "<", ">" and "\n"s are stripped)
=20
diff --git a/Documentation/git.txt b/Documentation/git.txt
index ca1f78f..08ba53a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -344,6 +344,7 @@ git Commits
 'GIT_AUTHOR_DATE'::
 'GIT_COMMITTER_NAME'::
 'GIT_COMMITTER_EMAIL'::
+'GIT_COMMITTER_DATE'::
 	see gitlink:git-commit-tree[1]
=20
 git Diffs
--=20
1.5.1.1



--------------enigB6BF8C3AF7C3B54C50297067
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGM/d8GJuZRtD+evsRAqSpAJ97J8vMGCYfVrgOvBQi1GKn/Sn/WwCeLGgf
yljFl3UJvbFgIYECPhmL/S0=
=8Ka5
-----END PGP SIGNATURE-----

--------------enigB6BF8C3AF7C3B54C50297067--
