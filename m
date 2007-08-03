From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 03 Aug 2007 09:10:17 +0200
Message-ID: <46B2D4D9.4020103@trolltech.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC194C56654CD8A08DC28D938"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 09:09:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGrHw-0001Gn-1P
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 09:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564AbXHCHJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 03:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757516AbXHCHJ3
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 03:09:29 -0400
Received: from esparsett.troll.no ([62.70.27.18]:53934 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349AbXHCHJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 03:09:28 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 517FC74252; Fri,  3 Aug 2007 09:09:26 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 452A974245; Fri,  3 Aug 2007 09:09:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54680>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC194C56654CD8A08DC28D938
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Dmitry Kakurin said the following on 03.08.2007 08:56:
> Great job! Because finding and installing MSys, MinGW and dependencies =
was not trivial at all.
> I have 2 suggestions for this package:
> 1. Remove git repository from it. It will make a download much smaller =
(~20MB smaller) and include the minimum git functionality to=20
> pull mingw git from the server (may be even automatically on first star=
tup).
> 2. Add gdb. Not much could be done without it.
>=20
> With this package (+gdb) it took me about an hour to figure out why git=
 is broken on Vista (this includes learning how to use gdb=20
> :-). So you should expect much higher level of participation on the Win=
dows side.
>=20
> P.S. If package becomes sufficiently small for a single file, try to re=
move 7zip dependency (use WinZip instead). The easier the=20
> installation the better.

Heh, why don't you try to do this yourself? Johannes as kind enough to=20
go out of his way to actually do all that he has already.
Seems like you feel strongly for it, so it shouldn't be too much=20
effort for you. If you provide Johannes with a link to a package of=20
which you speak, I'm sure he'll happily upload it to the google=20
project page.

--=20
=2Emarius


--------------enigC194C56654CD8A08DC28D938
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGstTZKzzXl/njVP8RArIyAJ0Y0S0uizNnkK8sTShdnwEK7JSengCfbXUL
EwUHq7FGvf48klVUa5VgdVk=
=iZzu
-----END PGP SIGNATURE-----

--------------enigC194C56654CD8A08DC28D938--
