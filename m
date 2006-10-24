From: Tobias Toedter <t.toedter@gmx.net>
Subject: Question about commit message conventions
Date: Tue, 24 Oct 2006 15:49:44 +0200
Message-ID: <200610241549.48238.t.toedter@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2888093.YRmCuZOLDL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 24 15:50:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcMfG-0005fo-38
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 15:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbWJXNty (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 09:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWJXNty
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 09:49:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:30907 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965145AbWJXNtx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 09:49:53 -0400
Received: (qmail invoked by alias); 24 Oct 2006 13:49:52 -0000
Received: from d034248.adsl.hansenet.de (EHLO homer.local) [80.171.34.248]
  by mail.gmx.net (mp035) with SMTP; 24 Oct 2006 15:49:52 +0200
X-Authenticated: #7842102
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29976>

--nextPart2888093.YRmCuZOLDL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

although I've read the documentation of git very carefully, I could not fin=
d=20
anything related to certain commit message conventions. It would be great=20
if someone here could explain a few things, maybe this could be added to=20
the wiki afterwards (<http://git.or.cz/gitwiki/CommitMessageConventions>).

=46irst of all, what's the intended use of the "Signed-off-by:" lines? Does=
 it=20
make sense to add my name there, even when I'm listed as the author or=20
committer of a commit? I thought that they are intended mostly to note the=
=20
approval of other developers.

On the other hand, concerning the approval of other developers, what's the=
=20
difference between "Signed-off-by:" and "Acked-by:"? Are there any=20
more "*-by:" fields that are in use?

Regards,
Tobias

=2D-=20
Tobias Toedter   | "I don't care to belong to a club that accepts people
Hamburg, Germany | like me as members." -- Groucho Marx

--nextPart2888093.YRmCuZOLDL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFPhn8CqqEJ0Fs8twRAk47AKCAI33bXCz2YKRyoPKu7AKnZ083bACglb/A
710wH3Obzb/Kp+/We8ejg28=
=68G1
-----END PGP SIGNATURE-----

--nextPart2888093.YRmCuZOLDL--
