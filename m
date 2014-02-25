From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: git submodule manpage does not document --checkout
Date: Tue, 25 Feb 2014 12:03:17 +0100
Message-ID: <20140225110316.GU11566@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZRDC+ooC0woGCz3"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 25 12:31:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIGEW-00036g-5l
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 12:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbaBYLb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 06:31:26 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:60007 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbaBYLbX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 06:31:23 -0500
X-Greylist: delayed 1682 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2014 06:31:22 EST
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1WIFnC-0007k1-04
	for git@vger.kernel.org; Tue, 25 Feb 2014 12:03:18 +0100
Received: (nullmailer pid 29756 invoked by uid 1000);
	Tue, 25 Feb 2014 11:03:17 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242661>


--dZRDC+ooC0woGCz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

it seems git submodule supports --checkout, which is also mentioned
indirectly in the manpage. However, the option itself is not mentioned
in the synopsis or detailed option list.

Gr.

Matthijs

--dZRDC+ooC0woGCz3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlMMeHQACgkQz0nQ5oovr7yjTwCfeQqb5jTVKOcBf+eeWwRO3VEo
/94AnjCesCEfuZS+S9Aiv5TywDodlRlt
=EF9r
-----END PGP SIGNATURE-----

--dZRDC+ooC0woGCz3--
