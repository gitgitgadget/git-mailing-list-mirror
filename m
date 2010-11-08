From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Understanding and improving --word-diff
Date: Mon, 8 Nov 2010 16:49:03 +0100
Message-ID: <20101108154903.GH22067@login.drsnuggles.stderr.nl>
References: <20101108151601.GF22067@login.drsnuggles.stderr.nl> <vpqlj53zuum.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SErirU2W1OYG1ufX"
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Nov 08 16:49:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFTy5-0006ND-L1
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 16:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab0KHPtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 10:49:07 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:38542 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab0KHPtG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 10:49:06 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1PFTxv-00053M-I6; Mon, 08 Nov 2010 16:49:04 +0100
Received: (nullmailer pid 19423 invoked by uid 1000);
	Mon, 08 Nov 2010 15:49:03 -0000
Mail-Followup-To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <vpqlj53zuum.fsf@bauges.imag.fr>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160945>


--SErirU2W1OYG1ufX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthieu,

> There's a pending patch for "gitk --color-words". Actually, the
> porcelain format was precisely implemented to allow this patch to
> exist IIRC.
I think you mean this patch?

[PATCH v4' 2/2] gitk: add the equivalent of diff --color-words
https://kerneltrap.org/mailarchive/git/2010/4/19/28707

I had seen it around, but hadn't realized it wasn't in master yet. I'll
have a closer look at it.

Thanks.

Matthijs

--SErirU2W1OYG1ufX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzYG+8ACgkQz0nQ5oovr7yLNQCgu4yR7paZlKyriNjpl0gjn9gb
nSsAoMltxNzOtoR5ruxbzmZzvb6XKxmm
=Zadc
-----END PGP SIGNATURE-----

--SErirU2W1OYG1ufX--
