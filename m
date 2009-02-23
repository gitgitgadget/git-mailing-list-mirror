From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for
 commits older than a year
Date: Mon, 23 Feb 2009 09:09:02 +0100
Message-ID: <49A2599E.2030406@trolltech.com>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com> <20090222230620.GB19011@coredump.intra.peff.net> <7v7i3ix6yi.fsf@gitster.siamese.dyndns.org> <20090223031631.GC22348@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8EABDCA07BE3735FF68C6CD6"
Cc: Junio C Hamano <gitster@pobox.com>, eletuchy@gmail.com,
	git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 09:10:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbVta-0000bZ-D7
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 09:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbZBWIJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 03:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbZBWIJG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 03:09:06 -0500
Received: from hoat.troll.no ([62.70.27.150]:48573 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666AbZBWIJF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 03:09:05 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 170D820FA6;
	Mon, 23 Feb 2009 09:09:02 +0100 (CET)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 066D420FA3;
	Mon, 23 Feb 2009 09:09:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <20090223031631.GC22348@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111118>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8EABDCA07BE3735FF68C6CD6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Jeff King said the following on 23.02.2009 04:16:
> On Sun, Feb 22, 2009 at 05:44:37PM -0800, Junio C Hamano wrote:
>>> +		/* Otherwise, years. Centuries is probably overkill. */
>>> +		snprintf(timebuf, sizeof(timebuf), "%lu years ago", (diff + 183) /=
 365);
>>> +		return timebuf;
>> I agree this is an improvement.  It irritated me, too.  And I do
>> not think this change falls into the category of bad backward
>> incompatibility.
>>=20
>> I was hoping somebody would do a "N years M months", though.
>=20
> I thought about that, but I wanted to keep the maximum size down
> for column output (like in git-blame). Which is why I bumped the
> "use months" limit to 24 months instead of 12.
>=20
> And that limit can also be tweaked.  Surely at some point there is
> a range where you no longer care about the months and "N years" has
> high enough resolution. But there is also a point where "N months"
> gets cumbersome (75 months is a more annoying than "around 6
> years"). The question is whether we reach the "cumbersome" point
> before we reach the "don't care about months" point.
>=20
> Another option would to give higher resolution in number of years,
> like "3.5 years" or even "3.1 years".

And using shorter names for the units would be a no-go?

   "3y 2m ago"    <--
   "3 years ago"
   "3 months ago"
   "3 weeks ago"
   "3 days ago"
   "3 hours ago"
   "3 mins ago"   <--
   "3 secs ago"   <--

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig8EABDCA07BE3735FF68C6CD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJolmeKzzXl/njVP8RAskiAJsGHN3KngQ/uHdhC9xx8p/plWTIzgCgr6tP
OclOSrtg2x3JvbuZ6oU2Dyw=
=cIAK
-----END PGP SIGNATURE-----

--------------enig8EABDCA07BE3735FF68C6CD6--
