From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: I've added Dulwich to the Git Wiki
Date: Sat, 17 Jan 2009 00:03:11 +0100
Message-ID: <1232146991.24098.13.camel@ganieda.vernstok.nl>
References: <alpine.DEB.1.00.0901162329340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v+SVwGWtfbkzbs55R7xZ"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 17 00:05:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNxkb-00063o-NG
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 00:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682AbZAPXDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 18:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754668AbZAPXDv
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 18:03:51 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:2046 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833AbZAPXDv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 18:03:51 -0500
Received: from rhonwyn.vernstok.nl (rhonwyn.vernstok.nl [82.95.177.153])
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id n0GN3kFH088695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 17 Jan 2009 00:03:48 +0100 (CET)
	(envelope-from jelmer@samba.org)
Received: from localhost (localhost [127.0.0.1])
	by rhonwyn.vernstok.nl (Postfix) with ESMTP id 8E08239A598;
	Sat, 17 Jan 2009 00:03:45 +0100 (CET)
Received: from rhonwyn.vernstok.nl ([127.0.0.1])
	by localhost (rhonwyn.vernstok.nl [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id YUWgR9SsvlHw; Sat, 17 Jan 2009 00:03:34 +0100 (CET)
Received: from [192.168.4.6] (ganieda.vernstok.nl [192.168.4.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: jelmer)
	by rhonwyn.vernstok.nl (Postfix) with ESMTPSA id E653D39A4E7;
	Sat, 17 Jan 2009 00:03:34 +0100 (CET)
In-Reply-To: <alpine.DEB.1.00.0901162329340.3586@pacific.mpi-cbg.de>
X-Mailer: Evolution 2.22.3.1 
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-v+SVwGWtfbkzbs55R7xZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Fri, 2009-01-16 at 23:42 +0100, Johannes Schindelin wrote:
> just got aware of the Dulwich project, which purports to be a pure Python=
=20
> Git engine.  I added it here:
>=20
> http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-762f9c85c62c555=
dbb88129a127431ddeeb56191
Thanks! I wasn't actually aware of that wiki page.

> Jelmer, is there a chance you can export the Bazaar repository into a=20
> public Git repository?  The Bazaar web-frontend does not even allow me to=
=20
> download a snapshot.
See:

git://git.samba.org/jelmer/dulwich.git

And gitweb: http://git.samba.org/?p=3Djelmer/dulwich.git;a=3Dsummary

> BTW I find it a bit distressing that more and more projects crop up doing=
=20
> substantial and valuable work around Git, but without even bothering to=20
> mention it on this list.  There might have been a good chance, too, to=20
> avoid having _three_ Python libraries for exactly the same task.
I wasn't aware of PyGit (and its homepage doesn't seem to work), but
Python-Git is just a wrapper around the git command line tools, it
doesn't parse/write the file formats itself.

Cheers,

Jelmer

--=20
Jelmer Vernooij <jelmer@samba.org> - http://samba.org/~jelmer/
Jabber: jelmer@jabber.fsfe.org

--=-v+SVwGWtfbkzbs55R7xZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iJwEAAECAAYFAklxEiwACgkQDLQl4QYPZuUZVQQApJAwJkzvEvx7gb+OLEdXTdDS
qG9NyPw+fR2IRfvBV7vdNwWF+5stlizTce18c15Zxk7ZPmgavZmwYclqz0zVeXfr
a+hDPA4ngzp92KEQOp0uoQ3ZHyFb4pQDaZDNpk+yPciriOMGim97WijnDmq/lzAb
epr/WiUtic47si4Yilc=
=OoYE
-----END PGP SIGNATURE-----

--=-v+SVwGWtfbkzbs55R7xZ--
