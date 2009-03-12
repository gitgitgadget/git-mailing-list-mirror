From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH 2/2] [TopGit] Portability: Don't use alternation ("|")
	in sed regular expressions
Date: Thu, 12 Mar 2009 16:26:30 +0100
Message-ID: <20090312152630.GA26379@piper.oerlikon.madduck.net>
References: <78BA729B-0026-45D0-96FC-330700519AAB@dartmouth.edu> <20090312152039.GA15626@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Brian Campbell <brian.p.campbell@dartmouth.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr
X-From: git-owner@vger.kernel.org Thu Mar 12 16:35:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhmpb-0003Ha-3T
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 16:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524AbZCLP05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 11:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbZCLP04
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 11:26:56 -0400
Received: from clegg.madduck.net ([193.242.105.96]:57821 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbZCLP0z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 11:26:55 -0400
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id C2BC61D40C2;
	Thu, 12 Mar 2009 16:26:31 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id 86F559F13D;
	Thu, 12 Mar 2009 16:26:30 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 1E1AD447E; Thu, 12 Mar 2009 16:26:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090312152039.GA15626@pengutronix.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9100/Thu Mar 12 10:07:56 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113079>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2009.03.12=
=2E1620 +0100]:
> IMHO we should reuse as much as possible from git.git.  For me even
> requiring a git.git checkout to use its files would be OK.  I consider
> that even better then duplicating the relevant files.

Maybe we could even start to think about integrating TopGit back
into git.git?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"perhaps debian is concerned more about technical excellence rather
 than ease of use by breaking software. in the former we may excel.
 in the latter we have to concede the field to microsoft. guess
 where i want to go today?"
                                                 -- manoj srivastava
=20
spamtraps: madduck.bogus@madduck.net

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkm5KaIACgkQIgvIgzMMSnUurQCgqJ94X9awD3ZuWK7lbI1BJ6yb
bX0AoKG2ZJq3cEo1xMMkODv1ijMtuOfd
=iVE0
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
