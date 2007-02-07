From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: suggestino for git-bisect man page
Date: Wed, 7 Feb 2007 14:41:16 +0100
Message-ID: <200702071441.18573.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1984600.GrJTJYqzCl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 14:41:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEn3M-0000FV-Pa
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 14:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161301AbXBGNlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 08:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161303AbXBGNlX
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 08:41:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:33640 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161301AbXBGNlV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 08:41:21 -0500
Received: (qmail invoked by alias); 07 Feb 2007 13:41:19 -0000
X-Provags-ID: V01U2FsdGVkX18fY8lqKm4fs0eIhty3U33OknwyvP5HS7E+n1xGyd
	W2Pg==
User-Agent: KMail/1.9.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38923>

--nextPart1984600.GrJTJYqzCl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It would be helpful in the man page for git-bisect to mention that for
$> git bisect replay that-file
the file .git/BISECT_LOG should be copied eg into /tmp/foo and then
/tmp/foo should be edited and be used.

I truncated .git/BISECT_LOG and did an
$>git bisect replay .git/BISECT_LOG
and wasn't surprised by the effect :-(


=2D-=20
MfG/Sincerely

Toralf F=F6rster

--nextPart1984600.GrJTJYqzCl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFydb+hyrlCH22naMRAtpIAJ9ecGDOgENjybb3wHbQNnt9QmKaeACfXyUZ
h1Zil4dorBEY7rx0IdK58rI=
=clUb
-----END PGP SIGNATURE-----

--nextPart1984600.GrJTJYqzCl--
