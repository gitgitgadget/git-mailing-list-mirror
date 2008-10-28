From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Git/Mercurial interoperability (and what about bzr?) (was: Re:
	[VOTE] git versus mercurial)
Date: Tue, 28 Oct 2008 20:12:34 +0100
Message-ID: <20081028191234.GS24201@genesis.frugalware.org>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org> <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se> <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Oct 28 20:14:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kuu1E-0001nL-6c
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 20:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbYJ1TMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 15:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYJ1TMh
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 15:12:37 -0400
Received: from virgo.iok.hu ([193.202.89.103]:38044 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600AbYJ1TMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 15:12:36 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1BED2580C8;
	Tue, 28 Oct 2008 20:12:35 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id EC0514465E;
	Tue, 28 Oct 2008 20:12:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BFC9D11901A1; Tue, 28 Oct 2008 20:12:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99312>


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2008 at 04:33:54PM +0100, Pieter de Bie <pdebie@ai.rug.nl> =
wrote:
> fast-import yet. If I understand dscho correctly, that exists now, so it=
=20
> should be easy enough to integrate that as well.

That's new to me. Theodore Ts'o once mentioned on this list that there
is a "hg fast-export" but actually he just referred to "there is a
git2hg conversion tool in hg's contrib dir" and it has nothing with
fast-import.

There is an other reference to hg fast-import:

http://www.nabble.com/cvs2git-2.1-causes-git-fast-import-to-exit-with-an-er=
ror-td16049922.html

but I found no code so far.

To sum up, I'm not so sure about a working hg fast-import is available
at the moment.

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkHZCIACgkQe81tAgORUJa63wCfZfYlfO8f51tHbo1m/VFbfFSL
5PIAoJMM7pV33QSw2UUj5+BZcBLI/w3/
=FqVt
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
