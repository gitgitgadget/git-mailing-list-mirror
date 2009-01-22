From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH (topgit)] tg-patch: add support for generating patches
	against worktree and index
Date: Thu, 22 Jan 2009 11:28:52 +1100
Message-ID: <20090122002852.GE29151@lapse.rw.madduck.net>
References: <1231438975-13624-1-git-send-email-kirr@landau.phys.spbu.ru> <20090108195356.GA14644@lapse.rw.madduck.net> <20090108201614.GA4185@roro3> <20090108211149.GA19983@roro3> <20090118150637.GC27522@roro3.zxlink> <20090120002103.GA12549@lapse.rw.madduck.net> <20090120175635.GA5721@roro3.zxlink> <20090121032052.GB7422@lapse.rw.madduck.net> <20090121202613.GA5400@roro3.zxlink>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 22 01:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPnT7-0004Jm-6G
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 01:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbZAVA3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 19:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbZAVA3Y
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 19:29:24 -0500
Received: from clegg.madduck.net ([193.242.105.96]:43077 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbZAVA3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 19:29:24 -0500
Received: from lapse.rw.madduck.net (unknown [IPv6:2001:388:a001:1:214:a4ff:fe04:eadc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 83BEA1D40B1;
	Thu, 22 Jan 2009 01:29:12 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id F417D80CC; Thu, 22 Jan 2009 13:28:52 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <20090121202613.GA5400@roro3.zxlink>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.27-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8886/Wed Jan 21 23:46:06 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106709>


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Kirill Smelkov <kirr@landau.phys.spbu.ru> [2009.01.22.0726 +110=
0]:
> It seems I need to study how to prepare patches with patchy
> comments, or get my hands dirty with `git am` :)

I believe git-send-email --editor can be used to create a lead-in
mail to describe what follows, and send patches in separate messages
in reply to that lead-in.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"welcome to american airlines, sir. here's your avocado - remember to
 keep it turned on and with you at all times. please turn your luggage
 over to the armadillos for rootling."
                      -- http://azure.humbug.org.au/~aj/armadillos.txt
=20
spamtraps: madduck.bogus@madduck.net

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl3vcQACgkQIgvIgzMMSnUwXACgs6nQr4aK2ZUq0csXobUp2aak
kRgAoO1wtPjh5gS1bTdHpwQgoYzwDiuf
=56k9
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
