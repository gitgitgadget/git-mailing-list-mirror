From: martin f krafft <madduck@debian.org>
Subject: Re: a few Topgit patches
Date: Mon, 5 Jan 2009 16:49:30 +0100
Organization: The Debian project
Message-ID: <20090105154930.GD26178@piper.oerlikon.madduck.net>
References: <20081223143035.GA24087@cassiopeia.tralala> <20081225145834.GA16852@lapse.rw.madduck.net> <20081226170334.GA18722@pengutronix.de> <20090104130532.GA1055@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Jan 05 16:51:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJrjZ-0002bK-Py
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 16:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbZAEPtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 10:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbZAEPtv
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 10:49:51 -0500
Received: from clegg.madduck.net ([193.242.105.96]:52055 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZAEPtu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 10:49:50 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 098AB1D40AA;
	Mon,  5 Jan 2009 16:49:33 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 703CF9F184;
	Mon,  5 Jan 2009 16:49:31 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id B9FE4442F; Mon,  5 Jan 2009 16:49:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090104130532.GA1055@pengutronix.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8836/Mon Jan  5 13:16:27 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104581>


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2009.01.04=
=2E1405 +0100]:
> This is done.  Now I even changed '-n' to '--numbered' and changed the
> commit log accordingly.  Are there still concerns about my patches?
> Should I resend the current version?
>=20
> The patches are still available in my topgit repo at
>=20
> 	git://git.pengutronix.de/git/ukl/topgit.git master

I pulled and pushed them. Thanks.

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
sed -e '/^[when][coders]/!d' \
    -e '/^...[discover].$/d' \
    -e '/^..[real].[code]$/!d' \
    /usr/share/dict/words

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkliLAoACgkQIgvIgzMMSnUktACgj3RHtoSGl31fwdZ8EoGB9/aC
yZ8AoIy2kbWMBjTGm7+v82I1jC2xptfO
=E2oK
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
