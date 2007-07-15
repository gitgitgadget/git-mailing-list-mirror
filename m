From: VMiklos <vmiklos@frugalware.org>
Subject: Re: question about git-submodule
Date: Sun, 15 Jul 2007 12:54:50 +0200
Message-ID: <20070715105450.GD7106@genesis.frugalware.org>
References: <20070713214630.GB7106@genesis.frugalware.org> <20070715083959.GC999MdfPADPa@greensroom.kotnet.org> <20070715104712.GF2568@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 12:55:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA1l2-0005GG-5H
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 12:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757887AbXGOKzB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 06:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757956AbXGOKzB
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 06:55:01 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58136 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757806AbXGOKzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 06:55:00 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1IA1ke-00034M-49
	from <vmiklos@frugalware.org>; Sun, 15 Jul 2007 12:54:58 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DF5BC176813C; Sun, 15 Jul 2007 12:54:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070715104712.GF2568@steel.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0002]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52542>


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Na Sun, Jul 15, 2007 at 12:47:12PM +0200, Alex Riesen <raa.lkml@gmail.com> pisal(a):
> to. Subprojects defined in such a loosely way are more flexible then
> having git-pull fetch subprojects by default. Sometimes I even want be
> _sure_ the subprojects are completely untouched (I have some critical
> parts in them).

Okay, but where can you overwrite that default? It would be nice to have
a config variable for this or something like that.

thanks,
- VMiklos

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGmfz6e81tAgORUJYRAhJjAJ46bNYII+D3d+gkjIrcXzoZRSNcyQCfRc8E
h0kmonUnmTRxQHAkeY7VtjE=
=Ne3r
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
