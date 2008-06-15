From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Documentation: Note about the meaning of "clone"
Date: Sun, 15 Jun 2008 21:12:08 +0200
Message-ID: <20080615191208.GS29404@genesis.frugalware.org>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz> <m3od63ozuf.fsf@localhost.localdomain> <200806151505.27686.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UwhIHqzQuFJjliyU"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Vaclav Hanzl <hanzl@noel.feld.cvut.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 21:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7xfZ-0001Kw-V0
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 21:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbYFOTMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 15:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbYFOTMN
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 15:12:13 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50696 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbYFOTMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 15:12:12 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 30BD21B2530;
	Sun, 15 Jun 2008 21:12:11 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2A8AC44668;
	Sun, 15 Jun 2008 20:52:11 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A37C81770022; Sun, 15 Jun 2008 21:12:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200806151505.27686.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85108>


--UwhIHqzQuFJjliyU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 15, 2008 at 03:05:27PM +0200, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> +*NOTE*: Although this command is called clone, the clone is not identical
> +in all respects. Local branches in the repository being cloned
> +becomes remote tracking branches in the clone and remote tracking
> +branches are not cloned at all. For security reasone the config sections
> +and triggers are not cloned either.

s/triggers/hooks/?

--UwhIHqzQuFJjliyU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhVaYgACgkQe81tAgORUJbeowCfYU8PlODyPo64n+DDpaa55wt4
C0UAoJF2xsGsLupUFwtimFofNrFdk8Fp
=3+g4
-----END PGP SIGNATURE-----

--UwhIHqzQuFJjliyU--
