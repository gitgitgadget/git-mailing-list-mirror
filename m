From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH 2/2] git-svn: Configure a prompt callback for
	gnome_keyring.
Date: Fri, 27 Apr 2012 10:29:06 +0200
Message-ID: <20120427082905.GD4023@login.drsnuggles.stderr.nl>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl> <1335468843-24653-1-git-send-email-matthijs@stdin.nl> <1335468843-24653-2-git-send-email-matthijs@stdin.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWxI5u/KE+N5O2im"
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 10:29:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNgYS-0006ey-DM
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 10:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759333Ab2D0I3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 04:29:13 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:57037 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759281Ab2D0I3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 04:29:09 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1SNgY6-0007Ya-FP; Fri, 27 Apr 2012 10:29:07 +0200
Received: (nullmailer pid 29047 invoked by uid 1000);
	Fri, 27 Apr 2012 08:29:06 -0000
Mail-Followup-To: Eric Wong <normalperson@yhbt.net>,
	Gustav Munkby <grddev@gmail.com>, Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1335468843-24653-2-git-send-email-matthijs@stdin.nl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196456>


--HWxI5u/KE+N5O2im
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Eric,

just noticed a minor typo in this commit message:

> committed to trunk (1241554 and some followup commits) and should be
I forgot to add an "r" in front of this revision number, so the line
should be:
> committed to trunk (r1241554 and some followup commits) and should be

Not a big deal of course, but slightly more readable.

Gr.

Matthijs

--HWxI5u/KE+N5O2im
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk+aWNEACgkQz0nQ5oovr7x0uQCdGLR2Fu1a0gD8sImEpor7+wMX
UIIAoOXNDO4qB+lhVtTRMxnVfas4Ny4f
=+wuz
-----END PGP SIGNATURE-----

--HWxI5u/KE+N5O2im--
