From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: rebase converts merge commits
Date: Tue, 12 Oct 2010 16:58:25 +0200
Message-ID: <20101012145824.GF22067@login.drsnuggles.stderr.nl>
References: <AANLkTikz0yUv9+EcT-kVwniUf9xnRe=_y96euNb=stzP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL7P3nS1KWtdhijB"
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?S=E9bastien_Barth=E9lemy?= <barthelemy@crans.org>
X-From: git-owner@vger.kernel.org Tue Oct 12 16:58:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5gJW-0004Je-26
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 16:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757498Ab0JLO62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 10:58:28 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:47091 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab0JLO61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 10:58:27 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1P5gJ7-0001Mw-4E; Tue, 12 Oct 2010 16:58:25 +0200
Received: (nullmailer pid 5262 invoked by uid 1000);
	Tue, 12 Oct 2010 14:58:25 -0000
Mail-Followup-To: =?iso-8859-1?Q?S=E9bastien_Barth=E9lemy?= <barthelemy@crans.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTikz0yUv9+EcT-kVwniUf9xnRe=_y96euNb=stzP@mail.gmail.com>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158853>


--FL7P3nS1KWtdhijB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi S=E9bastien,

> Yet, I have a problem while trying to rebase a bit of history which conta=
ins
> merge commits.

Have you tried the --preserve-merges option to rebase?

Gr.

Matthijs

--FL7P3nS1KWtdhijB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAky0d5AACgkQz0nQ5oovr7wzJgCeMhzf7XQAYMI5Fjxl87xkcL32
hgIAoMG9nZgO+vOcU7t8jurmLDcRGNOQ
=ptKk
-----END PGP SIGNATURE-----

--FL7P3nS1KWtdhijB--
