From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 01:39:53 +0200
Message-ID: <20050810233953.GV28270@kiste.smurf.noris.de>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net> <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net> <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net> <pan.2005.08.10.21.15.41.143251@smurf.noris.de> <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <46a038f9050810155642bb5580@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FcSpk3Icpd/Pbul4"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 01:41:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E30CQ-0001fH-3k
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 01:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbVHJXl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 19:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVHJXl1
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 19:41:27 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:63682 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S932606AbVHJXl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 19:41:26 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1E30As-0002Jd-Ch; Thu, 11 Aug 2005 01:41:10 +0200
Received: (nullmailer pid 29907 invoked by uid 501);
	Wed, 10 Aug 2005 23:39:53 -0000
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f9050810155642bb5580@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--FcSpk3Icpd/Pbul4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Martin Langhoff:
> On 8/11/05, Matthias Urlichs <smurf@smurf.noris.de> wrote:
> > Debian packaging fixes for 0.99.4:
>=20
> Is this anywhere in the archive?
>=20
Cogito 0.12.1 (which includes git) has been packaged by Sebastian
Kuzminsky <seb@highlab.com>; it's in Debian Unstable. I assume
he'll do something about packaging the current version; I just filed a
wishlist bug in Debian.

The current "cogito" package in Debian renames both the git and cg
command line programs because there are already packages with conflicting
commands in Debian ("git" and "cgvg"). I consider that to be a mistake,
to be honest.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Coding is easy. All you do is sit staring at a terminal
until the drops of blood form on your forehead.

--FcSpk3Icpd/Pbul4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC+pBJ8+hUANcKr/kRAv/KAJwPi/u45hLVuXfqg/7BEY0++3e3wQCZARpY
KtJF4XnA+N1jBLR/8q6eFXA=
=t5zI
-----END PGP SIGNATURE-----

--FcSpk3Icpd/Pbul4--
