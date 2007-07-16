From: VMiklos <vmiklos@frugalware.org>
Subject: Re: question about git-submodule
Date: Mon, 16 Jul 2007 13:07:28 +0200
Message-ID: <20070716110728.GQ7106@genesis.frugalware.org>
References: <20070715135453.GE7106@genesis.frugalware.org> <20070715140244.GF999MdfPADPa@greensroom.kotnet.org> <20070715142624.GF7106@genesis.frugalware.org> <20070715144835.GI999MdfPADPa@greensroom.kotnet.org> <20070715150540.GH7106@genesis.frugalware.org> <20070715152101.GJ999MdfPADPa@greensroom.kotnet.org> <20070715154028.GI7106@genesis.frugalware.org> <20070715214530.GK999MdfPADPa@greensroom.kotnet.org> <20070715222948.GL7106@genesis.frugalware.org> <20070716103954.GM999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="THYEXwetZJOK3OLY"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Jul 16 13:07:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAOQi-0007FB-Lc
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 13:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565AbXGPLHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 07:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756287AbXGPLHj
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 07:07:39 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:47831 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755738AbXGPLHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 07:07:38 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1IAOQQ-0002Ey-6E
	from <vmiklos@frugalware.org>; Mon, 16 Jul 2007 13:07:37 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 108531868213; Mon, 16 Jul 2007 13:07:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070716103954.GM999MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52661>


--THYEXwetZJOK3OLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Na Mon, Jul 16, 2007 at 12:39:55PM +0200, Sven Verdoolaege <skimo@kotnet.or=
g> pisal(a):
> No.  You have to specify the specific revision of the subproject
> that is included in any revision of the superproject.
>=20
> Imagine someone making an incompatible change to a subproject.
> You do not want to get this change in your copy of the superproject
> unless the superproject has been adapted to this change.

i don't say that the ability to stick to a given commit is bad, but imho
there are scenarios where the ability to stick to a branch is better

ok, i know, probably i should send a patch if i want this, then it can
be discussed if this is useful or not

anyway thanks for all your answers, now i at least know that what i
wanted is currently not supported :)

- VMiklos

--THYEXwetZJOK3OLY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGm1Fwe81tAgORUJYRAlUIAJ9/ZLx6duG28R904bTYo9SLn6tnBACeJ+9n
ln1/4GZkJAHOIT7gEcDz3ow=
=Dqnd
-----END PGP SIGNATURE-----

--THYEXwetZJOK3OLY--
