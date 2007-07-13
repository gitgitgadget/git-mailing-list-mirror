From: martin f krafft <madduck@madduck.net>
Subject: Re: git-svn: failure to clone logcheck's repo
Date: Fri, 13 Jul 2007 12:37:14 +0200
Message-ID: <20070713103714.GA30474@lapse.madduck.net>
References: <20070713093622.GA21001@lapse.madduck.net> <20070713094710.GB18199@xp.machine.xx> <20070713095620.GC18199@xp.machine.xx> <20070713093622.GA21001@lapse.madduck.net> <20070713094710.GB18199@xp.machine.xx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 13 12:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9IW2-0007Xk-TN
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 12:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbXGMKgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 06:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbXGMKgr
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 06:36:47 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:55264 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbXGMKgr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 06:36:47 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id D959F895D73
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 12:36:45 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 04078-09 for <git@vger.kernel.org>;
	Fri, 13 Jul 2007 12:36:45 +0200 (CEST)
Received: from lapse.madduck.net (p549C364A.dip0.t-ipconnect.de [84.156.54.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 84A1D895D72
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 12:36:45 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 0824F4FD40; Fri, 13 Jul 2007 12:37:14 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070713095620.GC18199@xp.machine.xx> <20070713094710.GB18199@xp.machine.xx>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52384>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Peter Baumann <waste.manager@gmx.de> [2007.07.13.1147 +0200]:
> This is a known problem. If I remember correctly,it is save to
> just resume the import with git-svn fetch, and nothing bad should
> happen.

Yeah, this seems to work.

> Just found it. Look e.g. here on the comment from Eric Wong:
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/50962/focus=3D2759=
13

Shame on me, I really should have done the research myself. I guess
I am still too overwhelmed with git, but that won't last long,
I promise.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"lessing was a heretics' heretic"=20
                                                    -- walter kaufmann

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGl1XaIgvIgzMMSnURAhN+AJ9tYv/2mTxeVhaMb8PgVafkVFh9MACeKh0S
mxr1AVJsnI2OE5ilt41JLAk=
=1Wol
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
