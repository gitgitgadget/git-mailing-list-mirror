From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: SVN import
Date: Mon, 10 Oct 2005 20:57:30 +0200
Message-ID: <20051010185729.GR567@kiste.smurf.noris.de>
References: <pan.2005.08.19.10.00.49.401829@smurf.noris.de> <pan.2005.10.10.09.45.00.468989@smurf.noris.de> <8764s51cvp.wl@mail2.atmark-techno.com> <20051010181329.GQ567@kiste.smurf.noris.de> <874q7p1axz.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NJSRbAqOy4NeGDns"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 21:00:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP2r6-0003wT-K9
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 20:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVJJS6d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 14:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVJJS6d
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 14:58:33 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:26000 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1751050AbVJJS6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 14:58:33 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EP2q3-0006Ws-ID; Mon, 10 Oct 2005 20:57:46 +0200
Received: (nullmailer pid 9817 invoked by uid 501);
	Mon, 10 Oct 2005 18:57:30 -0000
To: Yasushi SHOJI <yashi@atmark-techno.com>
Content-Disposition: inline
In-Reply-To: <874q7p1axz.wl@mail2.atmark-techno.com>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9910>


--NJSRbAqOy4NeGDns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Yasushi SHOJI:
> > True. I could add an option which behaves as if everything that's not
> > recognized is seen as being on the trunk, but ...
>=20
> hmmm. can libsvn see those file had moved in to the trunk?  don't know
> how 'svn mv' is treated in svn.
>=20
see "svn log". The script sees the file, and where it comes from (but
ignores that).

> # I guess I need to wait for mirroring script to catch up?

? it was uptodate when I wrote that mail; see
http://netz.smurf.noris.de/cgi/gitweb?p=3Dgit.git;a=3Dshortlog;h=3Dsvn

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
All intelligent species own cats.

--NJSRbAqOy4NeGDns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDSrmZ8+hUANcKr/kRApsqAKCAAx5WjqZkLdzXc2IQ7w8ikUuTwQCfbUj7
KcCSF/GerT+RlKLrD5Wy9Y0=
=sgN1
-----END PGP SIGNATURE-----

--NJSRbAqOy4NeGDns--
