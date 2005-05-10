From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 11:32:12 +0200
Message-ID: <20050510093212.GD8176@lug-owl.de>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <7vis1rpi8a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Cc: Brian Gerst <bgerst@didntduck.org>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 11:25:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVQz2-0007DW-7A
	for gcvg-git@gmane.org; Tue, 10 May 2005 11:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVEJJcR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 05:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEJJcR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 05:32:17 -0400
Received: from lug-owl.de ([195.71.106.12]:29420 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261597AbVEJJcN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 05:32:13 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 5BC541901CC; Tue, 10 May 2005 11:32:12 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vis1rpi8a.fsf@assigned-by-dhcp.cox.net>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-10 02:01:41 -0700, Junio C Hamano <junkio@cox.net> wrote:
> >>>>> "JBG" =3D=3D Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:
>=20
> >> find * \( -type f -o tyle l \) -print0 | ...
>=20
> JBG> Btw, this won't find dot files, so using "." as the path list (inste=
ad
> JBG> of "*") might be wise...
>=20
> Huh?  Since when GIT started managing paths whose _any_ of their
> path component starts with a dot?

The Catholic Church never ever had female priests, so how could this
be a good thing?

Ever thought about keeping some important files (of your $HOME) in some
SCM? For sure, some of those are dot files:-)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgH+cHb1edYOZ4bsRAhelAJ9GDMgxYvxMa3qsa6Phsl9fVy/KgQCfYdRf
TyV4kIeRRC7LWBmgHvacTwM=
=JMOw
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
