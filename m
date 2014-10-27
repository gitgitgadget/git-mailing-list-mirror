From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: life cycle documentation
Date: Mon, 27 Oct 2014 23:02:09 +0000
Message-ID: <20141027230209.GB422734@vauxhall.crustytoothpaste.net>
References: <54497DF9.1050501@rackspace.com>
 <20141024215607.GH312818@vauxhall.crustytoothpaste.net>
 <544E5C2F.3090800@rackspace.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Cc: git@vger.kernel.org
To: Ben Harper <ben.harper@rackspace.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 00:02:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XitIp-0006W5-BD
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 00:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbaJ0XCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 19:02:15 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49605 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752197AbaJ0XCP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2014 19:02:15 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 027F72808F;
	Mon, 27 Oct 2014 23:02:13 +0000 (UTC)
Mail-Followup-To: Ben Harper <ben.harper@rackspace.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <544E5C2F.3090800@rackspace.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2014 at 09:52:31AM -0500, Ben Harper wrote:
> Thanks for the clarification.  Someone in IRC mentioned the maintain-git.=
txt
> file.  I skimmed it and searched for some keywords, but was unable to find
> the information I needed.
>=20
> Do you feel a RELEASES document is needed or is the maintain-git.txt file
> sufficient?

I don't personally feel one is needed.  However, I'm a semi-regular on
the list, so my opinion of what would be helpful to people less familiar
with the project is going to be skewed.  If you were to send a patch to
add a releases.txt file in the Documentation directory, it would
probably be welcome.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUTs7wAAoJEL9TXYEfUvaLK3gQAKH6HOA5rM5I8fPw73PeEbhA
KXfigJ4XwK+ss30Vzd+bmmiwYTyPaR2wMx443B0T/hAo9jlKcTF89j/0pF5gBOIl
ZZmyb36FNNPceNIFZs8Gr8WeQrtOWv8TQulNdYo3XxQin01+fg5RI4bRMXdiva+y
OVBcJqytztVAAwyt/jZFSQHSvNlPHjeZYuNHO/E9lJxk5vQ0cextVlAj96qMjRdT
qj/073QtZlcmbG4EHt1jUM6Pztp+F2Xcy8F8Zhabrao6Rwyfxu2dmrixaUkuNl8v
SErncw2JnwzMKEq2/IgeQNbBXFfoj6LZAgl6tbd4+gSaT4zyR+igF0w27czgairy
pXAO0248h6aM/BcocVnB62aya3up86/9Rj0gM2cc/7L+hhlPpUTzQVGo7jeswVSr
2wx4giDst8CJKaqBp/puAAQMcSvgIiTQ/IfGB9sH7PQoDoO2/+Tx7+2vNstNDIUR
Locb3ZsjrPEpea+NbFzeVXU7ZyVLe/dInKXqOJDaqnLA60rvfiE/yeRNjCyRg4w7
KdsoxprOle08JUofwS3vG+eNbvAIh5hgTDaSYoS3pS4NIoN4igIeZv+w9iK747BF
lfFyLupDX6QA9o5BNSYnKadci2SABqgvGj+FrcFAxnvdpLIXfra8NMNlhZ3SgcgC
JEC38PcVkEaBSpOTCtQD
=KIXT
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
