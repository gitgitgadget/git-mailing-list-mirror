From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] git-diff-*: Allow "--name-only -z" as alias for "--name-only-z"
Date: Fri, 15 Jul 2005 01:29:19 +0200
Message-ID: <20050714232918.GB9915@kiste.smurf.noris.de>
References: <20050714215126.GY9915@kiste.smurf.noris.de> <7vvf3d6nis.fsf@assigned-by-dhcp.cox.net> <20050714223622.GZ9915@kiste.smurf.noris.de> <7vmzop56fo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KtWcatouGV9Nk9BU"
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 01:37:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtDGg-0002y6-El
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 01:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVGNXgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 19:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVGNXgv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 19:36:51 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:56250 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262754AbVGNXf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 19:35:29 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DtDEH-0002Ff-Gj; Fri, 15 Jul 2005 01:34:57 +0200
Received: (nullmailer pid 9374 invoked by uid 501);
	Thu, 14 Jul 2005 23:29:19 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzop56fo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--KtWcatouGV9Nk9BU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Junio C Hamano:
> That said, I have been hating that diff options parsing for
> quite a while, and I've been thinking about cleaning it up along
> the lines I'll outline here, but have not done anything about
> it.  Care to help me out?
>=20
I saw the problem...
>=20
> Hmm?
>=20
Sure -- assuming I find some time to actually do it over the next few days.

The problem is that this has been a problem lately. :-/

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Illiterate?  Write today, for free help!

--KtWcatouGV9Nk9BU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1vVO8+hUANcKr/kRAuN6AJoDghjFWVMaGC++f/bxi8NJKK2ZTACfYZCS
yxTMrfkHbYFRHLP7TfD2j88=
=0MBX
-----END PGP SIGNATURE-----

--KtWcatouGV9Nk9BU--
