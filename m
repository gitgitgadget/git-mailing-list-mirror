From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: git color in commit editor
Date: Thu, 6 Jan 2011 11:15:31 +0100
Message-ID: <20110106101531.GU3069@login.drsnuggles.stderr.nl>
References: <AANLkTimMZaSW4ZUS60Vo38vyuq-PPqPhGdCVZjFzF2Gs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y+YP6lsTt6PYX/7e"
Cc: git@vger.kernel.org
To: Pavan Savoy <pavan_savoy@sify.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 11:15:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pamse-0002vx-Ez
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 11:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab1AFKPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 05:15:35 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:55260 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab1AFKPe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 05:15:34 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1PamsV-0006B4-U9; Thu, 06 Jan 2011 11:15:32 +0100
Received: (nullmailer pid 23746 invoked by uid 1000);
	Thu, 06 Jan 2011 10:15:31 -0000
Mail-Followup-To: Pavan Savoy <pavan_savoy@sify.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTimMZaSW4ZUS60Vo38vyuq-PPqPhGdCVZjFzF2Gs@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164627>


--y+YP6lsTt6PYX/7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Pavan,

> I have git version git version 1.5.6.3, on 1 system and get the colors
> right during a git commit (commit editor being vim..)
> On another machine with same vim version and same gitconfig and pretty
> much all the same settings except that the
> git version is git version 1.6.3.3, I don't have color in the commit editor...
Try the ":syntax on" command in your vim (without the quotes, with the
colon).

You can put it in your ~/.vimrc file as well (without the colon there).

Gr.

Matthijs

--y+YP6lsTt6PYX/7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0llkMACgkQz0nQ5oovr7zTJQCeOW3JmDZHNsH11HTuNXAIBOxb
EFUAoJg9gRv5h5Va8DO+Qbr1GCBCznZc
=PLUj
-----END PGP SIGNATURE-----

--y+YP6lsTt6PYX/7e--
