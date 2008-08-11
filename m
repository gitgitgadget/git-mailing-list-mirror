From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-revert.c: Make use of merge_recursive()
Date: Mon, 11 Aug 2008 21:09:24 +0200
Message-ID: <20080811190924.GR18960@genesis.frugalware.org>
References: <cover.1218374062.git.vmiklos@frugalware.org> <1218467003-14591-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0808111737270.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080811190123.GA14413@leksak.fem-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="egxrhndXibJAPJ54"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:10:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScmW-0004Yk-C1
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbYHKTJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753784AbYHKTJN
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:09:13 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60534 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752978AbYHKTJL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:09:11 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 332B01B251A;
	Mon, 11 Aug 2008 21:09:10 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8570E4465E;
	Mon, 11 Aug 2008 20:17:16 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 60B3E1190002; Mon, 11 Aug 2008 21:09:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080811190123.GA14413@leksak.fem-net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91978>


--egxrhndXibJAPJ54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 11, 2008 at 09:01:23PM +0200, Stephan Beyer <s-beyer@gmx.net> wrote:
> Well, a good alternative could be to just make the really cool
> make_virtual_commit() function non-static.
> The name could be generic enough. Is it? :-)
> Or perhaps: make_virtual_commit_from_tree().

Given that you can't make virtual commits from commits, tags or blobs, I
think the name "as is" generic enough.

--egxrhndXibJAPJ54
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEARECAAYFAkigjmQACgkQe81tAgORUJZCYQCfTbEs0NPZOgTWhoAWqTU//C6m
T7wAmNbrAnacjbC+Sl1fKfGOBGb/z0I=
=YUQu
-----END PGP SIGNATURE-----

--egxrhndXibJAPJ54--
