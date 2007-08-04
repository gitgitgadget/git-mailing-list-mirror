From: martin f krafft <madduck@madduck.net>
Subject: Re: Help a sed noob
Date: Sat, 4 Aug 2007 15:56:30 +0200
Message-ID: <20070804135630.GC1605@lapse.madduck.net>
References: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com> <20070804103126.GA28402@lapse.madduck.net> <20070804115003.GA9716@coredump.intra.peff.net> <20070804121811.GA1605@lapse.madduck.net> <46B4705D.2010208@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Cc: Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 15:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHK6p-0003Ix-2e
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 15:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760382AbXHDNz4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 09:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760396AbXHDNz4
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 09:55:56 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:34012 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbXHDNzz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 09:55:55 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 58F6E895D96;
	Sat,  4 Aug 2007 15:55:53 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 29220-01; Sat, 4 Aug 2007 15:55:52 +0200 (CEST)
Received: from lapse.madduck.net (AToulon-256-1-9-110.w86-211.abo.wanadoo.fr [86.211.64.110])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 175C1895D94;
	Sat,  4 Aug 2007 15:55:51 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 5DA6D4FD3D; Sat,  4 Aug 2007 15:56:30 +0200 (CEST)
Mail-Followup-To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Jeff King <peff@peff.net>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46B4705D.2010208@fs.ei.tum.de>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-686 i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54848>


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Simon 'corecode' Schubert <corecode@fs.ei.tum.de> [2007.08.04.1=
426 +0200]:
> s// is "match last regexp, so s/// is "match last regexp and replace with=
=20
> empty string.

This fact is not in the manpage, AFAICT, at least not on Debian
systems.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
due to lack of interest tomorrow has been cancelled.
=20
spamtraps: madduck.bogus@madduck.net

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGtIWOIgvIgzMMSnURAh+aAKDpBSVDTzbHAW4lPXe5aK9ZaIz5PwCg0Hrq
/pkr6noMTZnnFH8aUenkYW4=
=8jSA
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--
