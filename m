From: martin f krafft <madduck@madduck.net>
Subject: Re: gitweb: pathinfo feature breaks commitdiff/raw links
Date: Thu, 17 Apr 2008 12:11:18 +0200
Message-ID: <20080417101118.GA26063@piper.oerlikon.madduck.net>
References: <20080417092339.GA17016@piper.oerlikon.madduck.net> <869CFE40-B245-4744-A9D5-0F3FA623633F@wincent.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
To: git discussion list <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 12:12:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmR6E-00074L-Hp
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 12:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757748AbYDQKL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 06:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758057AbYDQKL2
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 06:11:28 -0400
Received: from clegg.madduck.net ([82.197.162.59]:38498 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbYDQKL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 06:11:26 -0400
Received: from wall.oerlikon.madduck.net (84-75-148-163.dclient.hispeed.ch [84.75.148.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id B3D11A86A2;
	Thu, 17 Apr 2008 12:11:19 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 1C04A9F18E;
	Thu, 17 Apr 2008 12:11:19 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id E506EC1756; Thu, 17 Apr 2008 12:11:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <869CFE40-B245-4744-A9D5-0F3FA623633F@wincent.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.91.2/6809/Thu Apr 17 11:33:01 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79782>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Wincent Colaiuta <win@wincent.com> [2008.04.17.1157 +0200]:
> Are you running an older version of gitweb? One which predates 7863c61?

Yes, sorry for not including that information.

piper:~/code/git> git describe 7863c61
v1.5.4.4-10-g7863c61

I run the 1.5.4.2-1 Debian backport.

I assume from your answer that 1.5.4.4 fixes this issue and will
gladly wait.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"they redundantly repeated themselves over and over,
 incessantly without end and ad infinitum"
                                                             -- ibid
=20
spamtraps: madduck.bogus@madduck.net

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIByJGIgvIgzMMSnURAmn+AJ9HE5gsViKFawHzaue09HwUyFk0+QCgwJvn
0dGkozucCNq53WQvcdcLRA4=
=CpwR
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
