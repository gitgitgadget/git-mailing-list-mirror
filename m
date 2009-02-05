From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] urls.txt: document optional port specification in git
 URLS
Date: Thu, 05 Feb 2009 10:12:35 +0100
Message-ID: <498AAD83.9000200@trolltech.com>
References: <1233748295-4554-1-git-send-email-stefan.naewe@atlas-elektronik.com> <20090205080913.GB27983@ultras> <20090205083604.GC27983@ultras>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig372A98A9D8D62A7340925DE4"
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 10:14:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV0JC-0003PU-0h
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 10:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475AbZBEJMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 04:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756537AbZBEJMj
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 04:12:39 -0500
Received: from hoat.troll.no ([62.70.27.150]:33096 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbZBEJMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 04:12:37 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 0DEEB20F8E;
	Thu,  5 Feb 2009 10:12:34 +0100 (CET)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 0111F209C2;
	Thu,  5 Feb 2009 10:12:34 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <20090205083604.GC27983@ultras>
X-Enigmail-Version: 0.95.7
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
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108544>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig372A98A9D8D62A7340925DE4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Nicolas Sebrecht said the following on 05.02.2009 09:36:
> On Wed, Feb 04, 2009 at 12:51:35PM +0100, Stefan Naewe wrote:
>> +- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
>> +- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
>>  - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/rep=
o.git/
>>  - ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
>>  - ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
>=20
> I did not understood. To what does '{startsb}' and '{endsb}' refer ?

Commands for the documentation tool
     {startsb} =3D Start/Left Square Bracket
     {endsb} =3D End/Right Square Bracket

so, you'll end up seeing
     - git://host.xz[:port]/path/to/repo.git/
     - git://host.xz[:port]/~user/path/to/repo.git/

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig372A98A9D8D62A7340925DE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJiq2DKzzXl/njVP8RAqljAJ483q8Lwm9awZGu4Lo05vL0j7TweQCdG1Jn
51s2Of1A6BYdHsJkJnvCKOU=
=nWFt
-----END PGP SIGNATURE-----

--------------enig372A98A9D8D62A7340925DE4--
