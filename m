From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Mon, 4 Jul 2005 15:53:27 +0200
Message-ID: <20050704135327.GA32098@kiste.smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630193825.GA17345@pc117b.liacs.nl> <20050630210023.GY10850@kiste.smurf.noris.de> <20050704130324.GK18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
X-From: git-owner@vger.kernel.org Mon Jul 04 15:55:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpRPb-0005W4-Bf
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 15:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVGDNyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 09:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVGDNyn
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 09:54:43 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:10448 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261708AbVGDNyY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 09:54:24 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DpRO4-0006vk-Vl
	for git@vger.kernel.org; Mon, 04 Jul 2005 15:53:42 +0200
Received: (nullmailer pid 18050 invoked by uid 501);
	Mon, 04 Jul 2005 13:53:28 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050704130324.GK18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sven Verdoolaege:
> Why not an explicit '-z' option as in the current git-cvsimport-script ?

Because my code doesn't support compressed cvs connections:
a -z that doesn't work except for the rlog part would be a lie.

Feel free to add that code. ;-)

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Confidence is simply that quiet, assured feeling you have before you
fall flat on your face.

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCyT9X8+hUANcKr/kRAuwjAJ4jNy4GFZyzhNev/FfZX+NEbStDqwCdGGcS
2tgBM8k9wVguD4XM6XuK6SQ=
=MCyw
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
