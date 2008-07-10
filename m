From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: feature request: git-log should accept sth like v2.6.26-rc8-227
Date: Thu, 10 Jul 2008 20:57:12 +0200
Message-ID: <200807102057.15063.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5665137.8bja5Eh5tz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 21:06:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH1TS-0005yX-VB
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 21:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbYGJS5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 14:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbYGJS5T
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 14:57:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:59698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752545AbYGJS5S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 14:57:18 -0400
Received: (qmail invoked by alias); 10 Jul 2008 18:57:16 -0000
Received: from d072181.adsl.hansenet.de (EHLO d072181.adsl.hansenet.de) [80.171.72.181]
  by mail.gmx.net (mp057) with SMTP; 10 Jul 2008 20:57:16 +0200
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX19JRRhJ27FJgdAGi3DriL/QUspDxISpmtLl3/BUL3
	Pk4Z60FaBvF4mL
User-Agent: KMail/1.9.9
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87996>

--nextPart5665137.8bja5Eh5tz
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

git-describe gives an informative string about the current status:
tfoerste@n22 ~/devel/linux-2.6 $ git describe
v2.6.26-rc9-56-g6329d30

I appended those strings to the names of my UML kernel executables.
Unfortunately I didn't used the commit id and now I'm wondering whether git
could accept v2.6.26-rc9-56 as well in future.

=2D-=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--nextPart5665137.8bja5Eh5tz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkh2W4sACgkQhyrlCH22naNEJQCdFFesaYKP+6Z9RjS1eCS/YYXO
UOgAnip6RuJr6Aqz5BCBYx0Bdx6rINLS
=FHfM
-----END PGP SIGNATURE-----

--nextPart5665137.8bja5Eh5tz--
