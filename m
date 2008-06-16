From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: Mercurial to git converter.
Date: Mon, 16 Jun 2008 18:21:07 +1000
Message-ID: <20080616082106.GA10583@tull.net>
References: <1168537766.22649.19.camel@localhost.localdomain> <loom.20080614T101342-542@post.gmane.org> <alpine.DEB.1.00.0806141648020.6439@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 16 10:22:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K89z0-0006lC-Go
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 10:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760812AbYFPIV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 04:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755635AbYFPIV2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 04:21:28 -0400
Received: from vps1.tull.net ([66.180.172.116]:48925 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761239AbYFPIV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 04:21:26 -0400
Received: (qmail 28097 invoked by uid 1015); 16 Jun 2008 18:21:22 +1000
Received: from [10.0.0.67] (HELO mail.local.tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Mon, 16 Jun 2008 18:21:22 +1000
Received: (qmail 5509 invoked by uid 1015); 16 Jun 2008 18:21:18 +1000
X-Spam-Status: No, hits=-4.4 required=5.0	tests=ALL_TRUSTED,BAYES_00
X-Spam-Check-By: mail.local.tull.net
Received: from [10.0.0.1] (HELO marcab.local.tull.net) (10.0.0.1)    by mail.local.tull.net (qpsmtpd/0.40) with SMTP; Mon, 16 Jun 2008 18:21:10 +1000
Received: by marcab.local.tull.net (sSMTP sendmail emulation); Mon, 16 Jun 2008 18:21:07 +1000
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806141648020.6439@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85166>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2008 at 04:53:04PM +0100, Johannes Schindelin wrote:
> FWIW I switched my local mercurial2git conversion to the hg-fast-export=
=20
> solution from=20
>=20
> 	git://repo.or.cz/fast-export.git

Yep.

In my case I needed to convert only a single repository with only a
few tens of commits, so the slow script was adequate for my use
=2E.. except for that problem with the changelog messages - which was
trivially fixed, so I posted to the list only to document the fix.

Nick.
--=20
PGP Key ID =3D 0x418487E7                      http://www.nick-andrew.net/
PGP Key fingerprint =3D B3ED 6894 8E49 1770 C24A  67E3 6266 6EB9 4184 87E7

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIViJyYmZuuUGEh+cRAmSiAJ4q5Z7+ECXHXfALwtA3hEC3af4H4gCgqpdz
8FsSEyXT1E4x9NX0iRjtgzo=
=j9xP
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
