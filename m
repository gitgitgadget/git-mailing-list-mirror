From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Thu, 30 Jun 2005 18:10:43 +0200
Message-ID: <20050630161043.GR10850@kiste.smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OQpOxDqDax7rN7YB"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 18:05:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do1Xj-0005sQ-9M
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 18:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbVF3QMr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 12:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVF3QMr
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 12:12:47 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:15496 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S263000AbVF3QMA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 12:12:00 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Do1ci-000816-9g; Thu, 30 Jun 2005 18:11:00 +0200
Received: (nullmailer pid 7932 invoked by uid 501);
	Thu, 30 Jun 2005 16:10:43 -0000
To: Sven Verdoolaege <skimo@liacs.nl>
Content-Disposition: inline
In-Reply-To: <20050630154453.GA26808@pc117b.liacs.nl>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--OQpOxDqDax7rN7YB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sven Verdoolaege:
> Presumably you have an extraneous "\n" somewhere.
>=20
Strange.
That must have crept in when I switched from cg-commit to git-commit-tree.

I'll find it. However, you don't actually need to re-import your
existing CVS->GIT trees; as long as the dates and the branch names
match, my script will continue where the other left off.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You do not have mail.

--OQpOxDqDax7rN7YB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxBmD8+hUANcKr/kRArDHAKCGSZtnDN1DeKCZjLlBnqvy3OsWNACfY8LS
CEzxQB7AibrEn9dFz5dInIY=
=1SW4
-----END PGP SIGNATURE-----

--OQpOxDqDax7rN7YB--
