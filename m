From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH v2 1/4] Add log.mailmap as configurational option for
 mailmap location
Date: Mon, 02 Feb 2009 08:48:09 +0100
Message-ID: <4986A539.3080606@trolltech.com>
References: <cover.1233520945.git.marius@trolltech.com> <ce94ea88e3182e97997c23f71e184e0db64fa708.1233520945.git.marius@trolltech.com> <7vwsc9o82r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig068815A406A4AA67737B0BD2"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 08:49:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTtYs-0005HF-RK
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 08:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbZBBHsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 02:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbZBBHsP
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 02:48:15 -0500
Received: from hoat.troll.no ([62.70.27.150]:47944 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbZBBHsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 02:48:14 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id B8C7A20A87;
	Mon,  2 Feb 2009 08:48:08 +0100 (CET)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 7975F20752;
	Mon,  2 Feb 2009 08:48:08 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <7vwsc9o82r.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108061>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig068815A406A4AA67737B0BD2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 02.02.2009 04:01:
> Marius Storm-Olsen <marius@trolltech.com> writes:
>> This allows us to override a repo mailmap file, or to use
>> mailmap files elsewhere than the repository root.
>=20
> I think the new feature is not so well conceived.
>=20
> Should it always be a wholesale override, or should it also support
> augmenting the repository version with a private copy?

Sure, I can rewrite it to be augmenting, rather than overriding.
I assume that the normal .mailmap file should be parsed first, then=20
the log.mailmap one?


>> diff --git a/builtin-blame.c b/builtin-blame.c
>> index aae14ef..4b63775 100644
>> --- a/builtin-blame.c
>> +++ b/builtin-blame.c
>> @@ -2394,7 +2394,7 @@ parse_done:
>>  		die("reading graft file %s failed: %s",
>>  		    revs_file, strerror(errno));
>> =20
>> -	read_mailmap(&mailmap, ".mailmap", NULL);
>> +	read_mailmap(&mailmap, NULL, NULL);
>=20
> Your callers always seem to pass NULL for the second argument.  Doesn't=
 it
> make a lot more sense to get rid of it?

Sure, but I left it in to allow "old-style" usage. Just in case the=20
were use-cases for not using the log.mailmap one. I can nuke the=20
arguments if you don't want them anymore.

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig068815A406A4AA67737B0BD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJhqU5KzzXl/njVP8RAuQIAJ0Q//kkDCFmBYumwa9cmpZRO8l/cwCg8Azq
fgAFRP9+aZvth18wUWKBkOI=
=6Bgl
-----END PGP SIGNATURE-----

--------------enig068815A406A4AA67737B0BD2--
