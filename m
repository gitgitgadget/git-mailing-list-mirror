From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 22:32:48 +0200
Message-ID: <20050811203248.GC5411@kiste.smurf.noris.de>
References: <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com> <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com> <20050811201558.GA2874@mars.ravnborg.org> <E1E3Jag-0005Tm-EQ@highlab.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 22:35:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3Jkg-0005Ep-IX
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 22:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVHKUdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 16:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVHKUdi
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 16:33:38 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:47840 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S932421AbVHKUdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 16:33:37 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1E3JjN-00052U-Kd; Thu, 11 Aug 2005 22:32:56 +0200
Received: (nullmailer pid 21199 invoked by uid 501);
	Thu, 11 Aug 2005 20:32:48 -0000
To: Sebastian Kuzminsky <seb@highlab.com>
Content-Disposition: inline
In-Reply-To: <E1E3Jag-0005Tm-EQ@highlab.com>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sebastian Kuzminsky:
> > The cg script has a bit more value.
>=20
> Tried that too, and I got the bug reports to prove it.  ;-)
>=20
Another possible solution: Rename git's git to X and install ours as Y.
Ask the user which should be symlinked to /usr/bin/git, if both are
installed, via the existing "alternatives" system.

(The install scripts to Gnu Interactive Tools should of course do the
same thing.)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Too much of a good thing is WONDERFUL.
		-- Mae West

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC+7Xw8+hUANcKr/kRAn7EAJ96WMeU7a/z7qHOSgz99bjnbo/MYgCfTwsA
st1e1sBBvbs8bIU00vl+CnY=
=G6bJ
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
