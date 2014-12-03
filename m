From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: configure failed to detect no asciidoc
Date: Wed, 3 Dec 2014 00:06:20 +0000
Message-ID: <20141203000620.GF90134@vauxhall.crustytoothpaste.net>
References: <547E4C28.7050407@lanl.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Cc: git@vger.kernel.org
To: Mike Berry <mrberry@lanl.gov>
X-From: git-owner@vger.kernel.org Wed Dec 03 01:06:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvxSe-0004Yu-RD
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 01:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933428AbaLCAGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 19:06:25 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54935 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932722AbaLCAGY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 19:06:24 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 35E002808F;
	Wed,  3 Dec 2014 00:06:24 +0000 (UTC)
Mail-Followup-To: Mike Berry <mrberry@lanl.gov>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <547E4C28.7050407@lanl.gov>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260605>


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2014 at 04:32:56PM -0700, Mike Berry wrote:
> The documentation is still causing me trouble as my firewall doesn't like
> the html in Documentation/docbook.xsl, but that's probably a firewall iss=
ue.
> Is there documentation method, not requiring active web access?

If you have XML catalogs configured properly on your system, xsltproc
will use them by default to avoid remote lookups.  On Debian, the
stylesheets and relevant catalog entries will be installed if you have
the docbook-xsl package installed.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBCgAGBQJUflP8AAoJEL9TXYEfUvaLXVMP9iA3yoe61qsdwjKwMl6WOZmF
zN7kF6kh0zp27frgumX03HsUIW/iJa5/X9DIZZejmMs9mzKnnTZKXo2GOMKAJiWV
Rub7yYu0dIWne11FDr6r6n27HiDZ22nbT7ulbMCgtdrwdd3uk/V/kt35z1d94RoS
myAY0eWoskc6B7nIqjI0O1H+XgOo2cCN5vUWMEAD0AKgG7/QusrBms5zoG96Rj5q
YKKR4rr3Bo0mEYqsnLu9zXqSKLshlnp0OhJC+M5x2edqChanM3MHZ6fUfvHJGQd4
3Qa5Uscpz6EUcdyqCAA4TBEVQG3bKZCeDvTJP738u1znDSiL00inTvracqe1yBFI
W9z17xQrgUpiOw9zGCf0XtXh/hnVzsU/WYTu5GKBHwHTBeD0o+R2WdyI8DwhEHlz
HfRJ+cVnSJ6uZRh+AZdYG5TUA6qQum1leG8u9UFD/0yQgPT4Cr+czyWy/nkw1BQ5
7WNLX5Lx4HGUnbQhLZfo/8vVRkvqt2nWA3vGR+TEjZ27WWH9xYJXIjSsx+MYr9u1
W9V0DzVQubAyEo6GjNe1lU9gpxUmwD3fZ+Yemt38hTepSaJyTIeTshbazADnOtFn
hrAPHZEelEmvcVI9b0h7zh1dzFPbKmLOcYZMVkl/E2rL2DC2rdvF8ks4L+DUPdYQ
ivisDWnJ0GvDmIZlDRs=
=Ai8a
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
