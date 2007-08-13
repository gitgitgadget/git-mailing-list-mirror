From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 10:39:54 +0200
Message-ID: <46C018DA.1020309@trolltech.com>
References: <11869508753328-git-send-email-prohaska@zib.de> <118695087531-git-send-email-prohaska@zib.de> <7veji8ifs2.fsf@assigned-by-dhcp.cox.net> <7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net> <46BFFB1A.4070704@trolltech.com> <5BA0164D-8327-4B01-84CD-595D8573BEEF@zib.de> <46C00515.5050308@trolltech.com> <521D9D91-2422-4378-BD68-37550731E06A@zib.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9B374B84E93DAA59D9619F98"
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brian Downing <bdowning@lavos.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 13 10:39:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKVSP-0000Bz-Ep
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 10:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S970131AbXHMIiz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 04:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S970052AbXHMIix
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 04:38:53 -0400
Received: from esparsett.troll.no ([62.70.27.18]:40012 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S970114AbXHMIiu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 04:38:50 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 21F9474232; Mon, 13 Aug 2007 10:38:48 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id E6DBD7422C; Mon, 13 Aug 2007 10:38:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <521D9D91-2422-4378-BD68-37550731E06A@zib.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55752>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B374B84E93DAA59D9619F98
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Steffen Prohaska said the following on 13.08.2007 09:32:
> On Aug 13, 2007, at 9:15 AM, Marius Storm-Olsen wrote:
>> Steffen Prohaska said the following on 13.08.2007 08:50:
>>> We should really make autocrlf =3D true the default for us and
>>> fix all problems that we'll encounter. There may be more tricky
>>> stuff ahead, like merges, cherry-picks, ...
>> I'm more leaning towards having the installer give you the option
>>  to choose what kind of line-endings you want Git to work with;
>> just like the Cygwin installer.
>=20
> Which is the root of much trouble with Cygwin. People now say, git
> works perfectly in Cygwin but forget to mention that they mean
> Cygwin A (in binmode) but not Cygwin B (in textmode).
>=20
> Better choose the right default and work hard to make the default
> choice work perfectly. I am strongly against an option in the
> installer. An option _will_ cause confusion. Better give people a
> hint how they can override the default for a single user, or for a
> single repo. Then they recognize that they move to a non-default
> configuration and hopefully think twice. And we never need to talk
> about msysgit A vs. msysgit B, but only about msysgit with repo
> specific or user specific options.
>=20
> For me, the question comes down to the following: What would the=20
> average Windows user (real Windows user, not Linux user who was=20
> forced to work in Cygwin!) expect git to do with line endings? The
> answer to this question should be the default.

If we were talking about a huge amount (real) Windows users I would=20
agree with you. However, currently most of the users using Git on=20
Windows are Unix users which for some reason have to work on Windows=20
every now and then. And changing the default option to autocrlf=3Dtrue=20
would be stepping on their toes, which we probably don't want to do :-)

I'm a Windows developer myself, so I naturally have autocrlf=3Dtrue in=20
my global settings. I don't think having the option in the installer=20
(together with other things, like setting the global username, and=20
email for example) would be such a bad thing. The problem with the way=20
the Cygwin installer presents it is that it doesn't explain the pros=20
and cons of the two options; it just recommends Linux EOL, which leads=20
to confusion with some Windows developers. If we properly explain the=20
issue in the installer, and say we recommend Windows EOL for Windows=20
developers, I think it's OK. It would in any case be better than the=20
current state where you have no option, or stepping on all the current=20
msysgit/mingw-git maintainers toes.

--=20
=2Emarius


--------------enig9B374B84E93DAA59D9619F98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGwBjaKzzXl/njVP8RAog4AJ93vR2bE37SShM5KS+nR/5gdGwiCACfcBO7
m7D11oAEXaK5EdQ4xS0Cu8I=
=Gc9e
-----END PGP SIGNATURE-----

--------------enig9B374B84E93DAA59D9619F98--
