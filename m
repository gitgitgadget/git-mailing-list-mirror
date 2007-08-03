From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 03 Aug 2007 09:12:07 +0200
Message-ID: <46B2D547.6050406@trolltech.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA8FE2C428FAC342EFD0D5737"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 09:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGrKK-00024Y-5J
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 09:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758532AbXHCHL5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 03:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758565AbXHCHL5
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 03:11:57 -0400
Received: from esparsett.troll.no ([62.70.27.18]:60404 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758300AbXHCHL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 03:11:56 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 190F874144; Fri,  3 Aug 2007 09:11:17 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 0951274142; Fri,  3 Aug 2007 09:11:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <Pine.LNX.4.64.0708022206130.14781@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54683>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8FE2C428FAC342EFD0D5737
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

> I finally broke down, waiting for the sourceforge project to get
> granted. In the meantime, I registered a project at
>=20
> http://code.google.com/p/msysgit/
>=20
> (WARNING: temporary only!)
>=20
> Would you believe that Google code has a restriction to 20MB per
> file, and 100MB in total, and you cannot remove files?  The same
> Google that gives you 1TB mail space and counting?  Yes, it is
> ludicrous.
>=20
> Anyway, you can get a complete Development environment in 3 files
> (because one would be too large), and... oh well, just read what is
> written on the website if you're really interested.

Great effort Johannes!
The package work perfectly on XP.
I'm trying to get it to work under Wine, but it (Wine) is not playing=20
nice with me at the moment. (The whole system barfs of "Access Denied"=20
and other things. Grrr)

--=20
=2Emarius


--------------enigA8FE2C428FAC342EFD0D5737
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGstVIKzzXl/njVP8RAnjoAJ9DeTO15X1i66AiMLFSfkQUIHlr0wCbBIxZ
H2jqZdEoCw3V7qguxBgf9F8=
=qmfC
-----END PGP SIGNATURE-----

--------------enigA8FE2C428FAC342EFD0D5737--
