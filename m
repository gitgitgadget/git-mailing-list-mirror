From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: git -1.4.1.1 bisect enhancement:show steps too instead only the number of revisions
Date: Fri, 8 Sep 2006 19:09:29 +0200
Message-ID: <200609081909.33361.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1294217.vYhfGcOcL2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 08 19:10:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLjrH-0008Qz-Vt
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 19:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWIHRJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 13:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWIHRJh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 13:09:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:51632 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750700AbWIHRJg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 13:09:36 -0400
Received: (qmail invoked by alias); 08 Sep 2006 17:09:34 -0000
Received: from c228023.adsl.hansenet.de (EHLO c228023.adsl.hansenet.de) [213.39.228.23]
  by mail.gmx.net (mp045) with SMTP; 08 Sep 2006 19:09:34 +0200
X-Authenticated: #5108953
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26701>

--nextPart1294217.vYhfGcOcL2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

What about telling the user/tester the number of (possible) reboots too and=
 not only the amount of revisions, eg instead:
"3308 revisions left to test after this"
print a line like
"3308 revisions (~ 12 steps) left to test after this"

b/c ld 3308 =3D 12 steps until finish, isn't it ?

=2D-=20
MfG/Sincerely
Toralf F=F6rster

--nextPart1294217.vYhfGcOcL2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFAaPNhyrlCH22naMRAjJsAJ9ehW7C8UViNbIs43foJ3yqXCbluACghmxJ
TNBS7VF/zRZICO9n4iXkzTs=
=m7X7
-----END PGP SIGNATURE-----

--nextPart1294217.vYhfGcOcL2--
