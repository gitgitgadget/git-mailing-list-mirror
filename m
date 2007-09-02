From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Sun, 02 Sep 2007 20:18:40 +0200
Message-ID: <46DAFE80.4040707@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <3f4fd2640709020832x656fa78djf29117690318ea48@mail.gmail.com> <46DAE025.900@trolltech.com> <3f4fd2640709020933sa2bdec0g532500ea49c179b5@mail.gmail.com> <F0525923-6D9B-46AA-9678-8B1263C45FF7@silverinsanity.com> <3f4fd2640709020953k2f5367a0o64870da9d8e04f68@mail.gmail.com> <46DAED4F.2080407@trolltech.com> <Pine.LNX.4.64.0709021843270.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD8381301688C4036D2794315"
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 20:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRu2Y-0000gC-Jm
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 20:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbXIBSSw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 14:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbXIBSSw
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 14:18:52 -0400
Received: from esparsett.troll.no ([62.70.27.18]:39020 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbXIBSSv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 14:18:51 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 9860874219; Sun,  2 Sep 2007 20:18:49 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	by esparsett.troll.no (Postfix) with ESMTP
	id 4EC7074207; Sun,  2 Sep 2007 20:18:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <Pine.LNX.4.64.0709021843270.28586@racer.site>
X-Enigmail-Version: 0.95.3
OpenPGP: id=34EB4437
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57374>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD8381301688C4036D2794315
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> On Sun, 2 Sep 2007, Marius Storm-Olsen wrote:
>> The conversion of the FileTime to unix time_t is far more heavy.
>=20
> Really?  If so, we might consider storing FILETIME->dwHightDateTime
> and ->dwLowDateTime in the index.
>=20
> But I doubt it.  AFAICT _getting_ at the stat data is the expensive
> thing in Windows, not a 64-bit addition, subtraction and division.

Haha, sure sure, _getting_ that stat data in the first place is the
expensive part on Windows. However, that's something you _have_ to do no
matter what, so there's no way around that.

Turns out that it wasn't as bad as i thought. If you have
filetime_to_time_t() just return, say 116444736, I see
    git add . improve with ~0.5 sec for 100K files
and git status improve with 0.05 sec

Surely, avoiding the tripple stat'ing in 'git status' would help a lot
more ;-) So, I guess we'll just leave the timestamp conversion as is,
and avoid complicating the index.

--
=2Emarius


--------------enigD8381301688C4036D2794315
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG2v6EKzzXl/njVP8RApOuAJ0Xdot1KwkLTY1WFR2Lv7737xa/9wCfYugk
hgIx3WSndo6dvjJdSK6xgd4=
=mfBJ
-----END PGP SIGNATURE-----

--------------enigD8381301688C4036D2794315--
