From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-pull documentation: fix linkgit in the --rebase
	option description.
Date: Mon, 11 Feb 2008 19:29:07 +0100
Message-ID: <20080211182907.GB25954@genesis.frugalware.org>
References: <20080211132800.GV25954@genesis.frugalware.org> <alpine.LSU.1.00.0802111514400.3870@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QHrz2k/ePFTn56xd"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:31:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOdQx-0005NF-RC
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 19:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760182AbYBKS3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 13:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760173AbYBKS33
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 13:29:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:59206 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760159AbYBKS32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 13:29:28 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JOdP4-0007ZH-5L
	from <vmiklos@frugalware.org>; Mon, 11 Feb 2008 19:29:26 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 01D3811904DD; Mon, 11 Feb 2008 19:29:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802111514400.3870@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0053]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73559>


--QHrz2k/ePFTn56xd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2008 at 03:15:31PM +0000, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> The intention was to force a new paragraph.  The *NOTE* should be loud an=
d=20
> clear, so that those few people who read man pages are properly warned=20
> that --rebase is a dangerous option if you do not know what you are doing.

i see your point and i played with it a bit, no success so far. if it
becomes a new paragraph, the linkgit: is not processed. maybe it's an
asciidoc bug?

(is it better to have it as a new paragraph with linkgit: shown? hmm)

thanks,
- VMiklos

--QHrz2k/ePFTn56xd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHsJPze81tAgORUJYRAqmBAJ0bhLZuWjV/x6hpXaivCY0LvU71LwCgi+Ds
pYNxdnEfMxFXdryneJKYGWA=
=JIMn
-----END PGP SIGNATURE-----

--QHrz2k/ePFTn56xd--
