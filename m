From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Git/Mercurial interoperability (and what about bzr?) (was: Re:
	[VOTE] git versus mercurial)
Date: Tue, 28 Oct 2008 22:10:32 +0100
Message-ID: <20081028211032.GU24201@genesis.frugalware.org>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org> <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se> <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl> <20081028191234.GS24201@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Oct 28 22:11:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kuvqt-0004YS-DX
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 22:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbYJ1VKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 17:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbYJ1VKe
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 17:10:34 -0400
Received: from virgo.iok.hu ([193.202.89.103]:41712 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbYJ1VKd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 17:10:33 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 6EE4D580A7;
	Tue, 28 Oct 2008 22:10:32 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5B80C4465E;
	Tue, 28 Oct 2008 22:10:32 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 456E411901A1; Tue, 28 Oct 2008 22:10:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081028191234.GS24201@genesis.frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99323>


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2008 at 08:12:34PM +0100, Miklos Vajna <vmiklos@frugalware.org> wrote:
> To sum up, I'm not so sure about a working hg fast-import is available
> at the moment.

I wrote too fast.

There is a minimal implementation here:

http://hg.opensource.lshift.net/hg-fastimport/

(I haven't tried it yet myself.)

--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkHf8gACgkQe81tAgORUJZGqwCgp+/8j200nVciIzKDyNHC8OOG
eo8An2T2VZHryN8ERisr9AweQPMcitB0
=X0mq
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--
