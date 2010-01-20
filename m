From: Joey Hess <joey@kitenet.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 15:36:36 -0500
Message-ID: <20100120203636.GA9221@gnu.kitenet.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 21:37:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhIa-0002jk-5A
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab0ATUgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998Ab0ATUgl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:36:41 -0500
Received: from wren.kitenet.net ([80.68.85.49]:44695 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567Ab0ATUgk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 15:36:40 -0500
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id A7C251182A1
	for <git@vger.kernel.org>; Wed, 20 Jan 2010 15:36:38 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 65845A8365; Wed, 20 Jan 2010 15:36:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vska01qrt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137575>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Joey Hess <joey@kitenet.net> writes:
>=20
> > Do you think it makes sense for even git log --format=3Dformat:%s to be
> > porcelain and potentially change when new features are used?
>=20
> If the series changed the meaning of "%s" format to mean "the subject of
> the commit and notes information", with or without documenting it, then it
> is just a bug we would like to fix.
>=20
> But I cannot reproduce such a bug.  In my tree locally:

I was asking hypothetically, trying to point out that parts of git log
seem to make sense to be used as plumbing, with the hope I can continue
to use it that way.

(Note that git instaweb parses output of git log --pretty=3Dformat:%H --raw
like it's plumbing.)

--=20
see shy jo

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBS1dpVMkQ2SIlEuPHAQjGJg/8DRo3ZHd1yAWghYmvMCyVXADByFyEqjbX
XTlZ9YC77Dxrl+QU9B8a/nSCNw4iiW+vA/AFfOdkf6X+Pi+Xv/9n80LwhiOuiWEG
EO2W96dkSZdux7y0Dw6LRQGzqDJVXbjojYu2ABzQUPIF2c4CTKtxEpr7KJ0GgkIQ
Jk/4WS3cWb1ezKi/qWu9ArUZMXe4WWfRaxnnPeEdURtWwmBpbm6ZuQkvUUfnhsi7
D8PmbJOlNU49Ue2oeNTglsJliduru6nHVd9na5n+n0+8dLglrEJvG/DE2a+ROe7a
RejX3Lih8FdYDmH2diaBfG/tTy2SlGGzB1vkcZYOJqekwLgALF8f4U5MmwlUTupt
neNlMEqZmPvYmIPr6gGtLZAZQEHYJPE1UFi8o8qrk466dlVxMDbdYxE2zGNjSmMH
FztZhgkbx7mrSYGmm0c4tPEL8MkwMslu3Gldw4yUk5yVvSj6O47WnCazGUK2NP7F
iM9yYvRedubvvStLJLxWnRWyjlBYBuOtY5B4yD9QNwl1u8CfTcSsxaDBDfV7XzHK
X2j/lMvsbPpgxHHDCGhW+zF0HQUGEmREfILwkJi8Asxr8TxDxaWl5FoHRIF4WYrv
r3DTf/mOtxIAcY8Wny0d3m6MNOUpNvC7QIhRynkSZP08qwmqbdsqz6Vlqmrci43j
DLctT47o+n8=
=PSvi
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
