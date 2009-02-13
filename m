From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [RFH] How to review patches: Documentation/ReviewingPatches?
Date: Fri, 13 Feb 2009 08:54:16 +0100
Message-ID: <49952728.2080404@trolltech.com>
References: <200902130045.59395.jnareb@gmail.com> <alpine.DEB.1.00.0902130055370.26370@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAABF5A2A43087722AD19A2CE"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 13 08:55:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXstt-0003Mp-2S
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 08:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbZBMHy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 02:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbZBMHyZ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 02:54:25 -0500
Received: from hoat.troll.no ([62.70.27.150]:39722 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470AbZBMHyY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 02:54:24 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id C845220ED3;
	Fri, 13 Feb 2009 08:54:16 +0100 (CET)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id B9EA9209F5;
	Fri, 13 Feb 2009 08:54:16 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <alpine.DEB.1.00.0902130055370.26370@racer>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109724>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAABF5A2A43087722AD19A2CE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin said the following on 13.02.2009 01:08:
> There is another reason why I do not want any ReviewingPatches:
> reviewing is already such a tedious process; let's not make it
> harder by forcing a potential reviewer to sift through a document
> (the same could be said about SubmittingPatches; IMHO it just
> repeats what common sense would do anyway when imitating existing
> code).

One thing I've wondered about though when sending patches, is how to=20
send the fixups. Lets say I have a patch serie with 8 patches, do I=20
send the whole serie each time, or do I just send an update to each=20
individual patch? Do I attach it to the previous thread, or start a=20
new one?

I couldn't really draw any conclusion by watching the list, since all=20
methods are used. However, I'd like to do what's easiest for the=20
reviewers and maintainers. Probably a new series each time is easiest=20
for Junio to parse and apply, without single updates deep in a thread.=20
However, that might also be considered a tad 'spamming' of the list?

Though, ignoring mail threads is fairly trivial with threading MUAs=20
;-) (I've used "Mark thread as read" quite a bit lately :-)

Any opinions, preferably from those that review a lot, and apply=20
patches directly from the mailing list? Maybe this could qualify as a=20
section in Documentation/SubmittingPatches?

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enigAABF5A2A43087722AD19A2CE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJlScoKzzXl/njVP8RAjgKAKD5USfXuNa+r6y3H2ep24dcTCKmegCgnqCG
E21LnDJAL/hjjJclOeTW0o0=
=Hhun
-----END PGP SIGNATURE-----

--------------enigAABF5A2A43087722AD19A2CE--
