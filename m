From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [ANNOUNCE] git tracker online
Date: Thu, 12 May 2005 22:30:32 +0200
Message-ID: <20050512203032.GF8176@lug-owl.de>
References: <1115794878.22180.27.camel@tglx> <20050512190433.GB8176@lug-owl.de> <1115927905.11872.48.camel@tglx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+Xnt6BZa+I2KmHWw"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 22:23:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWKD2-0006UW-T7
	for gcvg-git@gmane.org; Thu, 12 May 2005 22:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVELUan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 16:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVELUan
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 16:30:43 -0400
Received: from lug-owl.de ([195.71.106.12]:27085 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262084AbVELUae (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 16:30:34 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id CD94E1902B0; Thu, 12 May 2005 22:30:32 +0200 (CEST)
To: Thomas Gleixner <tglx@linutronix.de>
Content-Disposition: inline
In-Reply-To: <1115927905.11872.48.camel@tglx>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--+Xnt6BZa+I2KmHWw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-05-12 21:58:25 +0200, Thomas Gleixner <tglx@linutronix.de> wro=
te:
> On Thu, 2005-05-12 at 21:04 +0200, Jan-Benedict Glaw wrote:
> > 	- When the {repository,diff against} drop-down box is changed,
> > 	  it would be nice to fire off a onchange=3D"submit()" so that (if
> > 	  your browser is wacked with JavaScript) you don't need to
> > 	  press the submit button.
> >=20
>=20
> I thought about that already. I'm currently cleaning up the code and fix
> the heuristic guessing a bit and then I will put the code online, so you
> can fix yourself if I have not managed to do it until then :)

Well, as easy as:

s#<select name=3D'project' size=3D'1'>#<select name=3D'project' onchange=3D=
"submit()" size=3D'1'>#

You'll manage to add that yourself, I fully trust you :-)

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

--+Xnt6BZa+I2KmHWw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCg7zoHb1edYOZ4bsRAsjxAJ0Qi0pOe6KrMW/BPkZrTpwYqvgIrwCffSMx
pOHb5pYJG99RaU4roQymhdw=
=J3DI
-----END PGP SIGNATURE-----

--+Xnt6BZa+I2KmHWw--
