From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: GIT Packages for Debian Etch
Date: Mon, 18 Jun 2007 22:27:41 +0100
Message-ID: <20070618212741.GA5938@artemis.internal.dc7.debconf.org>
References: <20070618212524.GC16393@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Q68bSM7Ycu6FN28Q";
	protocol="application/pgp-signature"; micalg=SHA1
To: Thomas Glanzmann <thomas@glanzmann.de>, carlo@alinoe.com,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 18 23:28:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Olg-0006iN-Mk
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 23:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762553AbXFRV1r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 17:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764602AbXFRV1r
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 17:27:47 -0400
Received: from pan.madism.org ([88.191.52.104]:42277 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762230AbXFRV1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 17:27:45 -0400
Received: from madism.org (unknown [129.215.255.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 654F3ED86;
	Mon, 18 Jun 2007 23:27:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id EE148E531D; Mon, 18 Jun 2007 22:27:41 +0100 (BST)
Mail-Followup-To: Thomas Glanzmann <thomas@glanzmann.de>, carlo@alinoe.com,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070618212524.GC16393@cip.informatik.uni-erlangen.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50412>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2007 at 11:25:24PM +0200, Thomas Glanzmann wrote:
> Hello,
> a friend of mine always builds the Debian Packages from unstable for
> Debian Etch. I have on all my machines the following line in
> /etc/apt/sources.list:
>=20
>         deb http://rmdir.de/~michael/git/ ./

  FWIW there is even simpler: I maintain a backport on
www.backports.org. Which is a semi-official service driven by Debian
Developers.

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGdvjNvGr7W6HudhwRAj6WAJ9ykN43ePDvw0G5T9fvvQh8bMBUAQCeKrQ4
DrfxIN1mc0wDh4RbLwSdyk4=
=vrbt
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
