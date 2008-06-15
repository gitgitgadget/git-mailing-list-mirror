From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Working with Git and CVS in a team.
Date: Sun, 15 Jun 2008 22:34:38 +0200
Message-ID: <20080615203438.GV29404@genesis.frugalware.org>
References: <200806131633.34980.mirko.stocker@hsr.ch> <200806132243.36695.m1stocke@hsr.ch> <20080613204740.GA29404@genesis.frugalware.org> <200806152220.05290.me@misto.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n6qKRb0NPRQAlgau"
Cc: "Stocker Mirko (m1stocke@hsr.ch)" <m1stocke@hsr.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Mirko Stocker <me@misto.ch>
X-From: git-owner@vger.kernel.org Sun Jun 15 22:35:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7ywq-00075k-Rj
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 22:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbYFOUel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 16:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbYFOUel
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 16:34:41 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50834 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbYFOUek (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 16:34:40 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 232851B2530;
	Sun, 15 Jun 2008 22:34:39 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 26B20446A0;
	Sun, 15 Jun 2008 22:14:39 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 69BE11770022; Sun, 15 Jun 2008 22:34:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200806152220.05290.me@misto.ch>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85116>


--n6qKRb0NPRQAlgau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2008 at 10:20:05PM +0200, Mirko Stocker <me@misto.ch> wrote:
> Hm, git-cvsimport created a master and an origin branch. And then I push =
the=20
> origin branch to the bare repository to share it with my colleagues. So f=
or=20
> the users, origin/origin contains the original CVS content, so we need to=
=20
> make the diff against that, don't we? That's how I think this whole thing=
=20
> works, I might be wrong :-)

Oh, you are right. Sorry for the noise. I forgot that git-cvsimport
creates an origin branch without -o master.

--n6qKRb0NPRQAlgau
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhVfN4ACgkQe81tAgORUJa8pgCfYhWMyGCqZakpTi/BSjY+R3wh
siAAnjmJEbwg9USc67YPW7KsPtNppvAQ
=FMlT
-----END PGP SIGNATURE-----

--n6qKRb0NPRQAlgau--
