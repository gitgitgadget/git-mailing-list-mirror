From: martin f krafft <madduck@madduck.net>
Subject: Re: TopGit: how to deal with upstream inclusion
Date: Tue, 23 Sep 2008 08:35:50 +0200
Message-ID: <20080923063550.GC19084@piper.oerlikon.madduck.net>
References: <20080914203043.GA4872@lapse.rw.madduck.net> <20080914210316.GJ10360@machine.or.cz> <20080919170406.GA22849@lapse.rw.madduck.net> <20080921141924.GI10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 08:48:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki1hA-000744-SG
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 08:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbYIWGrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 02:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbYIWGrA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 02:47:00 -0400
Received: from clegg.madduck.net ([193.242.105.96]:45868 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbYIWGq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 02:46:59 -0400
X-Greylist: delayed 658 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Sep 2008 02:46:59 EDT
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id BB3171D40B0;
	Tue, 23 Sep 2008 08:35:51 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id A3CD79F207;
	Tue, 23 Sep 2008 08:35:50 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 49EE944B0; Tue, 23 Sep 2008 08:35:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080921141924.GI10360@machine.or.cz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94/8314/Tue Sep 23 02:50:20 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96527>


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Petr Baudis <pasky@suse.cz> [2008.09.21.1619 +0200]:
> > Yes, it does. One might want to consider to make the use of -s ours
> > in (iiii) configurable, but otherwise that's it.
>=20
> That might be pretty dangerous, since then your topic branch will have
> outstanding branches of the retired branch, but they will _NOT_ be
> visible to tg patch and others since they will be in both the base and
> head.

Well, but what if upstream implemented our solution slightly
differently, and if it's only because they used tabs instead of
spaces? We wouldn't want -s ours then, huh?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"on the other hand, with the advent of msvc 5, i can claim i use
 emacs because it's smaller and more efficient." :-)"
                                                    -- darin johnson
=20
spamtraps: madduck.bogus@madduck.net

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjYjkYACgkQIgvIgzMMSnXfdACgrVgmxQlVyD3uN0fVERHZxOyy
IpQAoIjMuFnRKDJfQHddDz4C/JB8gWNB
=l7dn
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
