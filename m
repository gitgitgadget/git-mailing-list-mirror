From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 13:45:22 +0200
Message-ID: <465C1252.9020801@trolltech.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <465C064F.B9CE9379@eudaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0598D81D737706750337B6D7"
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue May 29 13:47:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht0Ap-0006Vd-1q
	for gcvg-git@gmane.org; Tue, 29 May 2007 13:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbXE2Lr0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 07:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbXE2Lr0
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 07:47:26 -0400
Received: from esparsett.troll.no ([62.70.27.18]:60021 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbXE2LrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 07:47:25 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 2F1D1600C9; Tue, 29 May 2007 13:47:24 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id BF1AF600C7; Tue, 29 May 2007 13:47:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070326 Thunderbird/2.0.0.0 Mnenhy/0.7.5.666
In-Reply-To: <465C064F.B9CE9379@eudaptics.com>
X-Enigmail-Version: 0.95.0
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48685>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0598D81D737706750337B6D7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Sixt said the following on 29.05.2007 12:54:
> Han-Wen Nienhuys wrote:
>> Johannes Sixt escreveu:
>>> * git without an correct git subcommand should list 20 or so
>>> commands, but it doesn't. The list is just empty.
>> there was a problem in generate cmd list,  (I have sort in /bin/
>> ). I recommend to add
>=20
> Strange. Here, MSYS aliases /usr to /, hence /usr/bin/sort is the
> same as /bin/sort.
>=20
> (For the curious ones: The MinGW port has to replace occurrences of
> 'sort' by '/usr/bin/sort', otherwise Windows's 'sort' would be
> picked up in shell scripts, because the latter usually comes first
> in %PATH%^W$PATH. Same for 'find'.)

I get that here too, no matter what I set the mount point to be, and=20
without the fstab file at all.

Also, the /bin/gitk.bat file should rather be
     @"%~d0%~p0wish84.exe" "%~d0%~p0gitk" %*
than the current hardcoded path. (Probably won't work with=20
command.com, but who uses that for development nowadays anyways, right ;-=
)

--=20
=2Emarius


--------------enig0598D81D737706750337B6D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGXBJSKzzXl/njVP8RAp+EAKDurVFLo1ieJvU3QKQrYM+8TXFbIACg7kG/
vtInp10iv8we6bfqwQr1yRk=
=QXoj
-----END PGP SIGNATURE-----

--------------enig0598D81D737706750337B6D7--
