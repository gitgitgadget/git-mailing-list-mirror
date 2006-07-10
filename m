From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Mon, 10 Jul 2006 09:35:32 +0200
Message-ID: <20060710073532.GA22573@lug-owl.de>
References: <20060708183402.GA17644@spearce.org> <7vy7v4orpt.fsf@assigned-by-dhcp.cox.net> <20060708190327.GA17763@spearce.org> <20060709073155.GP22573@lug-owl.de> <20060710052255.GA15173@spearce.org> <1152512523.3504.28.camel@dv> <20060710062513.GZ22573@lug-owl.de> <1152514328.3504.58.camel@dv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iDgFKLa5Kp4Ejml3"
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 09:35:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzqIs-000253-H0
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 09:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161368AbWGJHff (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 03:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161369AbWGJHff
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 03:35:35 -0400
Received: from lug-owl.de ([195.71.106.12]:42378 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1161368AbWGJHfe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 03:35:34 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id EBCC0F0397; Mon, 10 Jul 2006 09:35:32 +0200 (CEST)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1152514328.3504.58.camel@dv>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23599>


--iDgFKLa5Kp4Ejml3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-10 02:52:08 -0400, Pavel Roskin <proski@gnu.org> wrote:
> On Mon, 2006-07-10 at 08:25 +0200, Jan-Benedict Glaw wrote:
> > On Mon, 2006-07-10 02:22:03 -0400, Pavel Roskin <proski@gnu.org> wrote:
> > > This means that the Sun compiler has almost all c99 features used by =
git
> > > with just a little exception (initializers).  I think it's fair that =
we
> > > fix this incompatibility.  It's very very minor compared to what "gcc
> > > -std=3Dc89 -pedantic" would have required.
> >   ^^^^^^^^
> > You're kidding, aren't you?
[...]
> We can satisfy the Sun's compiler and yet retain flexible arrays and
> other c99 goodies.
>=20
> Maybe I'm missing your point (or you joke).

Why should we jump through the hoops to support an obsolete standard
because proprietary compilers don't stand today's standards?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--iDgFKLa5Kp4Ejml3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEsgNEHb1edYOZ4bsRAr3bAJ95z8rSBwOsSkRRJjvedJ9PE2PDqQCffLte
6bUaIvCTMdrNdWQuG+10HxA=
=dcpa
-----END PGP SIGNATURE-----

--iDgFKLa5Kp4Ejml3--
