From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: life cycle documentation
Date: Fri, 24 Oct 2014 21:56:07 +0000
Message-ID: <20141024215607.GH312818@vauxhall.crustytoothpaste.net>
References: <54497DF9.1050501@rackspace.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Cc: git@vger.kernel.org
To: Ben Harper <ben.harper@rackspace.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 23:56:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhmqJ-000849-Rd
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 23:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbaJXV4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 17:56:16 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49543 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754480AbaJXV4P (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2014 17:56:15 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B42992808F;
	Fri, 24 Oct 2014 21:56:11 +0000 (UTC)
Mail-Followup-To: Ben Harper <ben.harper@rackspace.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <54497DF9.1050501@rackspace.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2014 at 05:15:21PM -0500, Ben Harper wrote:
> Greetings,
>=20
> I am unable to find any documentation regarding the life cycle regarding =
the
> various versions of git.  Is only the current version supported?  What ab=
out
> older minor/major versions?  At what point does a version go EOL? Current=
ly,
> is only 2.1.2 supported?  I would entertain the thought on creating a
> RELEASES document if the information is provided.

The development process is outlined at [0].  Usually there's just one
supported release (at the moment, 2.1.2), although I have occasionally
seen releases out of order (from different branches).

Having said that, Git developers try very hard not to break things, so
many people are fine using an older version, such as the ones their
distros provide.  It is considered courteous to try the latest version
before reporting a bug, however.

[0] https://github.com/git/git/blob/master/Documentation/howto/maintain-git=
=2Etxt
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUSsr3AAoJEL9TXYEfUvaL904QAJfg3VmM9pN7h2lFy06ErPGn
OWqJNfOtMAjXC4IGHdOdzPvdayVf8GA9GrxzLD8ABlIASSi9oAhNHNKvsQN6pS5Q
ouHiLlOt9wLCxDWNoeP+bNRqzAQGfASAL9gv3jd4Tup+ksyB/7rgnEWX4uBBqVFc
FsLjbKAO+QBhA9JC/1er5UM5RW84XIYlVJc6+NYWKFkCmX0s/k40HzylveI2ayTT
OspJmoFutuoNkMHOpm860rvaX7o/UZpORXBp2A6V/YAc0TXaan7PMBwUDZvyEw46
6Jdq5QRiPWxPcDAG+mdmVDZ3rITNu15DqG6V2fEPNF2pvHBZC6HO+AeANOonYD3o
FyDxfVP56ahGf78s3dywKLxdYPWkzA9SvTxsLVNff8kZuh++SgYNtSrLTTYBilBW
IK5b3suMz25gb56N8PhV4obA6wnceMwAU++XFSodwx9ziIQbm2ie8IdJzA0+9W0z
yYIKjhYTK/quXpnJTpzoP+1dz4zqZqukyed23eOTA0W8iTUs4xO9++jVa+YVQsdw
iT2pVCYaDBXM0cyOziOAstkjNkYTYwLHSb5lAD0mQy9Wexbs+AHMqNkHMYApqcM7
/1BGTQI3Rc1F8kCVP9/kDjqRSV2+aNsSL/EwrKjZabNfByB07foIqXiL9BGyqhtW
O05xe0L48Lu8ldSFuD/H
=JmQW
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--
