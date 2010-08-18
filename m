From: Joey Hess <joey@kitenet.net>
Subject: Re: fully deepening a shallow clone
Date: Wed, 18 Aug 2010 11:48:38 -0400
Message-ID: <20100818154838.GA4324@gnu.kitenet.net>
References: <20100817004905.GA8305@gnu.kitenet.net>
 <AANLkTi=qEwcE6qSmAoNnqE-2Z41rjqPBSfgbaesQBPrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 17:48:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olksm-0004EB-Ao
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 17:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab0HRPsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 11:48:43 -0400
Received: from wren.kitenet.net ([80.68.85.49]:43133 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715Ab0HRPsl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 11:48:41 -0400
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 2F66F11936E;
	Wed, 18 Aug 2010 11:48:40 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id EA4254C072; Wed, 18 Aug 2010 11:48:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=qEwcE6qSmAoNnqE-2Z41rjqPBSfgbaesQBPrA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153861>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nguyen Thai Ngoc Duy wrote:
> On Tue, Aug 17, 2010 at 10:49 AM, Joey Hess <joey@kitenet.net> wrote:
> > git-pull(1):
> > =A0 =A0 =A0 --depth=3D<depth>
> > =A0 =A0 =A0 =A0 =A0 Deepen the history of a shallow repository created =
by git clone
> > =A0 =A0 =A0 =A0 =A0 with --depth=3D<depth> option (see git-clone(1)) by=
 the specified
> > =A0 =A0 =A0 =A0 =A0 number of commits.
> >
> > Well, what if I want to deepen an existing shallow clone to include
> > the full history? In practice, something like --depth=3D100000000 is go=
ing
> > to work, but in theory, that will eventually fail some day when there a=
re
> > enough commits. :)
>=20
> I have always thought --depth=3D0 will make full repo again. Have you tri=
ed that?

I'd be happy if it did, but it pulls 0 revs actually.

--=20
see shy jo

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTGwA08kQ2SIlEuPHAQiCOA/5AQdHiJEHPHIJyPJeYFYWivKobnyZeque
lPQI43tVp9hczqgaN0XlbImJ3M/I/TenmY5hilJ+TvdZ2zXp+rMX2AMlqvTTEJcf
PKgHStkbkndfQLWcY3IsiVYXCkZ7vDEd+JaWDSb3Do0W5TZYHVqffwdrltCNRp4C
wGDLzC1xVfEFHcgZtiMgyvEMzQW7TaEiektTZRo2ZERhFpD8nhJU1GFIP5rp4onF
hkx8Z6Zk9NZ5soBSzwqkRk5U1mJ1QxLzdwMV7meDdiVW11vyHc/BC4YC+WJUH2nr
V1RWueygkGzuwotu6gJJpDENiFj1cuteFTgt+TXmdzAW++ukdqd+jxMBcUTPhiFC
3y6Ioh4JJ/hUbhtyZcwPaVIjEcJKwMETU+IZXp0YsfmiWdA+jglimRPzZklG15Sa
FWr8qDCDsH/oUwz+LvAc0dH/SMMa8CjkOYnk3HB8NnmiscUi/+Q9R1NgG6JNTZ12
3EUQSj0BCc8goHWBvgu2qxmmPfjf2JoXrkW/1WKxoESbeodhFUEb5GoiXxAdscrI
onJLDw2btft0EyhBYHHZ5x+NPzJ/6RYJF3AbM5/w1u7YLXEu0hRVdyxzhLAmw4kM
Qfg91/rs4UIAs3fwm5CCPRK1QViO1wKvIsFwnOkdXKO6AhK6ThTNdbIiR15xbL9a
3/vPFOeU/9s=
=Uoxn
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
