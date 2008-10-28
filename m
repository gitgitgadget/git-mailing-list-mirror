From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Git/Mercurial interoperability (and what about bzr?) (was: Re:
	[VOTE] git versus mercurial)
Date: Wed, 29 Oct 2008 00:28:23 +0100
Message-ID: <20081028232823.GX24201@genesis.frugalware.org>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org> <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se> <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl> <20081028191234.GS24201@genesis.frugalware.org> <20081028213144.GC10862@mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DfnuYBTqzt7sVGu3"
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 29 00:29:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kuy0J-00075j-6B
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 00:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbYJ1X2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 19:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbYJ1X2Z
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 19:28:25 -0400
Received: from virgo.iok.hu ([193.202.89.103]:46371 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbYJ1X2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 19:28:25 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 06DD0580B0;
	Wed, 29 Oct 2008 00:28:24 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D15234465E;
	Wed, 29 Oct 2008 00:28:23 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BA1DB119019E; Wed, 29 Oct 2008 00:28:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081028213144.GC10862@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99331>


--DfnuYBTqzt7sVGu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2008 at 05:31:44PM -0400, Theodore Tso <tytso@mit.edu> wrot=
e:
> The code I was referring to was called hg-fast-export, which is part
> of the "fast export" tools that front-end into git fast-import.  The
> git repository can be found here:
>=20
> 	http://repo.or.cz/w/fast-export.git
> 	git://repo.or.cz/fast-export.git
>=20
> I ended up using a very customized version of that script to convert
> the hg e2fsprogs repository to git.

My bad, I did not quote the article properly, so here is what I meant:

http://article.gmane.org/gmane.comp.version-control.git/42298

and I just wanted to say that this one does not use fast-import, so it's
not really a "hg-fast-import" (it's not something that can parse the
output of git-fast-export).

--DfnuYBTqzt7sVGu3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkHoBcACgkQe81tAgORUJYDjACghx9/73BJpcXqxMu+N6OwcE7l
iTAAoJ+PK+I/c/ZEFgMPBMxioSlbsPvA
=4Ubc
-----END PGP SIGNATURE-----

--DfnuYBTqzt7sVGu3--
