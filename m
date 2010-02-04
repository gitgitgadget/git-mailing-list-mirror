From: martin f krafft <madduck@madduck.net>
Subject: Re: [gitolite] symlink hooks instead of copying them
Date: Thu, 4 Feb 2010 19:34:47 +1300
Message-ID: <20100204063447.GA16106@lapse.rw.madduck.net>
References: <20100204013556.GA2590@atcmail.atc.tcs.com>
 <20100204012840.GC497@atcmail.atc.tcs.com>
 <20100204014657.GA10114@lapse.rw.madduck.net>
 <19306.26226.369115.104150@blake.zopyra.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Cc: Bill Lear <rael@zopyra.com>,
	Sitaram Chamarty <sitaram@atc.tcs.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 07:35:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcvJ2-0005tb-M7
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 07:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab0BDGfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 01:35:08 -0500
Received: from clegg.madduck.net ([193.242.105.96]:40540 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab0BDGfG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 01:35:06 -0500
Received: from lapse.rw.madduck.net (lapse.nz.madduck.net [IPv6:2001:4428:234::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id C3CB61D4099;
	Thu,  4 Feb 2010 07:34:51 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id BB344BB; Thu,  4 Feb 2010 19:34:47 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <19306.26226.369115.104150@blake.zopyra.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-trunk-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138954>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bill Lear <rael@zopyra.com> [2010.02.04.1917 +1300]:
> Does 'ln -sf' work reliably on all distros?  I seem to recall on Ubuntu
> 7.10 that this was broken.

unlink && symlink in Perl is probably preferably anyway.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
because light travels faster than sound,
some people appear to be intelligent,
until you hear them speak.
=20
spamtraps: madduck.bogus@madduck.net

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAktqaoQACgkQIgvIgzMMSnW3+QCg6w5oBXDFbGP2IVr/P3MealES
wdoAoNN+F7y7m7BRUpDYRZeFT+LYKu6E
=IupU
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
