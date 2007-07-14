From: martin f krafft <madduck@madduck.net>
Subject: Re: failing to send patches to the list
Date: Sat, 14 Jul 2007 08:05:37 +0200
Message-ID: <20070714060537.GA24396@lapse.madduck.net>
References: <20070713093050.GA18001@lapse.madduck.net> <81b0412b0707130557g6cf04365j232654734b148c3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 14 08:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9akr-0004mH-MR
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 08:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbXGNGFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 02:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbXGNGFS
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 02:05:18 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:51174 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbXGNGFR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 02:05:17 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id DBF80895D73
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 08:05:15 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26290-07 for <git@vger.kernel.org>;
	Sat, 14 Jul 2007 08:05:15 +0200 (CEST)
Received: from lapse.madduck.net (p549C4494.dip0.t-ipconnect.de [84.156.68.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 86FD3895D72
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 08:05:15 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id C3F9C4FD40; Sat, 14 Jul 2007 08:05:37 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81b0412b0707130557g6cf04365j232654734b148c3f@mail.gmail.com>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52443>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Alex Riesen <raa.lkml@gmail.com> [2007.07.13.1457 +0200]:
> I suggest you try "git format-patch -s --stdout |less" before
> sending format-patch without parameters produces nothing.

I did. I simply misquoted in the email. Fact is that sendmail did
send an email, which VGER recognised to be a diff; yet it never
showed up.

I think the missing message ID is likely the problem. I'll look into
it.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
humpty was pushed.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmGexIgvIgzMMSnURAo5zAKDgcFkKRFfyuqg6r+FJX+bplr/KSgCfQ45n
TEdoiejXZ5CGHK6pArLqDfg=
=cbTl
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
