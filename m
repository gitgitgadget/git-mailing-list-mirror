From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: git-p4import.py robustness changes
Date: Fri, 15 Jun 2007 07:30:39 +0200
Message-ID: <467223FF.6010701@storm-olsen.com>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <200706122347.00696.simon@lst.de> <20070614053538.GA6073@spearce.org> <200706142344.29089.simon@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig59EABBA9E8845AC6E8C3202F"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Fri Jun 15 08:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz5dc-0006DO-85
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 08:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbXFOGu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 02:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbXFOGu1
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 02:50:27 -0400
Received: from init.linpro.no ([80.232.38.252]:36720 "EHLO init.linpro.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbXFOGu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 02:50:26 -0400
X-Greylist: delayed 4767 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jun 2007 02:50:25 EDT
Received: from [62.70.27.100] (helo=[10.3.4.215])
	(Authenticated Sender=marius@storm-olsen.com)
	by init.linpro.no with esmtpa (Exim 4.50 #1 (Debian))
	id 1Hz4OM-0000DH-8H; Fri, 15 Jun 2007 07:30:43 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070326 Thunderbird/2.0.0.0 Mnenhy/0.7.5.666
In-Reply-To: <200706142344.29089.simon@lst.de>
From: mstormo_git@storm-olsen.com
X-Enigmail-Version: 0.95.1
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
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on spamtrap
X-Spam-Status: No, hits=0.0 required=5.0 tests=DSPAM=0	version=2.63
X-Spam-Level: 
X-DSPAM-Signature: !DSPAM:467223f110831298618000!
X-DSPAM-Probability: 0.0000
X-DSPAM-Confidence: 0.9997
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50248>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig59EABBA9E8845AC6E8C3202F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Simon Hausmann said the following on 14.06.2007 23:44:
> First of all thanks for looking at the branch. I agree with your
> concerns and I do admit that I've been a bit too sloppy with the
> log messages.
>=20
> I have started cleaning up the history even more by reworking the
> log messages of my commits (git-p4-enhanced-logs branch in
> fast-export, starting at the last page). Once that is done (I
> expect that to take a few days) I'll add the missing SOB lines with
> git-filter-branch and see if I can get an agreement from Han-Wen
> and Marius for doing the same with their commits (adding the=20
> missing lines).

Simon,

Of course! Go right ahead and add the SOB for my commits while you're=20
at it.

--=20
=2Emarius


--------------enig59EABBA9E8845AC6E8C3202F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGciP/KzzXl/njVP8RAlGnAKCDs/xnUFAlrduTjdHAgzCJwZIwcQCfWgVu
JQTSEXhnixTiUf+HNhlvr3A=
=YUNY
-----END PGP SIGNATURE-----

--------------enig59EABBA9E8845AC6E8C3202F--
