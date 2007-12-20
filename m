From: Andrew McMillan <andrew@catalyst.net.nz>
Subject: Re: Git-to-svn convert
Date: Thu, 20 Dec 2007 18:32:01 +1300
Organization: Catalyst .Net Ltd
Message-ID: <1198128721.24580.78.camel@hippy.mcmillan.net.nz>
References: <476997C1.2080506@gmail.com>
	 <46a038f90712191554t2c1adc79s7948c7002c145143@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tKuG5HrYqIAetMXWZvrf"
Cc: Thomas Harning <harningt@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 07:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5EWc-0000fk-L2
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 07:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020AbXLTGEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 01:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbXLTGEU
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 01:04:20 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:42646 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbXLTGER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 01:04:17 -0500
X-Greylist: delayed 1918 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Dec 2007 01:04:17 EST
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[172.17.217.22])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <andrew@catalyst.net.nz>)
	id 1J5E0o-0005dF-2m; Thu, 20 Dec 2007 18:32:02 +1300
In-Reply-To: <46a038f90712191554t2c1adc79s7948c7002c145143@mail.gmail.com>
X-Mailer: Evolution 2.12.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68973>


--=-tKuG5HrYqIAetMXWZvrf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

My code is an embarrasingly ugly, gruesome hack, but it (sort of)
works...

I use it to keep the SVN and CVS trees up to date on Sourceforge for
DAViCal ( http://rscds.sf.net/ ) from the Git tree.

Cheers,
					Andrew.

On Thu, 2007-12-20 at 12:54 +1300, Martin Langhoff wrote:
> Hi Thomas,
>=20
> I think Andrew McMillan had written a few scripts to "export" a git
> repo to SVN and CVS. Not sure whether the code is public. But at least
> for a while, the Mahara project was using git with SVN and CVS
> "readonly" exported repos, a bit like the BK->CVS of yore. He may have
> been using git-svn though.
>=20
> cheers,
>=20
>=20
> martin
>=20
-------------------------------------------------------------------------
Andrew @ Catalyst .Net .NZ  Ltd,  PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/            PHYS: Level 2, 150-154 Willis St
DDI: +64(4)803-2201      MOB: +64(272)DEBIAN      OFFICE: +64(4)499-2267
                        Is this really happening?
-------------------------------------------------------------------------


--=-tKuG5HrYqIAetMXWZvrf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHaf5RjJA0f48GgBIRAl9DAJwJjiQlMn9Zpaoi9y3Es05/b89wcQCglxoj
ULwGpJh0uzVNqiQtRl7Huuk=
=+PYV
-----END PGP SIGNATURE-----

--=-tKuG5HrYqIAetMXWZvrf--
