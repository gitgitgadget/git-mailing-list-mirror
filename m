From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: SVN import
Date: Mon, 10 Oct 2005 22:52:02 +0200
Message-ID: <20051010205202.GS567@kiste.smurf.noris.de>
References: <pan.2005.08.19.10.00.49.401829@smurf.noris.de> <pan.2005.10.10.09.45.00.468989@smurf.noris.de> <8764s51cvp.wl@mail2.atmark-techno.com> <20051010181329.GQ567@kiste.smurf.noris.de> <874q7p1axz.wl@mail2.atmark-techno.com> <20051010185729.GR567@kiste.smurf.noris.de> <87y851yvfn.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1bhFRg6vL9BT9osV"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 22:55:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP4dS-0005oq-K0
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVJJUwf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVJJUwf
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:52:35 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:50874 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1751229AbVJJUwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 16:52:34 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EP4cu-0001fm-DN; Mon, 10 Oct 2005 22:52:17 +0200
Received: (nullmailer pid 1681 invoked by uid 501);
	Mon, 10 Oct 2005 20:52:02 -0000
To: Yasushi SHOJI <yashi@atmark-techno.com>
Content-Disposition: inline
In-Reply-To: <87y851yvfn.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9932>


--1bhFRg6vL9BT9osV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Yasushi SHOJI:
> anyway, here is another one if you are interested in.  svnimport
> doesn't seems to handle -t option, or what am i missing?
>=20
At first glance: you're only doing one check-in, which the -s2 option
therefore conveniently skips. git-svnimport therefore does nothing. ;-)

NB: Please put thpse svn scripts into a bunch of testcases, and send me a
    patch...

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"When a man is tired of Ankh-Morpork, he is tired of ankle-deep slurry."
		-- Terry Pratchett (Mort)

--1bhFRg6vL9BT9osV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDStRy8+hUANcKr/kRAkylAKCc7MoiSrAb3eG3h+qPCkEHoxV65gCgiExL
2dN60H06pYjULDK4AdXG3vo=
=FDSb
-----END PGP SIGNATURE-----

--1bhFRg6vL9BT9osV--
