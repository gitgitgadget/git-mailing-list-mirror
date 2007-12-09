From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-svn branch naming question
Date: Sun, 9 Dec 2007 03:36:00 +0100
Message-ID: <20071209023600.GP3199@genesis.frugalware.org>
References: <20071208010438.GE3199@genesis.frugalware.org> <20071208105901.GA2844@xp.machine.xx> <20071208141449.GH3199@genesis.frugalware.org> <20071208165657.GC2844@xp.machine.xx> <20071208235248.GK3199@genesis.frugalware.org> <20071209020510.GM3199@genesis.frugalware.org> <20071209022624.GA31033@soma>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KDy5+/kaQUC2a3Gw"
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Dec 09 03:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1C1t-0006uz-67
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 03:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbXLICgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 21:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbXLICgF
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 21:36:05 -0500
Received: from virgo.iok.hu ([193.202.89.103]:39554 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350AbXLICgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 21:36:03 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9439A1B2511;
	Sun,  9 Dec 2007 03:36:01 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1D61C4465C;
	Sun,  9 Dec 2007 03:34:54 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8EE7A11904C1; Sun,  9 Dec 2007 03:36:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071209022624.GA31033@soma>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67590>


--KDy5+/kaQUC2a3Gw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 08, 2007 at 06:26:24PM -0800, Eric Wong <normalperson@yhbt.net> wrote:
> I'm not sure if it's considered a "bug", but that's just the
> way it is at the moment.  I can't remember why, but I did
> make git-svn force the presence of the "remotes/" prefix
> in all refs it writes to...

okay, i see. one problem: git-svnimport is to be removed and (afaik) the
supposed way is to use git-svn instead. what is the supposed way to use
git-svn to convert an svn repo to a git one if the method i tried is not
working?

(if the branches are fetched to "remotes/" then they won't be visible
when one clones the converted repo)

thanks,
- VMiklos

--KDy5+/kaQUC2a3Gw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHW1SQe81tAgORUJYRAtqQAJ0Zgj54yeyAM8hnvIcr/0xvqAmEkgCfS+oY
E8y81sFvaule0EtFdLh+omU=
=vlXz
-----END PGP SIGNATURE-----

--KDy5+/kaQUC2a3Gw--
