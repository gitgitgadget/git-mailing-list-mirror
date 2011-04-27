From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 12:21:33 +0200
Message-ID: <20110427102133.GA10057@bee.lab.cmartin.tk>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <7vwrig9ta7.fsf@alter.siamese.dyndns.org>
 <BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
 <7vsjt49stq.fsf@alter.siamese.dyndns.org>
 <BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
 <7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
 <BANLkTi=UafJRc76ePmVXo2gF+CNVnEL41Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 12:21:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF1sL-0000fM-J7
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 12:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757813Ab1D0KVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 06:21:36 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:56809 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756040Ab1D0KVf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 06:21:35 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id BBD2346138;
	Wed, 27 Apr 2011 12:21:16 +0200 (CEST)
Received: (nullmailer pid 10285 invoked by uid 1000);
	Wed, 27 Apr 2011 10:21:33 -0000
Content-Disposition: inline
In-Reply-To: <BANLkTi=UafJRc76ePmVXo2gF+CNVnEL41Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172213>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2011 at 05:15:50PM +1000, Jon Seymour wrote:
> On Wed, Apr 27, 2011 at 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Jon Seymour <jon.seymour@gmail.com> writes:
> >
> >> My thoughts about this are inspired by how the node project manages
> >> packages with its npm package manager and also the fact that I have
> >> several ideas on the boil at the moment that would definitely benefit
> >> from a standard way to manage these concerns.
> >
> > Sounds like you have a plan ;-)
> >
>=20
> Ok, here we go:
>=20
>     https://github.com/jonseymour/gpm
>=20
> Anyone who violently objects to the suggested name of a package
> manager interface - gpm, please speak up now because it'll be easier
> to change now.

I'm not objecting, but when I see gpm, I think of the mouse daemon for
Linux virtual consoles[0] and whose git clone address also ends in gpm.

I find a name like gem (git extension manager) nicer, though that's
taken by ruby.

[0] http://www.nico.schottelius.org/software/gpm/

   cmn

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNt+4tAAoJEHKRP1jG7ZzT72QH/0uWeCebvTF5scIjRPmhtKus
2O0F+fArP5oHWDnmeRp/5QKXh4CLBtfhvDpRm4dMNBrYSl0sDvP5IGV9jPplN66O
H0krfc0q1v4CS0vr0+To6yYrDvzAZPF8DdLP+D/x0+8iPfSGG5znAeMVlyKX1v3y
Ze18ZMouOZjJa72ma3Q+KyA3fLranONdP7+pujkz1AC8N/RrLnOnW24yXxQLV8wB
WDFq9cN9ix2uXbfUm1y/faxxB6AFKZRNlh2Dj0qLX6FxVLkHX2yE4EJprvaCk/l/
/vpT8ks8Q7q5CD4n5zT8OeyLaatUOb/wk+GL4YvVBP5VhRt74VCC5Mxl6vP736Q=
=ldf7
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
