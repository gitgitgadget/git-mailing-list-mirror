From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] git-diff-*: Allow "--name-only -z" as alias for "--name-only-z"
Date: Fri, 15 Jul 2005 00:36:23 +0200
Message-ID: <20050714223622.GZ9915@kiste.smurf.noris.de>
References: <20050714215126.GY9915@kiste.smurf.noris.de> <7vvf3d6nis.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hy4a9G0dOYssRJVI"
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 00:40:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtCMq-0005FJ-Uf
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 00:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbVGNWjD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 18:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbVGNWix
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 18:38:53 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:23169 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S263167AbVGNWhq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 18:37:46 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DtCJc-0000Q6-5Q; Fri, 15 Jul 2005 00:36:47 +0200
Received: (nullmailer pid 30415 invoked by uid 501);
	Thu, 14 Jul 2005 22:36:23 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvf3d6nis.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--Hy4a9G0dOYssRJVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Junio C Hamano:
> I've considered it, but what happens if you give -z first and
> then name-only?
>=20
Exactly the same thing as vice versa.
Or, even more exactly, my patch *makes* that happen. ;-)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Isn't this a beautiful day! Just watch some bastard louse it up.

--Hy4a9G0dOYssRJVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1ujm8+hUANcKr/kRAo07AKCiaJXfCdQAYa9Xn69C2VrgiRxZjgCfUUGY
UIYA22gyaUfGaYyOtpiEXQU=
=+0aB
-----END PGP SIGNATURE-----

--Hy4a9G0dOYssRJVI--
