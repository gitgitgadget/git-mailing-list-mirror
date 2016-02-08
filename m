From: Petr Stodulka <pstodulk@redhat.com>
Subject: Re: COPYING tabs vs whitespaces
Date: Mon, 8 Feb 2016 10:24:30 +0100
Message-ID: <56B85ECE.4020607@redhat.com>
References: <56B32BDA.4010909@redhat.com>
 <xmqqsi18i8xv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IttCg6xR051xv8ThwgAsR7GNVaccKt5Is"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 10:24:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSi3r-0004j1-3H
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 10:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbcBHJYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 04:24:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55177 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbcBHJYk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 04:24:40 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 90DFE8F4E1;
	Mon,  8 Feb 2016 09:24:40 +0000 (UTC)
Received: from [10.34.4.171] (unused-4-171.brq.redhat.com [10.34.4.171])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u189OcFl032592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Feb 2016 04:24:39 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqsi18i8xv.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285754>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IttCg6xR051xv8ThwgAsR7GNVaccKt5Is
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 4.2.2016 20:15, Junio C Hamano wrote:
> Petr Stodulka <pstodulk@redhat.com> writes:
>=20
>> I found that license file COPYING is different as compared with
>> http://www.gnu.org/licenses/gpl-2.0.txt If I pass over with
>> Linus's preamble, change is only about whitespaces - tabs
>> vs. space.  Probably it's minor non-essential change, but some
>> projects do this change, so rather I ask about that.
>=20
> Interesting.  I cannot quite connect "some projects do this change"
> and "so rather I ask".  Are you asking why this project changed it?

Nope. I apologize for my czenglish. It means: From my colleagues I hear,
that some projects had same differences (tabs vs. spaces) in their copy
of the license file and they make it later equivalent with the one in
gnu.org. So I ask rather here / point out this difference, if you know
about that or you want to have same one.

Yes, I know, it's just about whitespaces.

Petr.

>=20
> After running "diff" between the two, I think the changes are only
> on the indented section title lines, and "git blame" tells us that
> the section title lines in the copy we have has always been that way
> since Linus added to it at 075b845a (Add a COPYING notice, making it
> explicit that the license is GPLv2., 2005-04-11).
>=20
> So, perhaps the copy Linus got originally had leading runs of spaces
> that are multiples-of-8-long unexpanded to leading tabs back then,
> or perhaps he did that unexpanding himself.
>=20
>=20


--IttCg6xR051xv8ThwgAsR7GNVaccKt5Is
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWuF7OAAoJEPiGu5hNgNqPvP4P/AmLw+iW35wiUTQN4NIetxqt
HUy1tZmpvA1hnZ6WnpceKJOdpQlohcvxa4DVYUrj5+31ytNuzpMeZfg1ofuQ37mR
++tIxU/m5vLqgaMYZOnUCcgbKt35inGfX0+6TTVhDshivbEO4cbk79TTkkk6R/Ml
QJOMW1zWo+Sab8i6KEPI4zajNH4n1pUiQJO4XLhGxvmYOePGyg7gfPDHF7iQfUZl
lauwdNYmSN+jsqw8D7aHP5+lhpbiN+e4t7Oqi+KKFygGP/rCWNLl2rhK7ZBdLdBH
g2qGkZWRZOwU6ymTB9OuwaTUpGUNPcon9Hzgf39mCi53xKLBQdJQTPPr7GiUmN+m
E1LVNMuLI0mPs6uT6fB9Bj5fRaxi9QBIvkDlhvCd/a/VV2A09oHO4BW4zkmoPQtu
1o9rq8R9UXFktNiauFmWY3tVlqBJucYJWd3imfod1wJM4BsxF73Br9tE1dA4rS1w
xLmcKfAYnHBkfIgr2U4Y5GH0a1TFmO+MYsJcRpfvLbvna4USI1ZtqzO/sglP7zNn
757am060NurZ3AwB2fFI2pMaBTlupG7ib8QE1K7Bl5q2SwI1JS5emGxpaaks258f
i+Jr898p8CDq6R+qU5pg/B53Vpwm7bfEBNh/Yizosmb6NI6PHatQ4F7IgxFGyrIm
UMW3Zr4NWsQb458Zo2XM
=ub0E
-----END PGP SIGNATURE-----

--IttCg6xR051xv8ThwgAsR7GNVaccKt5Is--
