From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 1/2] Introduces xmkstemp()
Date: Fri, 31 Aug 2007 11:00:20 +0200
Message-ID: <46D7D8A4.1060800@trolltech.com>
References: <20070814164453.400b9c55@localhost> <46D7D0F7.1050302@trolltech.com> <46D7D284.30004@telecom.at> <46D7D48D.6000503@trolltech.com> <46D7D60C.8090608@telecom.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEE6C64565E5D0B2AC6BB6FC4"
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Aug 31 11:00:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR2Mc-0002mr-BB
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 11:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758789AbXHaJAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 05:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758206AbXHaJAU
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 05:00:20 -0400
Received: from esparsett.troll.no ([62.70.27.18]:41777 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757045AbXHaJAT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 05:00:19 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id A06F274323; Fri, 31 Aug 2007 11:00:17 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 831E17427B; Fri, 31 Aug 2007 11:00:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <46D7D60C.8090608@telecom.at>
X-Enigmail-Version: 0.95.3
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57138>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE6C64565E5D0B2AC6BB6FC4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Sixt said the following on 31.08.2007 10:49:
> Marius Storm-Olsen schrieb:
>> Just wanted to let the original author know, so he would be aware
>> of it, and we wouldn't have to go the extra round-trips with
>> patches to fix patches. (And for MinGW awareness when adding code
>> to git-compat-util.h)
>=20
> You can't expect a lot of MinGW awareness from non-MinGW users when
> they make changes to git-compat-util.h since upstream does not have
> _any_ references to MinGW there, yet.

D'oh!
/me smacks self

We really need to streamline the patches needed for MinGW, and get=20
those merged into upstream when 1.5.3 is released.

--=20
=2Emarius


--------------enigEE6C64565E5D0B2AC6BB6FC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG19ikKzzXl/njVP8RAr4+AJ4kELGZ+GPtCJT1PhJGAw/XD4e/xACgoZkp
xJzhbH7OKdzPOV/c7HAYJHI=
=jY+K
-----END PGP SIGNATURE-----

--------------enigEE6C64565E5D0B2AC6BB6FC4--
