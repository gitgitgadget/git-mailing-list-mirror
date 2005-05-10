From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 11:39:24 +0200
Message-ID: <20050510093924.GH11221@kiste.smurf.noris.de>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <7vis1rpi8a.fsf@assigned-by-dhcp.cox.net> <20050510093212.GD8176@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Cc: Junio C Hamano <junkio@cox.net>,
	Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 11:34:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVR7W-0008PX-6Q
	for gcvg-git@gmane.org; Tue, 10 May 2005 11:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVEJJkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 05:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEJJkm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 05:40:42 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:38572 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261584AbVEJJkc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 05:40:32 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DVRD2-0007lk-MV; Tue, 10 May 2005 11:39:33 +0200
Received: (nullmailer pid 6067 invoked by uid 501);
	Tue, 10 May 2005 09:39:24 -0000
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Disposition: inline
In-Reply-To: <20050510093212.GD8176@lug-owl.de>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Jan-Benedict Glaw:
> Ever thought about keeping some important files (of your $HOME) in some
> SCM? For sure, some of those are dot files:-)
>=20
Yeah, but so are various local temporary files.

Please don't change that without talking to Linus.


FWIW, I keep important files backed up (backuppc is your friend).
No need to bother with an SCM for that.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgIFM8+hUANcKr/kRAt2cAJ9LOv9sg0g5ZIhmzdAPHhtIXukYBwCeMi75
CaVyTedlL8Tl7bGbKbLorW4=
=Uf2z
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
