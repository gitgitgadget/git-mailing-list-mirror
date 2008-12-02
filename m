From: martin f krafft <madduck@debian.org>
Subject: Re: [TOPGIT] Resolving conflicts
Date: Tue, 2 Dec 2008 08:49:15 +0100
Organization: The Debian project
Message-ID: <20081202074915.GD31660@piper.oerlikon.madduck.net>
References: <20081201121819.GB13495@pengutronix.de> <20081201143640.GA17818@cassiopeia.tralala>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 08:50:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Q1y-0000Ce-Jw
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 08:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbYLBHtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 02:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbYLBHtc
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 02:49:32 -0500
Received: from clegg.madduck.net ([193.242.105.96]:48612 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbYLBHtb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 02:49:31 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 147811D40B8;
	Tue,  2 Dec 2008 08:49:17 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 375999F184;
	Tue,  2 Dec 2008 08:49:16 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id EBFB94602; Tue,  2 Dec 2008 08:49:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081201143640.GA17818@cassiopeia.tralala>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8706/Tue Dec  2 01:08:47 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102125>


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2008.12.01=
=2E1536 +0100]:
> > Another thing is that the exported branch contains an empty commit
> > resulting from t/whatever (and a corresponding empty patch when exported
> > as a quilt series)
> I fixed one half of this in with a patch sent to the ML:
>=20
> 	http://article.gmane.org/gmane.comp.version-control.git/101728
>=20
> it didn't made it upstream yet, though.

This is now in HEAD. Sorry for the delay.

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"i like wagner's music better than anybody's. it is so loud that one
 can talk the whole time without other people hearing what one says."
                                                        -- oscar wilde

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk06HsACgkQIgvIgzMMSnUGngCgsjZQNG6uHgQpPDYZTr3umwdk
PlsAn3mYnY8SoyUelaibhMt0+jjf00w9
=GaMs
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
