From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 9/9] user-manual: Use -o latest.tar.gz to create a
 gzipped tarball
Date: Mon, 18 Feb 2013 07:16:22 -0500
Message-ID: <20130218121622.GD8388@odin.tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <27dea793fc101f8bd148385b753997867b987658.1361146398.git.wking@tremily.us>
 <7vbobicop9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=IMjqdzrDRly81ofr
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 13:16:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7PeM-0002yB-UE
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 13:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab3BRMQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 07:16:27 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:62678 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3BRMQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 07:16:26 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIF00BKE0RBOS20@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 18 Feb 2013 06:16:24 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id DFE3A885C60; Mon,
 18 Feb 2013 07:16:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361189782; bh=CB+kkPGIoA1M8tXx2N0gJJQ2W2n0WCmEMgdgDcnPeSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g845vzx0bPZNk34LGGaBtldwIsXWo27CU9sBtbK7Ra21nqPiKP09WnskfQAnVjJ7C
 xKoXFoxmHyAzH5Y3HxPJaxHzWoQzb+okQgBiURV0mMqTBgHwTmyjwmgC7VVg/+2zuU
 ylw7wAr0bkQBw2vRxLFUVipCo18dhegH19/lxb6k=
Content-disposition: inline
In-reply-to: <7vbobicop9.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216479>


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 17, 2013 at 06:58:58PM -0800, Junio C Hamano wrote:
> It is easy for me to deal with conflicts in this particular case,
> but in general it would have been more straightforward to manage if
> these more localized phrasing fixes came earlier and a larger
> file-wide cosmetic change was done after all the others have
> settled.

Ok.  I'll shift the backtick fix to the back of the stack for v4.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRIhuWAAoJEEUbTsx0l5OM8KsQALavo3JQjvHCOfM4Rmo+DGiu
86KgS6o/tS161y39dK9EXg/YC+x14Ti9DOD1kHDU+h1SVrIqrQaJARRcIBMaXhSR
bKGFZaeFWT8dSjR2DDD1i8XPkzgnNK1bR4iPogDEXkG6x9UFICDkq8j6p/NqSIRj
1p8j7qO7lb1zDwTz/MNPm12DxP4pO+qEoX3+8A+KiJAwuV267l7o+ONvSeLyXsQ5
ikEm1jWloI1hjjQcePbvMxpRDD23DjRzAjzZPeuZRuU06+FClTPIM2fT2dLKgBLa
FDXP51MdNbquKQ3guag18imHidX/ljXuyM8O8QAO6jG+JnYoUIPkntaFBeX2q6de
CeV18WbUlYpJxTRZNobwODXREH8KOB98ej7HqERXig4FDIXOG1EWqGCi1BOqracS
tzusNt1Z8sgaoecB66vQtFk1PC5Gi8SukpeOLhOZUW3GM4xtiLtmQszy/StrkJ+g
uXG7MraA0a4HWTgxsNtHAmNB71GLQ4BGuHMG0r0PO2N4ey7btkjQapndZl3tejsl
lYxz8+1BFf+gGk8UcDCx5VM/3tAJJibFUCtY/30jqXuHCGB8CiR3D8NbNzLTKeAl
ZV5u+cW9j8yRjvNmgbONdnYHfz05FS/vzA9DVM8re3eIjkK69oQz4Hfu7iFTjpYn
Gwyc7U8opO3i2pgL8lo2
=kfwW
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
