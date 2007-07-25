From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Wed, 25 Jul 2007 14:10:30 +0200
Message-ID: <46A73DB6.4090007@trolltech.com>
References: <46A5B5F5.6000202@trolltech.com> <46A6F21D.2010306@trolltech.com> <Pine.LNX.4.64.0707251024390.14781@racer.site> <200707251205.48235.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig40C67A7956A2CB180822C4FD"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 14:10:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDfhK-0000aU-V0
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 14:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764911AbXGYMJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 08:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755622AbXGYMJ5
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 08:09:57 -0400
Received: from esparsett.troll.no ([62.70.27.18]:55310 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759920AbXGYMJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 08:09:55 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id CE1CA74280; Wed, 25 Jul 2007 14:09:53 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id B3E047419D; Wed, 25 Jul 2007 14:09:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.5) Gecko/20070716 Thunderbird/2.0.0.5 Mnenhy/0.7.5.666
In-Reply-To: <200707251205.48235.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53686>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig40C67A7956A2CB180822C4FD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Andy Parkins said the following on 25.07.2007 13:05:
> On Wednesday 2007 July 25, Johannes Schindelin wrote:
>=20
>> So this leaves me with the question: do Windows users really want
>> a proper native Windows support for Git?  If the answer is yes,
>> why don't they _do_ (as in "not talk") something about it?
>=20
> I don't disagree with you at all - it is completely ridiculous for
> Windows users to moan about lack of Windows support without
> contributing any help. However, I think there is a good reason.
>=20
> I think it's a chicken and egg problem.  The only reason I started
> making (small) contributions to git was because I was using it
> already.  I didn't set out with the goal "to improve git"; I set
> out looking for a DVCS. Luckily for me, I use Linux so git worked
> pretty well for me straight away.
>=20
> The same is not true for Windows users.  Even if we ignore the fact
> that Windows users are notoriously less open-source savvy; it's
> unlikely that we'll get any Windows contributions until there are
> some threshold number of developers using git on Windows.
>=20
> Open-source is all about scratching an itch, I can't see how
> Windows developers can get a gitch to scratch without being users
> of git first.  On the positive side though, there surely must come
> a point when the Windows port is "good enough" that it will start
> to gather users and hence developers.  Until then, I suppose it's
> just a matter of shouting "patch" every time a windows user asks
> for a feature :-)

Hi Andy,

Your mail is refreshingly spot on. I agree fully with what you say.
I will try to do my part to get Git to this 'threshold', so we can get=20
a proper Windows community behind it too. (It's just a matter of time=20
and resources, which I hope we clear up soon)
My first roadmap item will be to get a fully native compile of the=20
built-in code. If we at least have a Git built with native tools, I=20
think we'll have a lot more people wanting(/able?) to contribute.

AFAIK the MinGW port is cross-compiled on Linux, and can be hard to=20
set up on Windows. The required MinGW packages are scattered all over=20
the place. So, it's not impossible at the moment, but I guess most=20
Windows users feel a bit unmotivated to work on the code mostly since=20
they'll have to develop using Cygwin. (I don't know if that's the=20
reason, just a hunch)

So, IMO its not that Windows users don't _want_ to contribute. I think=20
they feel they can't. Let's see if we can fix that. I'll let the list=20
know as soon as I get native builds going.

Later!

--
=2Emarius


--------------enig40C67A7956A2CB180822C4FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGpz23KzzXl/njVP8RAmlcAJ9nQchEAubqcz0y0/QZE81UhvQxdwCg7AcK
rq/xu1wdVo6yMxCKhu6/xBw=
=yOXZ
-----END PGP SIGNATURE-----

--------------enig40C67A7956A2CB180822C4FD--
