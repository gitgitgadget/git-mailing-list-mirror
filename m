From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 13:22:36 -0400
Message-ID: <200504251722.j3PHMalh017453@turing-police.cc.vt.edu>
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
            <426D21FE.3040401@tiscali.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1114449756_5553P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:29:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ7Ns-0008Bk-Vl
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 19:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVDYRca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 13:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVDYRZG
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:25:06 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37650 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262726AbVDYRWy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 13:22:54 -0400
Received: from turing-police.cc.vt.edu (localhost [127.0.0.1])
	by turing-police.cc.vt.edu (8.13.4/8.13.4) with ESMTP id j3PHMalh017453;
	Mon, 25 Apr 2005 13:22:36 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
In-Reply-To: Your message of "Mon, 25 Apr 2005 18:59:42 +0200."
             <426D21FE.3040401@tiscali.de> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--==_Exmh_1114449756_5553P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Apr 2005 18:59:42 +0200, Matthias-Christian Ott said:

> And if you think =22register=22 variables are outdated, please remove t=
he=20
> CONFIG_REGPARM option from the Kernel source.

I think you fail to understand the difference between what CONFIG_REGPARM=
 does
(namely, controlling the way parameters are passed to function calls) and=
 what
the 'register' declaration does....

> =5B2=5D Erik de Castro Lopo, Peter Aitken, Bradley L. Jones: Teach Your=
self=20
> C for Linux Programming in 21 Days; SAMS Publishing; 1999

Umm.. Yeah.  =22Teach yourself FOO in 21 days=22.  Quite the outstanding =
authority
to cite.  Gotta love the publisher too.. ;)


--==_Exmh_1114449756_5553P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCbSdccC3lWbTT17ARAh/fAKDZx1i+JXNXDQoeJMZnyytFn8nADQCeKgFC
gsbk15PHBohZYSzlymvPXYo=
=wfrs
-----END PGP SIGNATURE-----

--==_Exmh_1114449756_5553P--
