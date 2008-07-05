From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: About -X<option>
Date: Sat, 5 Jul 2008 15:32:45 +0200
Message-ID: <20080705133245.GH4729@genesis.frugalware.org>
References: <alpine.DEB.1.00.0807051454060.3334@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xtcA6s3naMKOsC7S"
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 05 15:33:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF7ta-0001q7-A0
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 15:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbYGENcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 09:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbYGENcs
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 09:32:48 -0400
Received: from virgo.iok.hu ([193.202.89.103]:59431 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbYGENcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 09:32:47 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E09B61B2510;
	Sat,  5 Jul 2008 15:32:45 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4E8E744698;
	Sat,  5 Jul 2008 15:01:39 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 52C1A11901F1; Sat,  5 Jul 2008 15:32:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807051454060.3334@eeepc-johanness>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87445>


--xtcA6s3naMKOsC7S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 05, 2008 at 02:57:12PM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> So, how about using this syntax instead?
>=20
> 	git pull -s recursive,theirs
>=20
> i.e. strategy terms consist of the strategy name, optionally followed by =
a=20
> comma separated list of backend options.

As a user I would think that it tells git-merge to first try 'recursive'
then 'theirs'.

Of course you can still say that users should read the documentation,
but... ;-)

--xtcA6s3naMKOsC7S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhvd/0ACgkQe81tAgORUJbtMgCeJMwyzpiS1q8N1VGp4ZDeSgHP
mR0An2r9iQf5TcH5PWluRvfR3S56FsVG
=S4MT
-----END PGP SIGNATURE-----

--xtcA6s3naMKOsC7S--
