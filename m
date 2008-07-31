From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git help broken
Date: Thu, 31 Jul 2008 02:04:54 +0200
Message-ID: <20080731000454.GJ32057@genesis.frugalware.org>
References: <C0DB03B0-8AF5-4B6A-A9DB-16608128EB31@sb.org> <alpine.LSU.1.00.0807310141060.3486@wbgn129.biozentrum.uni-wuerzburg.de> <alpine.LSU.1.00.0807310144040.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="akMXfqh91nV0ynIx"
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 31 02:06:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOLgU-0004XK-IL
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 02:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759710AbYGaAE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 20:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758359AbYGaAE6
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 20:04:58 -0400
Received: from virgo.iok.hu ([193.202.89.103]:38542 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756887AbYGaAE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 20:04:57 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 73B251B24FE;
	Thu, 31 Jul 2008 02:04:55 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B98EA4465E;
	Thu, 31 Jul 2008 01:19:24 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C55AC1190A16; Thu, 31 Jul 2008 02:04:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0807310144040.3486@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90881>


--akMXfqh91nV0ynIx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2008 at 01:44:36AM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > And from the patch, it is pretty obvious that it does not come close to=
=20
> > the "man" code path.
>=20
> Oh, so it was involved?

Yes. The command list is no longer loaded automatically and the default
for non-git commands on git help foo was 'gitfoo', I guess for
gittutorial and such manpages.

--akMXfqh91nV0ynIx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiRAaYACgkQe81tAgORUJaZmwCgg5kR0ouloOq62CBL+wG308Vq
Qg0Ani/Slk7vUrNuatJCcrNLg9/eXpaO
=UIeb
-----END PGP SIGNATURE-----

--akMXfqh91nV0ynIx--
