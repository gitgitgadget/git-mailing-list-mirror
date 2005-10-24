From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: git-snapshot.sh
Date: Mon, 24 Oct 2005 09:10:15 +0200
Message-ID: <20051024071015.GA4608@schottelius.org>
References: <20051017220615.GG12774@schottelius.org> <20051020090102.GX30889@pasky.or.cz> <20051017220615.GG12774@schottelius.org> <Pine.LNX.4.63.0510180021120.15669@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 09:15:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETwVp-0002dL-I3
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 09:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVJXHLU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 03:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbVJXHLU
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 03:11:20 -0400
Received: from wg.technophil.ch ([213.189.149.230]:36276 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751053AbVJXHLT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 03:11:19 -0400
Received: (qmail 4648 invoked by uid 1000); 24 Oct 2005 07:10:15 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051020090102.GX30889@pasky.or.cz> <Pine.LNX.4.63.0510180021120.15669@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10532>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hmpf, didn't know of those two alternatives, thanks!

Nico

Johannes Schindelin [Tue, Oct 18, 2005 at 12:21:50AM +0200]:
> Hi,
>=20
> On Tue, 18 Oct 2005, Nico -telmich- Schottelius wrote:
>=20
> > I really like to have a snapshot available from my sources in VCS.
> >=20
> > Therefore I wrote the attached script.
> >
> > git-tar-tree $(git-log | head -n1 | awk '{ print $2 }')=20
>=20
> And why not "git-tar-tree HEAD"?
>=20
> Ciao,
> Dscho
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Petr Baudis [Thu, Oct 20, 2005 at 11:01:02AM +0200]:
>   Hello,
>=20
> Dear diary, on Tue, Oct 18, 2005 at 12:06:15AM CEST, I got a letter
> where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> told me=
 that...
> > I really like to have a snapshot available from my sources in VCS.
> >=20
> > Therefore I wrote the attached script.
> >=20
> > Just wanted to send it, perhaps someone can use it.
>=20
>   and the others can use
>=20
> 	cg-export snapshot.tar.bz2
>=20
> ;-)
>=20
> --=20
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> VI has two modes: the one in which it beeps and the one in which
> it doesn't.


--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1yI1rOTBMvCUbrlAQJ4LA//em0PZe2OMOxN6DJ94RjcjvNfO9ab7W8B
7ipxTFKdzdXqtaOTOvKwOVKtyfq2naxcM+5VqTupsoKUtFkJjL8UVdrQdQA25dT/
gRYsjIyYH/ma4uG01EqWseYDRNlFDQzwMOwlxCivl0cNz1EcDKyroASZdvmYsgcc
WZlU58EPVEZ7GgmJMniUhQElKtimpL4cwpfJ6p9QC49Z+/IbXo2L6YwlC4kx6EPs
YwW//l069YMactAr0g4dpObDpJfblFlUvrEr3Xfx5cwwJXl0w4CLWLWtIWblJpar
r8BDLOtZOItBByhcCiTiF3KeFOGHb0prO3Mb1CNXm17TL71dfFXqvb0XMoCN599/
Tdkn/KeRNbySYMB3teC4afHVSzjr2zSA7Jgli9OznCumrlHY6GeXILzOi1QFs0R9
+aJtmglXE5tjWG4npvMciLymH5rCxqZHpvzwOP5U2jZgCXehMzl8u2Z/A/aHc41S
itpzPzt5kiY6H/6IOymKqjnl+6UzONsttcb0p2OxduvC2L7cD4V8zvcILtn46Ei9
7RYMeGLVw/uBirNatqR0wUgnAIRKFgjLwAYe6bUohR30qPHHngYH6yRplobLf28t
gyZ+qGjarmB+j9RpUkJoCjdkTm1eCA/v1hN6RTHwgs1B3WOm88ejdBzF2aXPwWfB
HJQH3fXFiIE=
=aspp
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
