From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-walkthrough-add script
Date: Sat, 5 Jan 2008 02:00:11 +0100
Message-ID: <20080105010011.GV29972@genesis.frugalware.org>
References: <1199426431-sup-6092@south> <2CC98B8C-CBB1-4C26-8C94-B152A4D02DDC@simplicidade.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8N5nZmKALFZnI1Hj"
Cc: William Morgan <wmorgan-git@masanjin.net>,
	Git Mailing List <git@vger.kernel.org>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 02:00:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAxPA-0005OT-Ff
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 02:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbYAEBAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 20:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbYAEBAQ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 20:00:16 -0500
Received: from virgo.iok.hu ([193.202.89.103]:44683 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332AbYAEBAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 20:00:14 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 09BB91B2510;
	Sat,  5 Jan 2008 02:00:13 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C69514465C;
	Sat,  5 Jan 2008 01:58:37 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id EFB2F11904E2; Sat,  5 Jan 2008 02:00:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2CC98B8C-CBB1-4C26-8C94-B152A4D02DDC@simplicidade.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69623>


--8N5nZmKALFZnI1Hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2008 at 11:26:41PM +0000, Pedro Melo <melo@simplicidade.org=
> wrote:
> Maybe I'm doing something wrong, but comparing git-add -p with your scrip=
t,=20
> git-add -p is more darcs'ish. With git-add, if I have several changes in=
=20
> the same file, I get to choose per hunk.

hm, if you want a darcs-like record interface.. darcs record asks you if
you want to include a newly added file in a commit or not,
git-walkthrough-add won't do so :s

you might want to have a look at dg record
(http://git.frugalware.org/repos/pacman-tools/darcs-git.py) which does
this for you.

- VMiklos

--8N5nZmKALFZnI1Hj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHftabe81tAgORUJYRAgJGAJ9LHgOJWLqf0YQwc9axURJRFDes1gCeO9nm
4usxcxs5VhAAiwSaWX3kqgo=
=cHzj
-----END PGP SIGNATURE-----

--8N5nZmKALFZnI1Hj--
