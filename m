From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Documentation: clarify that git-commit only works with
	tracked files
Date: Thu, 7 Aug 2008 13:00:12 +0200
Message-ID: <20080807110012.GB32057@genesis.frugalware.org>
References: <Pine.GSO.4.62.0808061603340.18817@harper.uchicago.edu> <20080806214747.GY32057@genesis.frugalware.org> <Pine.GSO.4.62.0808061725450.21683@harper.uchicago.edu> <Pine.GSO.4.62.0808061906490.24977@harper.uchicago.edu> <alpine.DEB.1.00.0808070239120.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9NFS5F7jEaHe1OsN"
Cc: Jonathan Nieder <jrnieder@uchicago.edu>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 07 14:50:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR4we-00085S-Co
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 14:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbYHGMtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 08:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYHGMtP
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 08:49:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36121 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbYHGMtP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 08:49:15 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 99D801B2529;
	Thu,  7 Aug 2008 13:00:12 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7D4464465E;
	Thu,  7 Aug 2008 12:10:28 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2C9B111901EE; Thu,  7 Aug 2008 13:00:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808070239120.9611@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91577>


--9NFS5F7jEaHe1OsN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2008 at 02:39:59AM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> Funny.  I haven't used CVS for a while now, but I seem to remember that=
=20
> "cvs commit newfile.c" without a prior "cvs add newfile.c" is not allowed.

But there is a difference. In most VCSes, you need 'add' once. In git
you need add before every commit. Of course this should be clear after
reading the "How to make a commit" part of the user manual.

--9NFS5F7jEaHe1OsN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkia1bwACgkQe81tAgORUJZIHgCgoo/RSAIfbZbsVB1xhkhnaFAr
m9oAn1gbEnT4EdTZfWlaRRIUPmC2jOi4
=jp2N
-----END PGP SIGNATURE-----

--9NFS5F7jEaHe1OsN--
