From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Wed, 25 Jul 2007 09:43:31 +0200
Message-ID: <46A6FF23.8050704@trolltech.com>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net> <200707241134.31950.robin.rosenberg.lists@dewire.com> <alpine.LFD.0.999.0707241144490.3607@woody.linux-foundation.org> <200707250835.21181.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig96BA320FDDB8095CBD01B216"
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, raa.lkml@gmail.com
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 09:43:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDbWP-0004TT-0h
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 09:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758347AbXGYHm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 03:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbXGYHm4
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 03:42:56 -0400
Received: from esparsett.troll.no ([62.70.27.18]:34166 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbXGYHmz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 03:42:55 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 4EDEE741BD; Wed, 25 Jul 2007 09:42:54 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 3D5CC741AE; Wed, 25 Jul 2007 09:42:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.5) Gecko/20070716 Thunderbird/2.0.0.5 Mnenhy/0.7.5.666
In-Reply-To: <200707250835.21181.andyparkins@gmail.com>
X-Enigmail-Version: 0.95.2
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
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53674>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96BA320FDDB8095CBD01B216
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Andy Parkins said the following on 25.07.2007 09:35:
> On Tuesday 2007 July 24, Linus Torvalds wrote:
>=20
>> So if you sleep for one second, the filesystem times will update by on=
e
>> second, but if you try to *synchronize* to exactly one second, it's no=
t at
>> all certain that the *filesystem* clock will be synchronized to the sa=
me
>> second! Time skew is simply a fact of life.
>=20
> I think it's even worse; if memory serves one of the Windows file syste=
ms=20
> (spit) only stores times to a two-second resolution.  So half the time,=
=20
> waiting for one second won't change the time stamp _at all_.

"File time stamps on FAT drives are rounded to the nearest two seconds=20
(even number) when the file is written to the drive. The file time=20
stamps on NTFS drives are rounded to the nearest 100 nanoseconds when=20
the file is written to the drive."

http://support.microsoft.com/kb/127830

--=20
=2Emarius


--------------enig96BA320FDDB8095CBD01B216
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGpv8jKzzXl/njVP8RAuRzAJoCD60YKNwDK+Qf+rBwNvtrH7Ly/QCgicef
USQWREz8u/N63KNwgYFFzyM=
=MsvH
-----END PGP SIGNATURE-----

--------------enig96BA320FDDB8095CBD01B216--
