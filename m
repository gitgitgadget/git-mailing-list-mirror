From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 11:44:18 +0200
Message-ID: <46A86CF2.9080205@trolltech.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <46A73015.7020306@midwinter.com> <a1bbc6950707251956h3db847c9v8db438f4c665b2cf@mail.gmail.com> <20070726031546.GN32566@spearce.org> <08588116-8E66-4F40-BC77-E0B272BE7776@zib.de> <20070726065332.GB18114@spearce.org> <46A86C42.8070103@trolltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5A7EE0BCCF937C9776360BC0"
Cc: Steffen Prohaska <prohaska@zib.de>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 11:43:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDzso-00078H-7a
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 11:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbXGZJnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 05:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756799AbXGZJnm
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 05:43:42 -0400
Received: from esparsett.troll.no ([62.70.27.18]:41919 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbXGZJnl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 05:43:41 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id C0D89742BE; Thu, 26 Jul 2007 11:43:40 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id B329D742A4; Thu, 26 Jul 2007 11:43:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.5) Gecko/20070716 Thunderbird/2.0.0.5 Mnenhy/0.7.5.666
In-Reply-To: <46A86C42.8070103@trolltech.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53815>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A7EE0BCCF937C9776360BC0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

> You can turn off case-insensitivity in the Windows kernel, by using
> RegEdit, and setting the following registry key to 0:
>=20
> HKLM\SYSTEM\CurrentControlSet\Control\Session
> Manager\kernel\obcaseinsensitive
>=20
> I haven't tried it, but it should help your case above. Just keep=20
> in mind that you can then check in files which your coworkers can't
>  checkout :-)

PS: You'll have to reboot for it to take effect, and don't blame _me_=20
if it doesn't reboot successfully! ;-)

--=20
=2Emarius


--------------enig5A7EE0BCCF937C9776360BC0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGqGzzKzzXl/njVP8RAgOfAKDrNbwSeQUojNWKyMPk/gv1tJ54yACgizWe
CjrYwAAMFoS2+CGJyLaTZug=
=dzVL
-----END PGP SIGNATURE-----

--------------enig5A7EE0BCCF937C9776360BC0--
