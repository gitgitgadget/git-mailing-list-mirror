From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: MinGW build environment for Git
Date: Wed, 01 Aug 2007 07:15:40 +0200
Message-ID: <46B016FC.4050005@trolltech.com>
References: <a1bbc6950707291614w392bf3a9t5d0d9e50bfcb0f36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig281D76EE6BFA2E1F1587259B"
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 07:14:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG6Xz-0004bO-67
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 07:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbXHAFO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 01:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbXHAFO4
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 01:14:56 -0400
Received: from esparsett.troll.no ([62.70.27.18]:43245 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbXHAFOz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 01:14:55 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 7EBC274596; Wed,  1 Aug 2007 07:14:53 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 5664D74593; Wed,  1 Aug 2007 07:14:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.5) Gecko/20070716 Thunderbird/2.0.0.5 Mnenhy/0.7.5.666
In-Reply-To: <a1bbc6950707291614w392bf3a9t5d0d9e50bfcb0f36@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54407>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig281D76EE6BFA2E1F1587259B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Dmitry Kakurin said the following on 30.07.2007 01:14:
> I want to be able to build MinGW port of Git on Windows. I've tried
> to follow steps in README.MinGW to setup this environment myself
> (install MinGW, MSys, ZLib etc.) but after wasting a lot of time
> with no result I give up. So, could somebody please just pkzip
> their environment (everything required) and share the zip file with
> me (privately or publicly)? I also think that an even better idea
> is to create a new Git repository with MinGW build environment.
> This will make contributing to MinGW port of Git MUCH easier.

Hi Dmitry,

Aaron has done this, and you can find the link on his blog, here:
     http://www.ekips.org/cgi-bin/aaron.cgi/2007/02/27

The archive's compressed with 7zip, so you'll need that to decompress=20
it. (http://www.7-zip.org/)

Direct link to the archive:
     http://inkscape.modevia.com/git/mingw4git.7z

Good luck!
--=20
=2Emarius


--------------enig281D76EE6BFA2E1F1587259B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGsBb8KzzXl/njVP8RAguTAJ9MqB1dENqdbUDOkUXjicWPmSu3dQCfXDhu
p4slT0EcrckT1+i3+MI0ByQ=
=6Wu+
-----END PGP SIGNATURE-----

--------------enig281D76EE6BFA2E1F1587259B--
