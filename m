From: martin f krafft <madduck@madduck.net>
Subject: Re: [TopGit] Multiple concurrent sets of patches
Date: Tue, 3 Mar 2009 14:03:16 +0100
Message-ID: <20090303130316.GA17702@piper.oerlikon.madduck.net>
References: <20090303113741.GO12820@jones.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
To: Jonas Smedegaard <dr@jones.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 14:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeUJI-0005DU-4Q
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 14:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZCCNDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 08:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbZCCNDi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 08:03:38 -0500
Received: from clegg.madduck.net ([193.242.105.96]:40874 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbZCCNDh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 08:03:37 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 4CAF01D40EA;
	Tue,  3 Mar 2009 14:03:18 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id 078F39F166;
	Tue,  3 Mar 2009 14:03:17 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id B4B7F446D; Tue,  3 Mar 2009 14:03:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090303113741.GO12820@jones.dk>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9065/Tue Mar  3 11:43:41 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112070>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Jonas Smedegaard <dr@jones.dk> [2009.03.03.1237 +0100]:
> It seems to me that TopGit is incapable of handling this. That it can=20
> only handle patchset against a single branch, and if the need arise for=
=20
> restructuring an additional patchset for e.g. a stable or oldstable=20
> branch, then quilt needs to be used manually anyway.

Let me try to understand you: you want TopGit to maintain a single
feature branch against two different source branches? How should
that work? Could you elaborate a bit so that your needs become a bit
more obvious?

Thanks,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"i feel sorry for people who don't drink. when they wake up in the
 morning, that's as good as they're going to feel all day."
                                                    -- frank sinatra
=20
spamtraps: madduck.bogus@madduck.net

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmtKpQACgkQIgvIgzMMSnUnWgCg5kAAcRFzH1IYXY/Nx044wZ8x
X/4AnAvEHLlyvhJ2Srf33/cU0cTM7kbd
=Kp4E
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
