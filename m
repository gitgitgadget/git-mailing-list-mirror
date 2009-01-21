From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH (topgit)] tg-patch: add support for generating patches
	against worktree and index
Date: Wed, 21 Jan 2009 14:20:52 +1100
Message-ID: <20090121032052.GB7422@lapse.rw.madduck.net>
References: <1231438975-13624-1-git-send-email-kirr@landau.phys.spbu.ru> <20090108195356.GA14644@lapse.rw.madduck.net> <20090108201614.GA4185@roro3> <20090108211149.GA19983@roro3> <20090118150637.GC27522@roro3.zxlink> <20090120002103.GA12549@lapse.rw.madduck.net> <20090120175635.GA5721@roro3.zxlink>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 04:23:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPTgf-0002KB-Ul
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 04:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756329AbZAUDWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 22:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755922AbZAUDWF
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 22:22:05 -0500
Received: from clegg.madduck.net ([193.242.105.96]:54344 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbZAUDWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 22:22:02 -0500
Received: from lapse.rw.madduck.net (unknown [IPv6:2001:388:a001:1:214:a4ff:fe04:eadc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id C9C631D40B1;
	Wed, 21 Jan 2009 04:21:51 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 5E8E880CD; Wed, 21 Jan 2009 16:20:52 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <20090120175635.GA5721@roro3.zxlink>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.27-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8881/Tue Jan 20 15:48:51 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106564>


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Kirill Smelkov <kirr@landau.phys.spbu.ru> [2009.01.21.0456 +110=
0]:
> No problem and take your time.
>=20
> It was just me having no idea about what's going on.

I am a little confused about the patches, and git-am does not seem
to be able to apply two patches from the same email. I use Maildir,
so I am passing the single message with multiple patches to git-am,
and it applies all changes into one single commit.

Anyway, do you have a repo which I can cherry-pick from?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"out of the crooked timber of humanity,
 no straight thing was ever made."
                                                       -- imanuel kant
=20
spamtraps: madduck.bogus@madduck.net

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl2lJMACgkQIgvIgzMMSnUCdQCg2Cwe5KRPQf34Wa1H1U6qrw0t
6cgAoOmL5JJ2jjmhugTKXF+z1mxBnCuv
=WtiQ
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
