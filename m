From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 08:21:16 +0100
Message-ID: <20051118072115.GJ31613@kiste.smurf.noris.de>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de> <Pine.LNX.4.63.0511171652020.17402@wbgn013.biozentrum.uni-wuerzburg.de> <437D4924.50307@gmail.com> <Pine.LNX.4.63.0511180425200.6820@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4LwthZj+AV2mq5CX"
Cc: A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 08:48:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed0ZS-0005O1-Ai
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 08:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVKRHWD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 02:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVKRHWC
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 02:22:02 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:49055 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S932559AbVKRHWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 02:22:00 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Ed0Ye-0004iL-Kl; Fri, 18 Nov 2005 08:21:33 +0100
Received: (nullmailer pid 28054 invoked by uid 501);
	Fri, 18 Nov 2005 07:21:16 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511180425200.6820@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12205>


--4LwthZj+AV2mq5CX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Johannes Schindelin:
> Any chance you investigate this in detail? Like inserting "test_done;=20
> exit" right before that test, only running t4103-*, and then executing
> the command yourself?
>=20
Thank you, I know how to debug ;-)

Already in progress.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
A life spent in search of the perfect hash brownie is a life well spent.

--4LwthZj+AV2mq5CX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDfYDr8+hUANcKr/kRAk+FAKCqX9vRJixR/dDQbv0XtogaMP7CUgCfaO04
I/simJR8BW9Q6HBpuqkDdrk=
=S1bv
-----END PGP SIGNATURE-----

--4LwthZj+AV2mq5CX--
