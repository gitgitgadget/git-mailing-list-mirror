From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-svn branch naming question
Date: Sat, 8 Dec 2007 15:14:49 +0100
Message-ID: <20071208141449.GH3199@genesis.frugalware.org>
References: <20071208010438.GE3199@genesis.frugalware.org> <20071208105901.GA2844@xp.machine.xx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 08 15:15:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J10SX-0000kS-LL
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 15:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbXLHOOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 09:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbXLHOOw
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 09:14:52 -0500
Received: from virgo.iok.hu ([193.202.89.103]:38753 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbXLHOOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 09:14:51 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2670B1B2502;
	Sat,  8 Dec 2007 15:14:50 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C648C4465C;
	Sat,  8 Dec 2007 15:13:43 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BF39411904C0; Sat,  8 Dec 2007 15:14:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071208105901.GA2844@xp.machine.xx>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67555>


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 08, 2007 at 11:59:01AM +0100, Peter Baumann <waste.manager@gmx.de> wrote:
> Look up  --prefix in the manpage for git-svn.

great, --prefix is what i missed.

a related question: is it possible to avoid even the "remotes" prefix?

it could be useful when creating an incremental import of an svn repo.
(ie when using git-svn as a replacement of git-svnimport.)

so after the clone, one will see all the svn branches as a remote
branch, since they will be local (and not remote) ones in the mirror
repo.

thanks,
- VMiklos

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHWqbZe81tAgORUJYRAiURAJ9tVIEBf7RYTOntJDxWt/KuuErbTQCfVNd+
AM1sOyw1LN/4OeLZFdl5zD0=
=A3ft
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--
