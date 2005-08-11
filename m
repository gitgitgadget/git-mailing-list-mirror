From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Fri, 12 Aug 2005 01:12:06 +0200
Message-ID: <20050811231202.GF5411@kiste.smurf.noris.de>
References: <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com> <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com> <Pine.LNX.4.58.0508111448090.3295@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Cc: Sebastian Kuzminsky <seb@highlab.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 01:15:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3MGW-0000Bi-0n
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 01:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVHKXPI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 19:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVHKXPI
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 19:15:08 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:32208 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S932460AbVHKXPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 19:15:07 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1E3MDc-0001NA-Ss; Fri, 12 Aug 2005 01:13:46 +0200
Received: (nullmailer pid 24789 invoked by uid 501);
	Thu, 11 Aug 2005 23:12:06 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508111448090.3295@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Linus Torvalds:
> Hands up people. Does anybody _use_ GNU interactive tools? None of this "=
I=20
> have a package" crap.
>=20
You're preaching to the converted here.

The Debian-package-for-Debian could pop up a notice asking the user to
symlink /usr/local/bin/git =3D> /usr/bin/gitscm (or whatever) if they
want to use the "normal" name... that's probably the only solution which
would work reasonably well without being too much hassle to implement.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
For the right person, the impossible is easy!
					-- Dumbo

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC+9tC8+hUANcKr/kRAjCCAJ9lZn/gBrPlj/PLMfDjP433/+eEdACfYTVj
yYH9TTGGcSrjYm6K49fYCXI=
=WeM2
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
