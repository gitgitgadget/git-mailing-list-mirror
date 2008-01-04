From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git ftp push ?
Date: Fri, 4 Jan 2008 17:32:31 +0100
Message-ID: <20080104163231.GR29972@genesis.frugalware.org>
References: <31e679430801040754m552b7650g50405b6e2e607da9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c2gYorpyS4gG0T74"
Cc: git@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 17:32:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JApTc-000578-Tv
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 17:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbYADQcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 11:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbYADQcd
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 11:32:33 -0500
Received: from virgo.iok.hu ([193.202.89.103]:43844 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412AbYADQcc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 11:32:32 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8BDC11B24FE;
	Fri,  4 Jan 2008 17:32:31 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 98FBD44668;
	Fri,  4 Jan 2008 17:30:56 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0C9E111904E0; Fri,  4 Jan 2008 17:32:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <31e679430801040754m552b7650g50405b6e2e607da9@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69581>


--c2gYorpyS4gG0T74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 04, 2008 at 10:54:16AM -0500, Felipe Balbi <felipebalbi@users.sourceforge.net> wrote:
> how could I issue a git push via ftp ??
> Is that possible ?

at the moment, not. (http push is supported and it's a dumb protocol, so
it would be possible to support ftp but nobody did so)

- VMiklos

--c2gYorpyS4gG0T74
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHfl+ee81tAgORUJYRArwOAJ4mIgrS11qBHIfOpK7u5dgEWAgo/QCeOiB+
Ni4xoP6VG6Tj6Qkzg8z2As8=
=yUF5
-----END PGP SIGNATURE-----

--c2gYorpyS4gG0T74--
