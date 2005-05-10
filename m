From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 11:45:38 +0200
Message-ID: <20050510094538.GE8176@lug-owl.de>
References: <20050509233904.GB878@osuosl.org> <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <7vis1rpi8a.fsf@assigned-by-dhcp.cox.net> <20050510093212.GD8176@lug-owl.de> <20050510093924.GH11221@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Cc: Junio C Hamano <junkio@cox.net>,
	Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 11:39:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVRCs-0000nP-5Z
	for gcvg-git@gmane.org; Tue, 10 May 2005 11:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVEJJqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 05:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEJJqI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 05:46:08 -0400
Received: from lug-owl.de ([195.71.106.12]:29165 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261587AbVEJJpn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 05:45:43 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id C7C531901C8; Tue, 10 May 2005 11:45:38 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050510093924.GH11221@kiste.smurf.noris.de>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-10 11:39:24 +0200, Matthias Urlichs <smurf@smurf.noris.de> =
wrote:
> Jan-Benedict Glaw:
> > Ever thought about keeping some important files (of your $HOME) in some
> > SCM? For sure, some of those are dot files:-)
>
> Yeah, but so are various local temporary files.
>=20
> Please don't change that without talking to Linus.

I won't.  You haven't seen a patch from me "fixing" this, too.  *I*
consider this as a defect, but that doesn't mean that I'll force others
to take this view, too.  But maybe I'll talk Linus into this when he's
back from his trip.

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

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgILCHb1edYOZ4bsRAmYnAJ9jqHDZNutohxB6sYdXGiexSpNA0QCdHNp7
csej0MR/PCsHKYAjly1I6hA=
=T6EV
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
