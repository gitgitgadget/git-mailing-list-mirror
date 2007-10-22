From: martin f krafft <madduck@madduck.net>
Subject: deprecating colgit
Date: Mon, 22 Oct 2007 16:23:48 +0200
Message-ID: <20071022142348.GA10083@piper.oerlikon.madduck.net>
References: <20070906101115.GA29360@piper.oerlikon.madduck.net> <20070906131525.GA7261@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Cc: home in vcs discussion list <vcs-home@lists.madduck.net>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:48:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjyZx-0002lH-1S
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 16:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbXJVOsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 10:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbXJVOsR
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 10:48:17 -0400
Received: from seamus.madduck.net ([213.203.238.82]:45210 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbXJVOsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 10:48:16 -0400
X-Greylist: delayed 1425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2007 10:48:16 EDT
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTP id 3D5E4402DB6;
	Mon, 22 Oct 2007 16:24:20 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 2C3029F13B;
	Mon, 22 Oct 2007 16:23:49 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id E2E594408; Mon, 22 Oct 2007 16:23:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070906131525.GA7261@piper.oerlikon.madduck.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4559/Mon Oct 22 06:02:57 2007 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62016>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list(s),

I would like to deprecate colgit [0] in favour of Joey Hess' mr [1],
which does everything colgit did, and much more.

0. http://lists.zerezo.com/git/msg629629.html
1. http://kitenet.net/~joey/code/mr/

If you have not seen mr, well, basically it manages collections of
repositories, like colgit aspired to do, but Joey made it
vcs-agnostic and much more robust. It's definitely worth checking
out.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"if a man treats life artistically, his brain is his heart."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHLJ0IgvIgzMMSnURAryNAKCT8oKwCKS7LyoI3KqvZhyUMAcsNgCg7Bs9
ZZvMVukXjL/2/KP2xS8x2aU=
=ES+D
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
