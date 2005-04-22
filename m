From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [git pasky] tarball question
Date: Sat, 23 Apr 2005 01:09:42 +0200
Message-ID: <1114211383.27940.1.camel@nosferatu.lan>
References: <1114180303.29271.25.camel@nosferatu.lan>
	 <20050422224251.GE21204@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6TdRXacUQwpiFvn5klhZ"
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 01:01:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP79V-00043Q-8s
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 01:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVDVXGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVDVXGE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:06:04 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:61431 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S261271AbVDVXFr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 19:05:47 -0400
Received: from gateway.lan (wblv-146-254-56.telkomadsl.co.za [165.146.254.56])
	by ctb-mesg5.saix.net (Postfix) with ESMTP id BFF33254D;
	Sat, 23 Apr 2005 01:05:43 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 3C40A3A2430;
	Sat, 23 Apr 2005 01:12:05 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02751-11; Sat, 23 Apr 2005 01:12:00 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id EEA213A241A;
	Sat, 23 Apr 2005 01:11:59 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422224251.GE21204@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-6TdRXacUQwpiFvn5klhZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-04-23 at 00:42 +0200, Petr Baudis wrote:
> Dear diary, on Fri, Apr 22, 2005 at 04:31:43PM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > Hi,
>=20
> Hi,
>=20
> > I understand why you have the git-pasky-0.6.x.tar.bz2 tarballs with
> > the .git database included as well (btw, great stuff renaming it to
> > something more distributable), but its going to be a pita for users of
> > source based distro's like us (Gentoo), as well as our mirrors if it
> > gets much bigger. (Already asked r3pek to add it to portage).
>=20
> yes; that was actually the plan, it's just that my memory is so
> volatile...
>=20

Yep, saw before you posted about the change in URL, thanks.

> > How about ripping the .git directory from the next release, and just
> > have a un-numbered tarball (like you used to) that have the latest
> > snapshot of the .git directory for those that want to do git-pasky
> > development?  Should even make things easier your side, as you could
> > just do a cron to update it one a day/whatever.
>=20
> Does it actually make sense to keep a tarball with history? Just build
> git-pasky and do git init. (Or rsync it manually.)
>=20

Well, I did not know about kernel.org hosting it, so I thought it might
help due to your reasons for initially tarballing the whole thing =3D)


Thanks,

--=20
Martin Schlemmer


--=-6TdRXacUQwpiFvn5klhZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCaYQ2qburzKaJYLYRAqwlAJ9if7dcIBdaniTC0GSfcAFadIxfugCdEtAX
ZNXRqQrBcyBVvZAazPHF8Vw=
=1/1t
-----END PGP SIGNATURE-----

--=-6TdRXacUQwpiFvn5klhZ--

