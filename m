From: VMiklos <vmiklos@frugalware.org>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 15:54:53 +0200
Message-ID: <20070715135453.GE7106@genesis.frugalware.org>
References: <20070713214630.GB7106@genesis.frugalware.org> <20070715083959.GC999MdfPADPa@greensroom.kotnet.org> <20070715104712.GF2568@steel.home> <20070715105450.GD7106@genesis.frugalware.org> <20070715135057.GI2568@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 15:55:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA4Z4-0003T3-2e
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 15:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbXGONzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 09:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbXGONzG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 09:55:06 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47195 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753689AbXGONzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 09:55:05 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IA4Yt-0007X3-9c
	from <vmiklos@frugalware.org>; Sun, 15 Jul 2007 15:55:02 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2E184176813C; Sun, 15 Jul 2007 15:54:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070715135057.GI2568@steel.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=BAYES_50,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52554>


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Na Sun, Jul 15, 2007 at 03:50:57PM +0200, Alex Riesen <raa.lkml@gmail.com> =
pisal(a):
> It is not a default in a sense where it control the behaviour of a git
> command. git pull just does not do anything to subprojects and you use
> a separate command (git-submodule update, I believe) to update them.
>=20
> That said, I never used the git-submodule, nor did I have an urge to.

that's what i asked originally :) i believed that one is supposed to use
git-submodule update to pull each submodule, but it does not seems to
do so. my question is still about if it is possible to pull each
submodule using a single command

thanks,
- VMiklos

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGmicte81tAgORUJYRAqG6AJ0VTY0ItvHDVAqvJrWOkREr3st4VACfaD5F
v1bKxp01ylUmIqrkpCv9agU=
=t2th
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
