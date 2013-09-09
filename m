From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 00:38:55 +0000
Message-ID: <20130909003855.GH5359@vauxhall.crustytoothpaste.net>
References: <20130904081047.GB2582@serenity.lan>
 <20130904092527.GB22348@sigill.intra.peff.net>
 <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
 <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908172605.GF5359@vauxhall.crustytoothpaste.net>
 <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
 <20130909000153.GG5359@vauxhall.crustytoothpaste.net>
 <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
 <CAMP44s3WPUW3z-1Jthfr7R-xw1ufiub4vA8j9jXuk-cpO1hwVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 02:39:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIpVR-000610-7T
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 02:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab3IIAjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 20:39:00 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60156 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750848Ab3IIAi7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 20:38:59 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 23C6B28074;
	Mon,  9 Sep 2013 00:38:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAMP44s3WPUW3z-1Jthfr7R-xw1ufiub4vA8j9jXuk-cpO1hwVQ@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234292>


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 08, 2013 at 07:36:21PM -0500, Felipe Contreras wrote:
> On Sun, Sep 8, 2013 at 7:29 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>=20
> > My patches pretty much do nothing else but introduce a warning.
> > Nothing is broken, nothing is changed in the test suite:
> >
> > http://article.gmane.org/gmane.comp.version-control.git/233669
> >
> > You are confusing my proposal with Junio's one.
>=20
> Actually my mistake. My patches don't even add a warning, so nothing
> is changed at all (unless you manually configure pull.mode =3D
> merge-ff-only).
>=20
> I only suggested to add the warning, but didn't actually implement it.
> I'll do that soon.

I still wouldn't be crazy about the change, but if there's a warning, I
could live with it.  I think that's probably the best course of action
if there's going to be a change here.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSLRifAAoJEL9TXYEfUvaLV1oQALkDxRAFBWXIaFNVIpHCtnOe
zrwR1DZWW2G5m2xsYnrr5hALKaFeBuZHL6JwguvmteT1A1AeihjTTTy5qzjBKoMh
CZscspRvmqyJ7w6Bk7bAbEam+Cmv6X7rCYt8wlxIXxg7Gyk9nHeBDvnmzBlrT8uV
5ztp17S/5xbrX3Oe6tTO2z2GNeAfhc6XF0HFvgKAR+Yeld+VkUTsGq/N3Oq1Vlex
2k0nd7l82ywZuz0q/nlbEGBy71I2WccOmnydERqJtd1g20mq8evA/6cC6+9YeLHq
sgev4LNK9qOfkmcYUI8cqTvEgqUZfLMGoITEH2gl54B/0NY1BBOrwQ0d8ORgRWaz
iTaGLj7Dtsmti/uVXBPiHd7QfDIvVVeFwC26pOa4fQsQJqj4J5J5OCfD0xpxW8eN
ZChn5HBMvy7bZjA6aYPOtozQ76H9vjdK5EPHENiCxvNh4bql8fI/W+2RxfUOAF4z
CosSQUf6YG3z3eMKqhTbajuHDZiITGgBSl4PrSRa7LDzoN6iXtiOs2KSF51iUpWj
DIboamifIdMRWA5dVOWtp664PBPanEz9ME4Sq0zdNlrmkm+yUVyJG5WiR0GIJOA3
ycvXnVApbplQQf8EyL6dnQOMq2TiMX7jjmC5S3ja5W1Ek+84K7FktUiCUFl4VcK8
9l8ZcltiL9sKqa9XVo6y
=bCxu
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--
