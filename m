From: VMiklos <vmiklos@frugalware.org>
Subject: Re: Volume of commits
Date: Thu, 12 Jul 2007 15:29:37 +0200
Message-ID: <20070712132937.GQ19386@genesis.frugalware.org>
References: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+bDoS+V4AJZnUgoC"
Cc: git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 15:29:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yjw-0004eY-FO
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 15:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761428AbXGLN3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 09:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761836AbXGLN3t
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 09:29:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53296 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761164AbXGLN3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 09:29:48 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1I8yjo-0003jV-Ps
	from <vmiklos@frugalware.org>; Thu, 12 Jul 2007 15:29:47 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6D50513A4108; Thu, 12 Jul 2007 15:29:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3ps2xu5hc.fsf@pc7.dolda2000.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0001]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52287>


--+bDoS+V4AJZnUgoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Na Thu, Jul 12, 2007 at 03:16:47PM +0200, Fredrik Tolf <fredrik@dolda2000.com> pisal(a):
> So what I'm wondering is how you people manage to do this? Do you
> actually always commit changes this way (and, in that case, how do you
> switch between branches)? Or do you somehow aggregate the smaller
> commits into larger patches and recommit them? Or is there some third
> possibility that I'm missing?

you can cherry-pick the relevan patches to a separate branch and commit
then at once (cherry-pick -n), or can merge --squash to archive
something similar

- VMiklos

--+bDoS+V4AJZnUgoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGlizBe81tAgORUJYRAgPBAKCUBwjoDzq0X15cMv+aorzhPcAmgQCfZq7B
huw6WlTKqdiPSOI9aLgP4V0=
=/K3m
-----END PGP SIGNATURE-----

--+bDoS+V4AJZnUgoC--
