From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] add git-browse-help to the ignore list
Date: Tue, 11 Dec 2007 10:21:01 +0100
Message-ID: <20071211092101.GD30948@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="tEFtbjk+mNEviIIX";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 10:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J21Ix-000068-K8
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 10:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbXLKJVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 04:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbXLKJVG
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 04:21:06 -0500
Received: from pan.madism.org ([88.191.52.104]:34725 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbXLKJVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 04:21:03 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8BF2C2F491
	for <git@vger.kernel.org>; Tue, 11 Dec 2007 10:21:02 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 9CB29FF9E; Tue, 11 Dec 2007 10:21:01 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67829>


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  Here is a missing new command in the ignore list. See next patch for
an alternative solution to the problem ;)

 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index bac60ce..5eaba41 100644
--- a/.gitignore
+++ b/.gitignore
@@ -12,6 +12,7 @@ git-archive
 git-bisect
 git-blame
 git-branch
+git-browse-help
 git-bundle
 git-cat-file
 git-check-attr
--=20
1.5.3.7.2224.gb695b


--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXlZ9vGr7W6HudhwRAtOOAJ9PLFRZHfi3bLR2/I36T2mgN9QHkwCcD5SI
3t8beSsh1ortMTqaLxeGKCI=
=8ynh
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
