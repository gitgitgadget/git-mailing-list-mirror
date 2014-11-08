From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Using git clone
Date: Sat, 8 Nov 2014 17:15:39 +0000
Message-ID: <20141108171539.GB162918@vauxhall.crustytoothpaste.net>
References: <1415120399.4259.5.camel@precision690.xccg.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Cc: git@vger.kernel.org
To: "Dr. George E. Moore" <gem@x-ctr-l.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 18:15:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn9c6-0004tY-DH
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 18:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbaKHRPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 12:15:44 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49895 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753838AbaKHRPn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2014 12:15:43 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 43FA82808F;
	Sat,  8 Nov 2014 17:15:43 +0000 (UTC)
Mail-Followup-To: "Dr. George E. Moore" <gem@x-ctr-l.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1415120399.4259.5.camel@precision690.xccg.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2014 at 11:59:59AM -0500, Dr. George E. Moore wrote:
> Is it appropriate to use "git clone" to update the master branch of an
> existing repository? The current master branch is for a much earlier
> release candidate.

You generally want to use git fetch or git pull in that case.  git clone
creates an entirely new copy of the original repository.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUXk+7AAoJEL9TXYEfUvaLFwkQAJ7auhqI+nUyoyozNc23vUwv
5JoLqnEOHH88IQqMoUKqjeYBQuw0MJFPmU3Jh9A+wql+6jQuv9R128bMwNNpdmnG
BrhChugVuf11RX+ogkxVGTlSfeNoewi0Vlr3qNQvO9SEeIEpi9Bd/VBa2JPD6lAp
fL52Edxh6II3YaUQTpRQk9W5th2WaTBcGgqLeSTmj4DgxjHaCFfBOxdnTj1tt3R0
Gy4X9yq2d6ZQN+NKst1gJ3U6K1FDh1FHajqsuhiQOMFhGOnuJckkP0lGLuFug2Sh
0I8KwGRI7iLmoIyJiuiytfI9UVSEbZ8L5mhr4U/AEYyDcaGtv7qO3AXHVnG26XTL
/4QxnNyJzbW9a5urdY9oBvke3KlTyIcqcVqxHZ02iUQShyveNpyA1hqZz2AykDse
H5Ey2h0jLMnd1SuxsKOwqI51cnO79r2UARTWPrcDWcYRn86MCfbkr7CHQeATEXOF
2YsXH3tDJzMTb1BFI6Ootbl0Cw3LbKiWfhZMV/j9xK7x15iIvV0UvV6AlR84kYEd
Yepk+X3hyPpAWyiRpj2uNGoDLy5fTP7auaCyL9G69RtqT5xzWCXelQFIYXXsbbog
e7sOCxjWHRsIZS3BolD6zalGKDFpYQFMvGqlb+t2OKAHlCFs4RZAZrJBF8W9C27p
XvprHhHmfmhN3gx/8I3j
=ELls
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
