From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Wed, 05 Sep 2007 08:22:38 +0200
Message-ID: <46DE4B2E.70105@trolltech.com>
References: <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site> <46DD433A.5040604@eudaptics.com> <Pine.LNX.4.64.0709041324420.28586@racer.site> <Pine.LNX.4.64.0709041356070.28586@racer.site> <20070904210200.GA32472@nospam.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA2AD9C8CB1D464BDC4EC6EE9"
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Git Mailing List <git@vger.kernel.org>
To: git@wingding.demon.nl,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Sep 05 08:22:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISoHp-0005BN-7D
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 08:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbXIEGWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 02:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbXIEGWn
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 02:22:43 -0400
Received: from esparsett.troll.no ([62.70.27.18]:54104 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbXIEGWm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 02:22:42 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 2AAF2741A3; Wed,  5 Sep 2007 08:22:39 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id DB7137419D; Wed,  5 Sep 2007 08:22:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <20070904210200.GA32472@nospam.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57669>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA2AD9C8CB1D464BDC4EC6EE9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Rutger Nijlunsing said the following on 04.09.2007 23:02:
> On Tue, Sep 04, 2007 at 01:57:38PM +0100, Johannes Schindelin wrote:
>> Now I am utterly confused.  MSDN says
>> 	FILETIME
>> 	Contains a 64-bit value representing the number of 100-nanosecond=20
>> 	intervals since January 1, 1601 (UTC).
>> Hmm.
>=20
> [Warning: war stories ahead...]
> If you really, really want to know more:
> http://search.cpan.org/~shay/Win32-UTCFileTime-1.45/lib/Win32/UTCFileTi=
me.pm

Thanks, seems like it's the right decision then to ensure that we use=20
UTC throughout Git on Windows

Hannes & Dscho, looks like we should revert
http://repo.or.cz/w/git/mingw/4msysgit.git?a=3Dcommitdiff;h=3D683775c00d9=
fb95bcbe4632f95b67a96b902fa59
then, and rather apply Dscho's patch for a custom time()=20
implementation. Dscho, was the custom implementation of time() enough=20
to fix the issues for you?

--=20
=2Emarius


--------------enigA2AD9C8CB1D464BDC4EC6EE9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFG3ksuKzzXl/njVP8RAh6eAKCEpr3H/nMqhXe5yuXWl7tFsj4+SACgz6yH
B8rj3RBl2kqQjaMbexgD074=
=RXgP
-----END PGP SIGNATURE-----

--------------enigA2AD9C8CB1D464BDC4EC6EE9--
