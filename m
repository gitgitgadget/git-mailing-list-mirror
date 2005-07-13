From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] git-cvsimport-script: parse multidigit revisions
Date: Wed, 13 Jul 2005 03:18:18 +0200
Message-ID: <20050713011818.GM9915@kiste.smurf.noris.de>
References: <20050712213531.GA10936@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ggdAeHltlv4tpqCr"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 13 03:25:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsVzV-00022X-EH
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 03:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVGMBYB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 21:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVGMBWO
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 21:22:14 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:5334 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262825AbVGMBUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 21:20:06 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DsVtD-0003F6-5t; Wed, 13 Jul 2005 03:19:36 +0200
Received: (nullmailer pid 13875 invoked by uid 501);
	Wed, 13 Jul 2005 01:18:18 -0000
To: Sven Verdoolaege <skimo@liacs.nl>
Content-Disposition: inline
In-Reply-To: <20050712213531.GA10936@pc117b.liacs.nl>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--ggdAeHltlv4tpqCr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sven Verdoolaege:
> Previously, git-cvsimport-script would fail
> on revisions with more than one digit.
>=20
Ouch. Thanks.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
When a guy says...
Good idea.
	He really means....
It'll never work.  And I'll spend the rest of the day gloating.

--ggdAeHltlv4tpqCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1Gva8+hUANcKr/kRAqwtAKCX7RuCHUEEIkRaBYqlV/zn9gllLwCeLEsE
YirXd30avdg1u9+WUWcDbJw=
=N/DM
-----END PGP SIGNATURE-----

--ggdAeHltlv4tpqCr--
