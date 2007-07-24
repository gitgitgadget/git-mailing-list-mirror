From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 10:19:01 +0200
Message-ID: <46A5B5F5.6000202@trolltech.com>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site> <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222223460.14781@racer.site> <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222255010.14781@racer.site> <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org> <7v1wezohi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB28A58DBC0341E7E33075CDC"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 10:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDFbJ-0007MV-7V
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 10:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbXGXISa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 04:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755829AbXGXISa
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 04:18:30 -0400
Received: from esparsett.troll.no ([62.70.27.18]:36141 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbXGXIS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 04:18:28 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 42A9A74219; Tue, 24 Jul 2007 10:18:26 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 327F4741BC; Tue, 24 Jul 2007 10:18:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.5) Gecko/20070716 Thunderbird/2.0.0.5 Mnenhy/0.7.5.666
In-Reply-To: <7v1wezohi4.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53533>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB28A58DBC0341E7E33075CDC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

>> I live by new-workdir.  I do everything with it.  And today I
>> just spent over an hour sorting out cases where my many, many
>> workdirs have different refs than their base repositories,
>> because their packed-refs files are different.
>> Grrrrrrrrrrrrrrrrrr.
>>=20
>> So we really need to make anyone that edits packed-refs (and=20
>> maybe also config) resolve the symlink and do the edit in the=20
>> target directory.  Then we can consider adding this workdir thing
>>  to core git.
>=20
> This is actually not limited to packed-refs file, but applies to=20
> other things as well.
>=20
> I have been wondering if something like this patch would be=20
> sufficient.  The idea essentially is to take the lock on the link
> target when we try to take a lock on something that is a symlink
> pointing elsewhere.
(..snip..)

While you guys are discussing this, please please keep in mind that=20
there are Windows users (/me raises his hand) out there that really=20
really want this too. So, please try to keep it light on the symlinks.

--=20
=2Emarius


--------------enigB28A58DBC0341E7E33075CDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGpbX1KzzXl/njVP8RAo03AKDhbkGAyIFWN7+qI0EEfH7ldT1hiACfdcjk
yEZNei0hVSiUwHdhB73gc4Q=
=K+VG
-----END PGP SIGNATURE-----

--------------enigB28A58DBC0341E7E33075CDC--
