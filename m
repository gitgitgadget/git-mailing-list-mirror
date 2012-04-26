From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: git-svn won't remember pem password
Date: Thu, 26 Apr 2012 20:36:34 +0200
Message-ID: <20120426183634.GA4023@login.drsnuggles.stderr.nl>
References: <E56535F6-2C9B-4D14-A88F-2471E34D2769@gmail.com> <20120219013011.GB31886@dcvr.yhbt.net> <20120426180018.GX4023@login.drsnuggles.stderr.nl> <41A093CB-CA4A-4FEF-9F5C-A9B626D10AFB@gmail.com> <20120426181327.GZ4023@login.drsnuggles.stderr.nl> <761A0E26-E2CB-4D50-8F7A-C562A929A372@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MiVqRLlIC2csOnh8"
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Igor <mrigor83@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 20:37:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNTYk-0005R9-SG
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 20:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757939Ab2DZSgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 14:36:39 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:47303 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab2DZSgi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 14:36:38 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1SNTYQ-0004Ea-Bp; Thu, 26 Apr 2012 20:36:35 +0200
Received: (nullmailer pid 16276 invoked by uid 1000);
	Thu, 26 Apr 2012 18:36:34 -0000
Mail-Followup-To: Igor <mrigor83@gmail.com>,
	Gustav Munkby <grddev@gmail.com>, Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <761A0E26-E2CB-4D50-8F7A-C562A929A372@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196389>


--MiVqRLlIC2csOnh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Igor,

> Nice, that seems to work. I got prompted to allow access to my KeyChain.
Thanks for the quick testing!

Eric, I'll send the patches in a minute.

Gr.

Matthijs

--MiVqRLlIC2csOnh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk+ZlbIACgkQz0nQ5oovr7wcAgCfauj+1NYyb4hJRbW55b8t1VC5
v4MAnjSlrySvZn53AZZl6VlC6D8mMLGn
=GVxK
-----END PGP SIGNATURE-----

--MiVqRLlIC2csOnh8--
