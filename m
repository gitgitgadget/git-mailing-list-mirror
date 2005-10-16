From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: SVN import
Date: Sun, 16 Oct 2005 19:42:10 +0200
Message-ID: <20051016174210.GA8297@kiste.smurf.noris.de>
References: <pan.2005.08.19.10.00.49.401829@smurf.noris.de> <pan.2005.10.10.09.45.00.468989@smurf.noris.de> <878xwuldvx.fsf@litku.valo.iki.fi> <7vy84tdhqv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Cc: git@vger.kernel.org, Kalle Valo <Kalle.Valo@iki.fi>
X-From: git-owner@vger.kernel.org Sun Oct 16 19:47:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERCZU-0000lm-DU
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 19:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVJPRnN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 13:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVJPRnN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 13:43:13 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:53687 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1751341AbVJPRnL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 13:43:11 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1ERCWR-00089d-4K; Sun, 16 Oct 2005 19:42:50 +0200
Received: (nullmailer pid 21787 invoked by uid 501);
	Sun, 16 Oct 2005 17:42:10 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy84tdhqv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10165>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Junio C Hamano:
> Matthias, how ready do you feel the code is?  Whenever you are
> ready, please just holler.
>=20
Hollering now.

There's one small omission, which is that the merge RX for SVN should
optionally recognize the SVN commit number it's merging from and use
the corresponsing git commit as the merge parent, but maybe somebody
else feels motivated to add that (hint, hint) .

> You seem to have a small cvsimport updates in the branch.  Mind
> feeding it to me independently?
>=20
Why? It already is a separate commit (89764f5d..., the one before
I added the svn script).

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The Public is merely a multiplied "me."
		-- Mark Twain

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDUpDy8+hUANcKr/kRAuJ6AJ9NXjDwcYRen/sDMPeXDxqlRVsabQCdEOcx
6/T3MVZfi5hZAWfWCq7EP4s=
=EYNy
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
