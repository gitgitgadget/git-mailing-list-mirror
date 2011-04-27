From: Joey Hess <joey@kitenet.net>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 15:42:33 -0400
Message-ID: <20110427194233.GA16717@gnu.kitenet.net>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se>
 <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
 <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
 <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 21:42:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFAdM-0000FX-GM
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 21:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758207Ab1D0Tml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 15:42:41 -0400
Received: from wren.kitenet.net ([80.68.85.49]:42772 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758117Ab1D0Tmj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 15:42:39 -0400
Received: from gnu.kitenet.net (dialup-4.154.35.100.Dial1.Atlanta1.Level3.net [4.154.35.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id F40F3118101
	for <git@vger.kernel.org>; Wed, 27 Apr 2011 15:42:37 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 4F9D646F72; Wed, 27 Apr 2011 15:42:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172265>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drew Northup wrote:
> I was just thinking of that, and for hoots and hollers I
> copied /usr/share/man/man1/git-am.1.gz
> to /usr/share/man/man1/git-amp.1.gz and tried "git help amp" on it.
>=20
> 	[dnorthup@drew-northup ~]$ git help amp
> 	No manual entry for gitamp
>=20
> So, that doesn't work. I haven't checked yet how Git "knows" what valid
> pages are available for "git help" but just putting another file in the
> same directory as the others didn't do the job (at least not on my
> workstation).

If git-amp is available in $PATH, 'git help amp' runs 'man git-amp'.
Otherwise, it runs 'man gitamp'.

Tools like autoconf etc already know how to install man pages into the
right places. I don't see the need for any additional support for git
here.

--=20
see shy jo

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIUAwUBTbhxqMkQ2SIlEuPHAQi+cw/2Igl2naUoSi6YBS2h/WhNkPJabVoMgzq7
gW0TK+X5N4U6WOJa2ELtTwg4olIdhQTRzDcWpct3agxhq24L7lX6/x+eg0m1v0zy
dyAK7Um+Y5L6KBF3IZ8q2TPBBjumCbcNqjZQcFlDWrI6+6F4FKHRN1JMIq3ol8ZU
7x45TtYKD8LPuzxmT9V2cLpoMRJPQxAZNWM+2sTCuLTYtI8KKXgBTm+k2r3nbhKF
YyCE/Pw6JGYLA9qAvdrY/ExR20Cwozt8nZmVei7g1bg6mDli7W4Gxs6Bpv6wp7A4
FPB/BY01plkHVKYmXupnkNgVraiejwGQ+BK+mc7rfvf72uGvdHxFOvc7AqJigxj8
xQjE2jU5HTABK2YaqtmWjOaKzTCb/bsxM3jQN35R2Krd7D8l37P9pYdl5nIXxQzP
5xLXZXwp9e4hN+VMTY536kWFiV27TDWgANXcQXiWKAWehBgkfNQdtwJazUQV3VLt
dxz/6IxT5fMWP5cfOAzgSyoJodFXMgARZQOPm3e1yQjwnnqiI+3Vd1HRA2BNYthj
B7QOF4ue9V5QyhuvPZYJRIC4ox1Nq2cNnrWIu8xBQvfufrN8gdmEpdfp8ZCVGbgl
7rHdCaJ/HXxZsehCl5pGPMLhf14vVS+BYpLtuHNlXF9My4wWoK+KmOyfc0L6chmL
pqtnB6hLfg==
=oITQ
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
