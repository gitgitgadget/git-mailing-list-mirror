From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Git Notes - Track rebase/etc + reverse-lookup for bugs ideas
Date: Mon, 10 Nov 2008 21:34:37 +0100
Message-ID: <20081110203437.GW24201@genesis.frugalware.org>
References: <6A0F154C-B9FE-4770-BF70-82A5BEBF907C@gmail.com> <alpine.DEB.1.00.0811102049460.30769@pacific.mpi-cbg.de> <20081110195120.GA3688@sigill.intra.peff.net> <200811102101.15285.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wFcEkHhPyqONlKAq"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Harning <harningt@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:36:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzdUQ-0000ZQ-C6
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbYKJUel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbYKJUel
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:34:41 -0500
Received: from virgo.iok.hu ([193.202.89.103]:35848 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753435AbYKJUej (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:34:39 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 126A858095;
	Mon, 10 Nov 2008 21:34:38 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A1C5C4465E;
	Mon, 10 Nov 2008 21:34:37 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8F23C119019E; Mon, 10 Nov 2008 21:34:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200811102101.15285.johan@herland.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100563>


--wFcEkHhPyqONlKAq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2008 at 09:01:15PM +0100, Johan Herland <johan@herland.net>=
 wrote:
> Does it make sense to teach "git rebase" the -x option from "git=20
> cherry-pick"? As with "git cherry-pick -x" it only makes sense to use it =
if=20
> your rebasing from a public branch.

But rebasing a public branch is always something we try to prevent. So
basically -x would be useful only in case the user does what we asked
not to do. ;-)

--wFcEkHhPyqONlKAq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkYmt0ACgkQe81tAgORUJYraACfel3kI7Kzhndw9jft65aW+BMY
sLQAoKmc8OHdL2j1p8pQwXPooZt0tPup
=CWPS
-----END PGP SIGNATURE-----

--wFcEkHhPyqONlKAq--
