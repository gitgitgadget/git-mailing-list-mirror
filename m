From: VMiklos <vmiklos@frugalware.org>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 17:05:40 +0200
Message-ID: <20070715150540.GH7106@genesis.frugalware.org>
References: <20070713214630.GB7106@genesis.frugalware.org> <20070715083959.GC999MdfPADPa@greensroom.kotnet.org> <20070715104712.GF2568@steel.home> <20070715105450.GD7106@genesis.frugalware.org> <20070715135057.GI2568@steel.home> <20070715135453.GE7106@genesis.frugalware.org> <20070715140244.GF999MdfPADPa@greensroom.kotnet.org> <20070715142624.GF7106@genesis.frugalware.org> <20070715144835.GI999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 15 17:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA5g4-0004It-RJ
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 17:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758727AbXGOPF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 11:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758711AbXGOPF4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 11:05:56 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:39947 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758665AbXGOPFz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 11:05:55 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IA5fN-0003pR-TM
	from <vmiklos@frugalware.org>; Sun, 15 Jul 2007 17:05:53 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D540E176813C; Sun, 15 Jul 2007 17:05:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070715144835.GI999MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=BAYES_50,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4991]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Na Sun, Jul 15, 2007 at 04:48:35PM +0200, Sven Verdoolaege <skimo@kotnet.org> pisal(a):
> Isn't that what "git submodule update" does ?

i can't get it to work, but here is a log:

http://frugalware.org/~vmiklos/logs/git-submodule.log

at the end of it, git submodule update does not pull anything, while
there are changes both in the main and in the libfoo repo, too

have i missed something?

thanks,
- VMiklos

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGmjfEe81tAgORUJYRAuYAAJ9dc922yJC/DcFefwkMV7phF+VNXACfaSf3
KEHQlZ5y3NjnHCguHQt7YGA=
=T8t6
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
