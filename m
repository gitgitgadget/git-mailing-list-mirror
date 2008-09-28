From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] doc: enhance git describe --tags help
Date: Sun, 28 Sep 2008 17:12:59 +0200
Message-ID: <20080928151259.GJ5302@artemis.corp>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com> <20080928135526.GG5302@artemis.corp> <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com> <20080928143949.GH5302@artemis.corp> <20080928150318.GI5302@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="pWOmaDnDlrCGjNh4";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com, spearce@spearce.org,
	Junio C Hamano <gitster@pobox.com>
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 17:14:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjxyP-0000Vt-CQ
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 17:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbYI1PNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 11:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbYI1PND
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 11:13:03 -0400
Received: from pan.madism.org ([88.191.52.104]:57342 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbYI1PNC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 11:13:02 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8BC5E3B345;
	Sun, 28 Sep 2008 17:13:00 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 663E42AC9C; Sun, 28 Sep 2008 17:12:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080928150318.GI5302@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96974>


--pWOmaDnDlrCGjNh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-describe.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index c4dbc2a..9cc8c2f 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -30,7 +30,8 @@ OPTIONS
=20
 --tags::
 	Instead of using only the annotated tags, use any tag
-	found in `.git/refs/tags`.
+	found in `.git/refs/tags`. Though if an annotated tag is found in the
+	ancestry, it will always be preferred to lightweight tags.
=20
 --contains::
 	Instead of finding the tag that predates the commit, find
--=20
1.6.0.2.516.g12936.dirty

--pWOmaDnDlrCGjNh4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjfnvsACgkQvGr7W6HudhxvxQCdHsafraFgDiQCo2l+D0m1Pd1a
L34AnRCzTlW2JvhQ6STF9jI+esyJ3zvC
=MuDp
-----END PGP SIGNATURE-----

--pWOmaDnDlrCGjNh4--
