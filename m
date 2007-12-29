From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: generated HTML contains broken links
Date: Sat, 29 Dec 2007 16:57:05 +0100
Message-ID: <20071229155705.GA23659@genesis.frugalware.org>
References: <87sl1mqt10.fsf@offby1.atm01.sea.blarg.net> <4775B87D.4010507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BtNCO5h84ExDStzY"
Cc: Dan McGee <dpmcgee@gmail.com>, Eric Hanchrow <offby1@blarg.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 16:57:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8e49-0006uL-TA
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 16:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbXL2P5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 10:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884AbXL2P5J
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 10:57:09 -0500
Received: from virgo.iok.hu ([193.202.89.103]:31606 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871AbXL2P5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 10:57:07 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 134341B253F;
	Sat, 29 Dec 2007 16:57:06 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 64C7C541E3;
	Sat, 29 Dec 2007 16:55:37 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 87A10176C03D; Sat, 29 Dec 2007 16:57:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4775B87D.4010507@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69317>


--BtNCO5h84ExDStzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 28, 2007 at 09:01:17PM -0600, Dan McGee <dpmcgee@gmail.com> wro=
te:
> Generated man pages from Junio:
> HOOKS
>        This command can run commit-msg, pre-commit, and post-commit hooks=
=2E See
>        [1]hooks for more information.
>=20
> SEE ALSO
>        git-add(1), git-rm(1), git-mv(1), git-merge(1), git-commit-tree(1)
>=20
> AUTHOR
>        Written by Linus Torvalds <torvalds@osdl.org> and Junio C Hamano
>        <junkio@cox.net>
>=20
> GIT
>        Part of the git(7) suite
>=20
> Man pages generated locally (with Asciidoc 8.2.3 or 8.2.5):
> HOOKS
>        This command can run commit-msg, pre-commit, and post-commit hooks=
=2E See
>        hooks[5] for more information.
>=20
> SEE ALSO
>        git1[1], git1[2], git1[8], git1[6], git1[9]
>=20
> AUTHOR
>        Written by Linus Torvalds <torvalds@osdl.org> and Junio C Hamano
>        <junkio@cox.net>
>=20
> GIT
>        Part of the git7[10] suite

http://code.toofishes.net/gitweb.cgi?p=3Dpacman.git;a=3Dcommitdiff;h=3Db3c6=
bdda38f7e370e1f80f02a61f1d3f08c1b57d

here is the commit that fixed the problem for pacman. what do you think,
should we rename gitlink to something else, too - or should we contact
upstream to notify them about they caused a breakage?

thanks,
- VMiklos

--BtNCO5h84ExDStzY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHdm5Re81tAgORUJYRAhWMAJ9BlHjH2EcEonGHgQfTsJVWl/ehPQCgoX04
SfigoSxmq0Rnwo737uJvXiM=
=zCpr
-----END PGP SIGNATURE-----

--BtNCO5h84ExDStzY--
