From: VMiklos <vmiklos@frugalware.org>
Subject: Re: [PATCH] Document the -p option for git-show.
Date: Tue, 21 Aug 2007 16:29:15 +0200
Message-ID: <20070821142915.GI768@genesis.frugalware.org>
References: <46C97D26.9090102@brefemail.com> <20070821124949.GH768@genesis.frugalware.org> <46CAE41C.4614FDF4@eudaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 16:46:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INV0F-00020q-Nz
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 16:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758372AbXHUOqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 10:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758294AbXHUOqj
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 10:46:39 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41669 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757253AbXHUOqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 10:46:39 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1INV06-00048y-LH
	from <vmiklos@frugalware.org>; Tue, 21 Aug 2007 16:46:37 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1962A13A4050; Tue, 21 Aug 2007 16:29:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46CAE41C.4614FDF4@eudaptics.com>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.0
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.0 required=5.9 tests=BAYES_50 autolearn=no SpamAssassin version=3.0.3
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56297>


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Na Tue, Aug 21, 2007 at 03:09:48PM +0200, Johannes Sixt <J.Sixt@eudaptics.c=
om> pisal(a):
> This is already documented by referencing git-diff-tree a few lines
> above:
>=20
> 	The command takes options applicable to the git-diff-tree[1]
> 	command to control how the changes the commit introduces are
> 	shown.
> (..)
> Side note: -p is the default for git-show (of commits). Nevertheless, it
> makes sense to specify it in combination with other options:
>=20
> 	git show -p --stat
>=20
> will show both the patch and the statistics.

Hm, but -p is used by default for git show, right? And this is not
documented anywhere IMHO. (Maybe other options are used by default,
too?)

- VMiklos

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGyva7e81tAgORUJYRAoRdAJ9USiDuXFshcYzyJsorcP5U864FkwCfVKCA
vsQV2fH7m9GOXKN2k56tuBk=
=3pt3
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--
