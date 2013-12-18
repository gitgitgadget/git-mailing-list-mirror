From: Joey Hess <joey@kitenet.net>
Subject: Re: RLIMIT_NOFILE fallback
Date: Wed, 18 Dec 2013 14:41:22 -0400
Message-ID: <20131218184122.GB7936@kitenet.net>
References: <20131218171446.GA19657@kitenet.net>
 <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 19:41:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtM4B-0006Ri-D9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 19:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695Ab3LRSlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 13:41:51 -0500
Received: from wren.kitenet.net ([80.68.85.49]:48499 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755378Ab3LRSlu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 13:41:50 -0500
Received: by darkstar.kitenet.net (Postfix, from userid 1000)
	id 88AE7305EE8; Wed, 18 Dec 2013 13:41:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239467>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Hmph, perhaps you are right.  Like this?

Works for me.

--=20
see shy jo

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUBUrHsUskQ2SIlEuPHAQjkKBAAtljpzsUGDIcGLA5CXJD+wul6gnkLzJZ3
CRWB5k6fjeq5GbkptFt0hniedvM26t8hFg2rxeEobF9T61RlrrXNlAKbaaLNpn0H
OTTqz8aYqypKKx0l4ku1Vuv0Hr04+tlOhdoHsCs3nJDrBxTlPlsDV/T74Ca9VRB/
b5Av7VXelIcEDGdjHZMydn/epdthMBhytzCVLXxR6wHx1rz7ibUyX902oBIaNXul
HvzMU/4wnMBSKbiHE63sdw6ADFThHfrH3GMDH/ubiF/+6o3Aqnw+nZbQi7AxFs3L
BHH5iH5k2mVfOUCZsw8feZ9DamcFbjmeUX/XtYuL9tO6eN8k771H38ott8cbHVHv
5bwxymN58Dx8oVDnISRlIxLUvRTokWFSITFZnHzgQHLUKHvvFjo63VA+9s3c9tqF
g7S5/LRf5wsoFByAFALwFhN6K3r8R7pyWL+cqmX2hPmOoc0OVX4fCPQLeckhFK3S
UMIFvvGV78Cyhnp4E5E7ztyFHY8JYNbog/z4ysuf1r/rheWyI0W6Iu/PeWNei/0N
JiRRZEBB5NGJ0IeSlsqNdieL6BxlzSoWIRGrwmAZ/864vljmZe+pfzC3uMo2CS0R
KbCaPA9jJPJMsojSa/Ipgrd8n8eVeXTuU7m5PQ8JfJyoA5qL1saLh7C9vkoR6Cax
nftY9nGd7l8=
=ztkh
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
