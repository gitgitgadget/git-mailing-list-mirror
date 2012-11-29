From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] git-submodule update: Add --commit option
Date: Thu, 29 Nov 2012 11:27:51 -0500
Message-ID: <20121129162751.GB27409@odin.tremily.us>
References: <20121127185142.GB4185@book.hvoigt.net>
 <cover.1354130656.git.wking@tremily.us>
 <20121129161216.GB23580@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=CdrF4e02JqNVZeln
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 17:28:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te6yL-0002ng-Ty
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 17:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab2K2Q2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 11:28:05 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:36413 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab2K2Q2E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 11:28:04 -0500
Received: from odin.tremily.us ([unknown] [72.68.105.242])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME9006PHCEF2U80@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 29 Nov 2012 10:27:52 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 92E786E23E6; Thu,
 29 Nov 2012 11:27:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354206471; bh=VOeJWOhHxW7J1lbiq8BlKzLZ+2Q7zVN0DsgH5G0CHN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nvNk8v4Lu1QCJJ8bmvr15/v1vrpTwHL0xC2Bhref73pv8ZJCppULt0Q8ab4uNKxOy
 qvggTxaBSILPKf/w1CJ3dVSrQY6wgsRQdvGfB0jkznfbwKYjpdiceuMwNoCH0SwiA5
 K7YxP3etjmXRnTqci3wJq1TcPCjaLwSSNzdmBkTs=
Content-disposition: inline
In-reply-to: <20121129161216.GB23580@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210843>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2012 at 11:12:16AM -0500, W. Trevor King wrote:
> +	 test "$(git log -1 --oneline)" =3D "bbdbe2d Updated submodules: submod=
ule"

s/bbdbe2d/cd69713/

I forgot to update the SHA-1 here after tweaking the commit message
format.  I'd like to rewrite this test so it won't use the SHA-1, but
this was the quickest way to check that the commit message and gitlink
were both changed appropriately.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQt40GAAoJEEUbTsx0l5OMZUsQALVXT5WZYpv4PqHlRNabeWxu
mlEezuLq0wljDXXvS58OXay27oURwniYP7L1HfAQ0Tb7YR+T/9Sw0QEvUI5yzLBE
Oz4HXAiCdhKUVcIDd11O5NDVJqHjCNgNWETibOrA20Jzvvs5YrRPQFzkzBoBJg70
dZ+N1UqpBB5FtwNvG/IgsDHd4pMxTer9SY6TOdtT4bT2sz2BC/H/0neWbt2+L8B6
LajEF91LHTK4aYpySHb9s+mmxlTQlBTuG6yTWE2oWPl40fA505lNkJvxOA3jpQEU
dHE8KGNrP8i4JlBz0Tj+mlhMe4xVRjR6M5gnpkH+iiQG1z4kqiQARe4uRPV+3rxx
4TKcijAYVqz8lPm0Eer7ObpHP2+asOgupGJm/HlSmWlNIsVLl/ilZr8LH4TqrfCW
sCxkLT/VC2IKBAuOKXhs0TgENLnB9h3FtvNsCN6EZ+jeBk51EvAaF40ijJIztgfW
38QDFxP6YxjJT8scQNnZJilj+2Ljdo0Fix5NvDqho4yAlSRpZ6BroBPEwgw3UF45
iLSUI4AvuTha+PYucsyUeJCivu7wAksJI3C9Rqe9E12/9YbcIvcgH2oclDhBxUNv
c7PPbfpXY4HvxhURW4bgZ9K7khTYntD5n0NgGSiOyEPu9ephQQz122fY8FSWHfS3
rXv/Asqy36lf3CdXmSYz
=L9pM
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
