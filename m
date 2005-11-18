From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: "make test" fails with current HEAD
Date: Fri, 18 Nov 2005 12:12:04 +0100
Message-ID: <20051118111204.GO31613@kiste.smurf.noris.de>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de> <7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net> <20051118075117.GK31613@kiste.smurf.noris.de> <7vbr0imlha.fsf@assigned-by-dhcp.cox.net> <pan.2005.11.18.08.56.22.908009@smurf.noris.de> <Pine.LNX.4.63.0511181134080.8037@wbgn013.biozentrum.uni-wuerzburg.de> <20051118105415.GN31613@kiste.smurf.noris.de> <Pine.LNX.4.63.0511181203510.16457@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1HuzLmPZrG5RH6bG"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 12:14:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed4B3-0002rj-SX
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 12:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbVKRLM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 06:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbVKRLM6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 06:12:58 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:33434 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1161028AbVKRLM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 06:12:57 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Ed4A0-0002mo-PG; Fri, 18 Nov 2005 12:12:15 +0100
Received: (nullmailer pid 25632 invoked by uid 501);
	Fri, 18 Nov 2005 11:12:04 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511181203510.16457@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12226>


--1HuzLmPZrG5RH6bG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Johannes Schindelin:
> > So I still think a "Just write a 'Binary files FOO and BAR differ' line
> > if the exit status is 2" rule would at least fix the current bug with
> > diff 2.8.7.
>=20
> Dunno. Am I the only one with an odd feeling about that?
>=20
I don't really like it either, but frankly I'm not going to write a new
(or integrate an existing) diff implementation for 1.0 ... you want to
do it, feel free. ;-)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
BOFH excuse #217:

The MGs ran out of gas.

--1HuzLmPZrG5RH6bG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDfbcE8+hUANcKr/kRAl9iAKCZLnSp1k7KITn6gBwlFfqfQE/gXQCfRXhu
1kA1mcPMu2TupJZyiomcfRU=
=vuHR
-----END PGP SIGNATURE-----

--1HuzLmPZrG5RH6bG--
