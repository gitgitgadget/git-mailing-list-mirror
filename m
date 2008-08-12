From: martin f krafft <madduck-JX/+c5DPh7vR7s880joybQ@public.gmane.org>
Subject: Re: TopGit: problem with patch series generation
Date: Tue, 12 Aug 2008 20:10:37 -0300
Message-ID: <20080812231037.GC16481@lapse.rw.madduck.net>
References: <20080812161854.GB30067@lapse.rw.madduck.net>
	<8aa486160808121428t259f5340x6d1a14cadedac30c@mail.gmail.com>
	<20080812224155.GB15521@lapse.rw.madduck.net>
	<20080812225916.GN10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8551296679943732027=="
To: Petr Baudis <pasky-AlSwsSmVLrQ@public.gmane.org>,
	Santi =?iso-8859-1?Q?B=E9jar?= <sbejar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	git discussion list <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Manoj Srivastava <srivasta-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>,
	vcs distro packagin
X-From: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org Wed Aug 13 01:11:32 2008
Return-path: <vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>
Envelope-to: gcvp-vcs-pkg@m.gmane.org
Received: from alioth.debian.org ([217.196.43.134])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT31W-0000ge-SV
	for gcvp-vcs-pkg@m.gmane.org; Wed, 13 Aug 2008 01:11:30 +0200
Received: from localhost
	([127.0.0.1] helo=alioth.debian.org ident=list)
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>)
	id 1KT30a-0001AL-Up
	for gcvp-vcs-pkg@m.gmane.org; Tue, 12 Aug 2008 23:10:32 +0000
Received: from clegg.madduck.net ([193.242.105.96])
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <madduck-0owbi4v4jRjYceiJAzDLgeTW4wlIGRCZ@public.gmane.org>) id 1KT30E-0000pZ-S4
	for vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org;
	Tue, 12 Aug 2008 23:10:16 +0000
Received: from lapse.rw.madduck.net (unknown [209.13.181.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net",
	Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 9F2181D40AE;
	Wed, 13 Aug 2008 01:09:54 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 368C880BA; Tue, 12 Aug 2008 20:10:37 -0300 (ART)
In-Reply-To: <20080812225916.GN10151-DDGJ70k9y3lX+M3pkMnKjw@public.gmane.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel
	2.6.24-etchnhalf.1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus-JX/+c5DPh7vR7s880joybQ@public.gmane.org
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93.1/8021/Tue Aug 12 21:27:39 2008 on
	clegg.madduck.net
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on alioth.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham
	version=3.2.3
X-BeenThere: vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Discussions on using VCS for distro packaging
	<vcs-pkg-discuss.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/vcs-pkg-discuss>
List-Post: <mailto:vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org>
List-Help: <mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org?subject=subscribe>
Mime-version: 1.0
Sender: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
Errors-To: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: vcs-pkg-discuss-bounces+gcvp-vcs-pkg=m.gmane.org-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92153>


--===============8551296679943732027==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Petr Baudis <pasky-AlSwsSmVLrQ@public.gmane.org> [2008.08.12.1959 -0300]:
> > I think this is definitely something TopGit can automate.
>=20
> This seems to be in principle the same as the tie branches. It might
> make sense to have a way to _optionally_ make a tie branch.

Yes, optional would make sense!

> How should that work? Maybe there needs to be even an explicit support
> for this - should TopGit just check the dependency tree when
> sequencing the topic branches and have a step that says:
>=20
> 	"I'm going to sequence branch A. If there is branch T that has
> 	only already sequenced branches + branch A as dependencies,
> 	use T's content instead of A."
>=20
> Would that be satisfactory?

Yes, that's what I was thinking about, if I read you correctly.

> Of course, in the case of
>=20
>         A1--A2--A3--A4--C
>                        /
>         B1--B2--B3--B4.
>=20
> the sequenced branches would still be like
>=20
>         A1--A2--A3--A4--B1--B2--B3--C
>=20
> unless you create the T1..T4 branches manually.

Yes. Or add a dependency. I'd just prefer not to add a dependency
where there is none; instead, I'd prefer if TopGit could be aided
with the serialisation in cases when it cannot possibly make
a proper decision.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"a mathematician is a device for turning coffee into theorems."
                                                         -- paul erd=F6s
=20
spamtraps: madduck.bogus-JX/+c5DPh7vR7s880joybQ@public.gmane.org

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiiGGwACgkQIgvIgzMMSnX2rwCfVmPt2VAH3V2gQr8qJHhvGZZa
Ij0An3VkWrbjHa2fPgRmhckMUE6yFqTB
=/lic
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--


--===============8551296679943732027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
vcs-pkg-discuss mailing list
vcs-pkg-discuss-XbBxUvOt3X2LieD7tvxI8l/i77bcL1HB@public.gmane.org
http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss

--===============8551296679943732027==--
