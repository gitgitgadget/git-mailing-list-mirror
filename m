From: martin f krafft <madduck@madduck.net>
Subject: Re: [gitolite] repo config for delegated projects
Date: Thu, 4 Feb 2010 17:08:12 +1300
Message-ID: <20100204040812.GC13411@lapse.rw.madduck.net>
References: <20100203035718.GA30644@lapse.rw.madduck.net>
 <2e24e5b91002022222h5ca3ebe6k75854a9a056f0ed1@mail.gmail.com>
 <20100203202249.GA27125@lapse.rw.madduck.net>
 <20100204011842.GB497@atcmail.atc.tcs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
To: Sitaram Chamarty <sitaram@atc.tcs.com>,
	git discussion list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Feb 04 05:08:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nct19-0006aC-IG
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 05:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab0BDEIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 23:08:30 -0500
Received: from clegg.madduck.net ([193.242.105.96]:53657 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab0BDEIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 23:08:30 -0500
Received: from lapse.rw.madduck.net (lapse.nz.madduck.net [IPv6:2001:4428:234::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 0E2121D4099;
	Thu,  4 Feb 2010 05:08:16 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 08B602A5; Thu,  4 Feb 2010 17:08:12 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <20100204011842.GB497@atcmail.atc.tcs.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138946>


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sitaram Chamarty <sitaram@atc.tcs.com> [2010.02.04.1418 +1300]:
> how about
>=20
>     $DELEGATED_CONFIGS =3D "hooks.mailinglist,hooks.showrev";

Excellent idea.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
now I lay me back to sleep.
the speaker's dull; the subject's deep.
if he should stop before I wake,
give me a nudge for goodness' sake.
=20
spamtraps: madduck.bogus@madduck.net

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAktqSCwACgkQIgvIgzMMSnVYhgCfSs6HVitDDqdJLbmOBRZ2URy8
pVUAoMKBy0bfI5xFTNP6lUWNI4ZOjAnS
=9NXL
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
