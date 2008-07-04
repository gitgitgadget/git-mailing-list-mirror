From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: no --dry-run to git-pull ?
Date: Fri, 4 Jul 2008 17:29:15 +0200
Message-ID: <20080704152915.GD4729@genesis.frugalware.org>
References: <912ec82a0807040656y1c48cba8m6f9981f6bb97b36a@mail.gmail.com> <20080704135944.GA4729@genesis.frugalware.org> <912ec82a0807040826v64afcc55i646d9c73b6fa8cd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sW3EvpYZ43JhLhGX"
Cc: git@vger.kernel.org
To: Neshama Parhoti <pneshama@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 17:30:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEnEq-0005uF-74
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 17:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbYGDP3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 11:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbYGDP3U
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 11:29:20 -0400
Received: from virgo.iok.hu ([193.202.89.103]:56741 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934AbYGDP3T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 11:29:19 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B73CD1B256A;
	Fri,  4 Jul 2008 17:29:15 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 940B84465E;
	Fri,  4 Jul 2008 16:58:40 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 613B011901F2; Fri,  4 Jul 2008 17:29:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <912ec82a0807040826v64afcc55i646d9c73b6fa8cd0@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87398>


--sW3EvpYZ43JhLhGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2008 at 06:26:02PM +0300, Neshama Parhoti <pneshama@gmail.c=
om> wrote:
> > 1) Replace origin and master with your remote and branch.
> >
> > 2) If this sounds cryptic for you, then it might be an important info
> > that by default a pull is a fetch + a merge.
>=20
> What puzzles me is the origin keyword. Is it set only if I initially
> cloned a repo ?
> Because in my case, I have just rsync'ed a repo to another station, so
> I fear it will have no meaning in my case.

Heh. git remote add -f origin <url>, then you'll have it. And yes, you
have it if you cloned the repo, of course rsync won't add it. ;-)

--sW3EvpYZ43JhLhGX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhuQcsACgkQe81tAgORUJbn+gCfSFcxfMhL5PHg0cNWUrZVcThk
iz0An2iqWkfJPALsCZdw5FA9p7BnQyzq
=Ch9l
-----END PGP SIGNATURE-----

--sW3EvpYZ43JhLhGX--
