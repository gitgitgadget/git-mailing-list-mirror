From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git pull manpage: don't include -n from
	fetch-options.txt
Date: Fri, 25 Jan 2008 23:13:56 +0100
Message-ID: <20080125221356.GJ4475@genesis.frugalware.org>
References: <72481CA3A5A6474EA49CFD2CF28A5D5D02CA348A@hektor.iplbath.com> <alpine.LSU.1.00.0801241058330.5731@racer.site> <20080124232418.GC4475@genesis.frugalware.org> <7vfxwm8z4u.fsf@gitster.siamese.dyndns.org> <20080125092839.GF4475@genesis.frugalware.org> <alpine.LSU.1.00.0801251016170.5731@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sKosZo66cxuwvnFI"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 25 23:14:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIWow-0005lT-RY
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 23:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbYAYWOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 17:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbYAYWOP
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 17:14:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41183 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266AbYAYWOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 17:14:14 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JIWoE-0003gu-It
	from <vmiklos@frugalware.org>; Fri, 25 Jan 2008 23:14:13 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5FB3C176C045; Fri, 25 Jan 2008 23:13:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801251016170.5731@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.1 required=5.9 tests=BAYES_05 autolearn=no SpamAssassin version=3.2.3
	-1.1 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0113]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71744>


--sKosZo66cxuwvnFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2008 at 10:17:38AM +0000, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> [jes: reworded the description to avoid mentioning 'git-fetch';
>  also exclude '-n' conditional on git-pull -- ugly because of
>  the missing "else" statement in asciidoc]

right, i should have noticed that we should not include git-fetch in the
git pull manpage :)

thanks,
- VMiklos

--sKosZo66cxuwvnFI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHml8ke81tAgORUJYRAnCwAJ9RM5CBTFjEb0hHRiCpZBHC4b8rFwCeORtg
OkyRqcQRr9wGbwwNgxJBN3g=
=2scQ
-----END PGP SIGNATURE-----

--sKosZo66cxuwvnFI--
