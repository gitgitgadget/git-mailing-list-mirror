From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
 commits older than a year
Date: Tue, 24 Feb 2009 07:35:05 +0100
Message-ID: <49A39519.3030308@trolltech.com>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com> <20090222230620.GB19011@coredump.intra.peff.net> <7v7i3ix6yi.fsf@gitster.siamese.dyndns.org> <20090223031631.GC22348@coredump.intra.peff.net> <49A2599E.2030406@trolltech.com> <20090224050400.GC4615@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEF37A57ACDCF861D54260075"
Cc: Junio C Hamano <gitster@pobox.com>, eletuchy@gmail.com,
	git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 07:36:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbquJ-00066m-3i
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 07:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbZBXGfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 01:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbZBXGfP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 01:35:15 -0500
Received: from hoat.troll.no ([62.70.27.150]:48053 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779AbZBXGfO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 01:35:14 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id AE60321016;
	Tue, 24 Feb 2009 07:35:05 +0100 (CET)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 99AE621015;
	Tue, 24 Feb 2009 07:35:05 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <20090224050400.GC4615@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111221>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEF37A57ACDCF861D54260075
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Jeff King said the following on 24.02.2009 06:04:
> On Mon, Feb 23, 2009 at 09:09:02AM +0100, Marius Storm-Olsen wrote:
>>> Another option would to give higher resolution in number of
>>> years, like "3.5 years" or even "3.1 years".
>> And using shorter names for the units would be a no-go?
>>=20
>> "3y 2m ago"    <--
>=20
> Personally I think that looks terrible. But I recognize that it is=20
> very subjective. The only objective thing I can say is that "m" is
> not a unique prefix of a time unit, due to "minutes". Yes, it is
> obvious if you see the "y" first, but I actually parse the relative
> time backwards in my head and think "2 minutes ago, oh wait, 3
> years, that must be months".

Ok, the standard abbreviation for month is "mo.", so

   "3y 2mo. ago"

then? ;-)

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enigEF37A57ACDCF861D54260075
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJo5UZKzzXl/njVP8RAsvJAKDWnn4O3h24foEi9uyLWCgde/2QKwCgmsI9
Tjz2Q7sGYdMIg4PQ3GR+i8M=
=qbBW
-----END PGP SIGNATURE-----

--------------enigEF37A57ACDCF861D54260075--
