From: martin f krafft <madduck@madduck.net>
Subject: Re: Possible to make a totally empty repository for remote access?
Date: Sat, 14 Jul 2007 12:26:38 +0200
Message-ID: <20070714102638.GA5378@lapse.madduck.net>
References: <20070714025819.GA22559@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 12:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9epP-0005Bp-IZ
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 12:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbXGNK0L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 06:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbXGNK0L
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 06:26:11 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:58292 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbXGNK0K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 06:26:10 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 5D42A895D73
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 12:26:09 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06054-06 for <git@vger.kernel.org>;
	Sat, 14 Jul 2007 12:26:09 +0200 (CEST)
Received: from lapse.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 2C8A6895D72
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 12:26:09 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id D08C04F89B; Sat, 14 Jul 2007 12:26:37 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070714025819.GA22559@coredump.intra.peff.net>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52467>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Jeff King <peff@peff.net> [2007.07.14.0458 +0200]:
> The "new" way (by "new" I mean available for over a year, since v1.4.1)
> is to put such configuration into your .git/config file:

Have a look also at

  http://blog.madduck.net/vcs/2007.07.11_publishing-git-repositories

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
it is ok to let your mind go blank,
but please turn off the sound.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmKTdIgvIgzMMSnURAhwwAKC+ZoWYDSTS5qsjJM60yZUBpkhqeQCfZA8x
UZlYbgOtiCPyWrCFRareUtk=
=9pna
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
