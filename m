From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 04 Sep 2007 13:53:30 +0200
Message-ID: <46DD473A.8010602@trolltech.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site> <46DD433A.5040604@eudaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC4377B86D3CCAD57654AE1F9"
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@eudaptics.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 13:53:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISWyD-0000az-68
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 13:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbXIDLxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 07:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbXIDLxW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 07:53:22 -0400
Received: from esparsett.troll.no ([62.70.27.18]:50522 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbXIDLxV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 07:53:21 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 4D359741D0; Tue,  4 Sep 2007 13:53:20 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 3C619741D7; Tue,  4 Sep 2007 13:53:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <46DD433A.5040604@eudaptics.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57556>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC4377B86D3CCAD57654AE1F9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Sixt said the following on 04.09.2007 13:36:
> Johannes Schindelin schrieb:
>> On Tue, 4 Sep 2007, Johannes Sixt wrote:
>>> Therefore, I've pushed out a fixup patch at the top of
>>> mingw.git's devel branch that converts mtime to local time
>> On Linux, we compare to UTC to begin with, right?  We should do
>> that here, too...  So if time(NULL) does not return UTC on MinGW,
>> we have to wrap that function, too.
>=20
> According to MSDN, time(NULL) returns "the number of seconds
> elapsed since [epoch] according to the system clock". Please don't
> ask me what "the system clock" is.
>=20
> Reading the implementation of time(), it starts with
> GetLocalTime(), determines whether daylight saving is in effect,
> and continues with another round of timezone adjustment - mind you:
> _not_ a timezone reversal (!!). Doesn't this look extremely bogus?
>=20
> It seems we really need a wrapper for time().

Hmm, could be.
In the meantime, I've pushed out a new patch
http://repo.or.cz/w/git/mingw/4msysgit.git?a=3Dcommitdiff;h=3D683775c00d9=
fb95bcbe4632f95b67a96b902fa59

/me starts another test run, to see how our tests are doing now..

--=20
=2Emarius


--------------enigC4377B86D3CCAD57654AE1F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG3Uc6KzzXl/njVP8RAqcxAKDMega2CT0ZclSb2l4Bkb3K72S7agCfSXhs
sm+tMj0lgdSj0zHirCdIxjY=
=D++j
-----END PGP SIGNATURE-----

--------------enigC4377B86D3CCAD57654AE1F9--
