From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Fri, 27 Apr 2012 10:25:59 +0200
Message-ID: <20120427082559.GC4023@login.drsnuggles.stderr.nl>
References: <20120426183634.GA4023@login.drsnuggles.stderr.nl> <1335468843-24653-1-git-send-email-matthijs@stdin.nl> <20120427082118.GA7257@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7jqT8Da4nx9Bbawl"
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 10:26:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNgVM-00032y-9r
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 10:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946Ab2D0I0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 04:26:11 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:44091 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab2D0I0H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 04:26:07 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1SNgV5-0007V2-VS; Fri, 27 Apr 2012 10:26:00 +0200
Received: (nullmailer pid 28829 invoked by uid 1000);
	Fri, 27 Apr 2012 08:25:59 -0000
Mail-Followup-To: Eric Wong <normalperson@yhbt.net>,
	Gustav Munkby <grddev@gmail.com>, Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20120427082118.GA7257@dcvr.yhbt.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196454>


--7jqT8Da4nx9Bbawl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > On Linux, this makes authentication using passwords from gnome-keyring
> > and kwallet work (only the former was tested). On Mac OS X, this allows
> > using the OS X Keychain.
Signed-off-by: Matthijs Kooijman <matthijs@stdin.nl>

--7jqT8Da4nx9Bbawl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk+aWBcACgkQz0nQ5oovr7wDkwCeKlQu/ky9SgyNuf6y3vH5+UrZ
F84An0kTCud32/Kolo7Z3upyNyM/dr4z
=G4te
-----END PGP SIGNATURE-----

--7jqT8Da4nx9Bbawl--
