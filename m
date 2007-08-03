From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 03 Aug 2007 15:08:58 +0200
Message-ID: <46B328EA.4030309@trolltech.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>  <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com>  <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com> <Pine.LNX.4.64.0708031334530.14781@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig038163DF763C3D7491A224AC"
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 15:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGwt6-0004DH-Fd
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 15:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760424AbXHCNIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 09:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757765AbXHCNIK
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 09:08:10 -0400
Received: from esparsett.troll.no ([62.70.27.18]:52600 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760424AbXHCNIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 09:08:09 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 6DCFC74272; Fri,  3 Aug 2007 15:08:07 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 58A1574261; Fri,  3 Aug 2007 15:08:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <Pine.LNX.4.64.0708031334530.14781@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54721>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig038163DF763C3D7491A224AC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin said the following on 03.08.2007 14:37:
> On Fri, 3 Aug 2007, Dmitry Kakurin wrote:
>> The changes that I've made:
>> * removed .git in /git directory to save space
>> * installed gdb
>> * applied my Vista fix
>> * made self-extracting .rar archive
>=20
> * replace rxvt by that stupid cmd window
> Sneaky.
> Can you defend the choice?
> FWIW here are my arguments for rxvt:
>=20
> 	- it behaves the same on all Windows versions
> 	- it has a scroll back (which you have to activate on cmd first)
> 	- it is resizable
> 	- it has sane copy&paste behaviour (which you have to activate on=20
> 		cmd first, and then still have to hit the Return key after=20
> 		having selected some text)

Normally, people would probably like to stay in their current=20
environment/window. Let's say you're doing something in a cmd windows,=20
then you want to go and compile git. If you run msys.bat, it will kill=20
your current window, and show a rxvt window instead. That's kinda not=20
nice really.

If you enable the QuickEdit in the 'CMD' window, you mark with mouse,=20
the right-click to copy, then right-click again to paste. No need to=20
move your hand and hit Enter/Return. (Many people don't know about the=20
right-click to copy, but it's a much better work-flow)

You can do all the changes (like changing the scrollback size and edit=20
mode) once, then store it, never to change it again.

--=20
=2Emarius


--------------enig038163DF763C3D7491A224AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGsyjqKzzXl/njVP8RAuLZAJ0SROYmyXlwvwNIuj+pentCEqry3gCg2izM
5mk1PUNaTkc5LE4SjEAJbdk=
=8pnH
-----END PGP SIGNATURE-----

--------------enig038163DF763C3D7491A224AC--
