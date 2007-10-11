From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: inexplicable failure to merge recursively across cherry-picks
Date: Thu, 11 Oct 2007 02:08:26 +0200
Message-ID: <20071011000826.GQ23810@genesis.frugalware.org>
References: <20071010015545.GA17336@lapse.madduck.net> <alpine.LFD.0.999.0710091926560.3838@woody.linux-foundation.org> <20071010102528.GB20390@lapse.madduck.net> <alpine.LFD.0.999.0710100808150.3838@woody.linux-foundation.org> <20071010154831.GA19226@old.davidb.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3snK74p7ddXn3Qrx"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 02:09:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iflc2-0003k4-En
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 02:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756999AbXJKAJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 20:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756947AbXJKAJD
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 20:09:03 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51116 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214AbXJKAJB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 20:09:01 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IflbP-0008I5-6e
	from <vmiklos@frugalware.org>; Thu, 11 Oct 2007 02:08:43 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 08EE813A4002; Thu, 11 Oct 2007 02:08:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071010154831.GA19226@old.davidb.org>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.6 required=5.9 tests=BAYES_40,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	0.5 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.2945]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60571>


--3snK74p7ddXn3Qrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ ehh, sorry for my previous mail, i must be doing something wrong.. ]

On Wed, Oct 10, 2007 at 08:48:31AM -0700, David Brown <git@davidb.org> wrote:
> There is a darcs-git project that tries to do the darcs things on top of
> git.

actually it's broken, according to its author:

http://www.mail-archive.com/darcs-users@darcs.net/msg03161.html

though i loved darcs, but yes - it scales horribly

- VMiklos

--3snK74p7ddXn3Qrx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHDWl6e81tAgORUJYRAkDjAJ0SQ9xnB+FUxtc5KF6nHJoko3X4EwCeMcAA
+FOdF+LOIOkJ9Z9TNaqRYwo=
=cK+z
-----END PGP SIGNATURE-----

--3snK74p7ddXn3Qrx--
