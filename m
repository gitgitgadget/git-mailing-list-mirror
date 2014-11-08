From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 02/22] untracked cache: record .gitignore information
 and dir hierarchy
Date: Sat, 8 Nov 2014 17:08:28 +0000
Message-ID: <20141108170828.GA162918@vauxhall.crustytoothpaste.net>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 18:15:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn9bh-0004Vu-SH
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 18:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbaKHRIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 12:08:38 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49894 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753395AbaKHRIh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2014 12:08:37 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C26002808F;
	Sat,  8 Nov 2014 17:08:33 +0000 (UTC)
Mail-Followup-To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1415439595-469-3-git-send-email-pclouds@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 08, 2014 at 04:39:35PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> The requirement for this to work is stat info of a directory MUST
> change if an entry is added to or removed from that directory (and
> should not change often otherwise). If your OS and filesytem do not

Should be "filesystem" (or "file system").

> meet this requirement, untracked cache is not for you. Most file
> systems on *nix should be fine. On Windows, NTFS is fine while FAT may
> be not [1] even though FAT on Linux seems to be fine.

Tiny nit: "may be not" should probably be "may not be".
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUXk4MAAoJEL9TXYEfUvaLXHsQAIZEFkMv7ZUvJcWN45PrYifZ
cpcWiwBuMlC+p5JuhrIJ5V4b14L+NgaYmj7X3+Y/WWhg8Nbc+qdNgGNZjE6JvoXJ
bQNtyx23SV/74TOaj8qESfMqhOXvvbOiJgYc8OKPUSnY+r7P+9kD5/kiZy0x2XIP
ICN15PtECvsY5M7IR7LyJ5W7N6Socibw3ZlPs/q3k8M8dgRr22KYE7hdD4u7nYX8
EVyOitj8byJ+kHWGPnMRlzBOiYzz02NPJgfYDysEUf6Ctbq9+NUaxrEet++Ag2jg
dpmNdwq9qSf6sKPIByAr1PsNpEwmpk+VVD25w54yW1v3NwGHhyZxWWMDKfVc4SEc
6QIsIlk7LK4k7g/VnfRr449hI53pDdbQPjlTMGlDurRgOR8UCyqXrPAzVYgtuJoa
OfU6bEkm9Qc3H3vL+e7MafVxSGKAGhOzlnF/+zMHwOdEeTdT2b+FrMNLy1sk64uY
BGY+V221bq9d2+Zmz7+tk1cyBYaXl9VSdsvz2fHYcLiKHGv9yXxhEhjs1h6Am0pO
uaXnLunw45cCA3MdqvQcp6QCoOUZbKOw06sFeZTE0Qmr2wJFg5UlJgSGKH8h27Lm
1hDubEhsuXxVOPulzu5cuLGuqcFVjYcSrhXrA4ocsyaYxtuCawq7TItSGv6bJL9P
cWJ1EmJfVPPSUq0NpvvR
=XnQL
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
