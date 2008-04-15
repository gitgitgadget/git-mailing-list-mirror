From: Nico -telmich- Schottelius <nico-git-20080415@schottelius.org>
Subject: [new tool] git-project-version.sh
Date: Tue, 15 Apr 2008 13:36:29 +0200
Message-ID: <20080415113629.GA17459@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 13:36:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JljRz-0004wK-R5
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 13:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757634AbYDOLet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 07:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757752AbYDOLet
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 07:34:49 -0400
Received: from [62.65.138.77] ([62.65.138.77]:46183 "EHLO mx2.schottelius.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1757602AbYDOLes (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 07:34:48 -0400
Received: from denkbrett.schottelius.org (natgw.netstream.ch [62.65.128.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.schottelius.org (Postfix) with ESMTPSA id 3A68E325BBC
	for <git@vger.kernel.org>; Tue, 15 Apr 2008 13:34:43 +0200 (CEST)
Received: by denkbrett.schottelius.org (Postfix, from userid 1000)
	id D8E0E19002; Tue, 15 Apr 2008 13:36:29 +0200 (CEST)
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.24.3-denkbrett on x86_64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79587>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

As I want to use the latest commit id in all my projects, so I know
which commit the version is based on, I wrote an extremly simple script
that is based on git-show to display only the version named
git-project-version.sh.

You can find it in
   http://unix.schottelius.org/git/git-tools.git/.git/
   http://unix.schottelius.org/cgi-bin/gitweb.cgi?p=3Dgit-tools.git/.git;a=
=3Dsummary
and more information is available on
   http://nico.schottelius.org/notizbuch-blog/archive/2008/04/15/git-projec=
t-version-sh-written-versions-with-git/

Sincerly

Nico

ps: please cc on reply, I am not subscribed.

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIBJM9uL75KpiFGIwRAg9RAJsEhMkNZm0YT8kz2t9MSrZEacxaigCgxv0W
QC+N8HHUmJiceynye64hzzc=
=Ew+e
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
