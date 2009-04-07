From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Tue, 07 Apr 2009 07:52:09 +0200
Message-ID: <49DAEA09.4000707@trolltech.com>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0EC2BCBF517377622FCAE114"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 07 07:53:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr4Fr-0003rG-2g
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 07:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbZDGFwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 01:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbZDGFwR
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 01:52:17 -0400
Received: from hoat.troll.no ([62.70.27.150]:33505 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbZDGFwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 01:52:16 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 4D59221040;
	Tue,  7 Apr 2009 07:52:09 +0200 (CEST)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 3BA2D2103C;
	Tue,  7 Apr 2009 07:52:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.21) Gecko/20090302 Lightning/0.9 Thunderbird/2.0.0.21 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de>
X-Enigmail-Version: 0.95.7
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115907>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0EC2BCBF517377622FCAE114
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin said the following on 31.03.2009 02:18:
> Commit 0925ce4(Add map_user() and clear_mailmap() to mailmap) broke the=

> lower-casing of email addresses.  This mostly did not matter if your
> .mailmap has only lower-case email addresses;  However, we did not
> require .mailmap to contain lowercase-only email addresses.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ouch! Sorry for missing that part! IMO, it would be correct to simply=20
restore previous behavior to lowercase the whole email, so:

Ack-by: Marius Storm-Olsen <marius@trolltech.com>

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig0EC2BCBF517377622FCAE114
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJ2uoJKzzXl/njVP8RAmWOAKDp3sBjYxjdGM4d+fTZlpYpUrIQRACgt7Zi
Z5qErAKbV967Hm7ZBwCbc3M=
=l3WA
-----END PGP SIGNATURE-----

--------------enig0EC2BCBF517377622FCAE114--
