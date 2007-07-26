From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 11:41:22 +0200
Message-ID: <46A86C42.8070103@trolltech.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <46A73015.7020306@midwinter.com> <a1bbc6950707251956h3db847c9v8db438f4c665b2cf@mail.gmail.com> <20070726031546.GN32566@spearce.org> <08588116-8E66-4F40-BC77-E0B272BE7776@zib.de> <20070726065332.GB18114@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7559C1BDDD35368743F6563B"
Cc: Steffen Prohaska <prohaska@zib.de>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 11:40:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDzpy-0006JP-EP
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 11:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbXGZJkr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 05:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbXGZJkq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 05:40:46 -0400
Received: from esparsett.troll.no ([62.70.27.18]:41754 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbXGZJkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 05:40:45 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 0771874277; Thu, 26 Jul 2007 11:40:44 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id EFE6274269; Thu, 26 Jul 2007 11:40:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.5) Gecko/20070716 Thunderbird/2.0.0.5 Mnenhy/0.7.5.666
In-Reply-To: <20070726065332.GB18114@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53814>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7559C1BDDD35368743F6563B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

>>    * Be careful with the case in filenames. Similarly, avoid
>> special chars in filenames.
>=20
> This is true. Git doesn't like getting file names with case only=20
> differences on such a platform. E.g. just today I wanted to do the
> following:
>=20
>   git mv foo.c Foo.c
>=20
> but had to instead do:
>=20
>   git mv foo.c CRAP && git mv CRAP Foo.c
>=20
> because the former won't work on a filesystem that ignores case. I
> have the same problem on my Mac OS X HFS+ volume as it also ignores
> case.

You can turn off case-insensitivity in the Windows kernel, by
using RegEdit, and setting the following registry key to 0:

HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel\obcaseinsens=
itive

I haven't tried it, but it should help your case above. Just keep
in mind that you can then check in files which your coworkers can't
checkout :-)

--=20
=2Emarius


--------------enig7559C1BDDD35368743F6563B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGqGxCKzzXl/njVP8RAuG4AJ9IebGkGZkvfSL9Es4iJnCjN6vHxACgoVmC
18RSq6bQQH1FzQIPUicQ+Ck=
=QNCj
-----END PGP SIGNATURE-----

--------------enig7559C1BDDD35368743F6563B--
