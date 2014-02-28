From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 22:15:05 +0000
Message-ID: <20140228221505.GA681289@vauxhall.crustytoothpaste.net>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
 <20140228053703.GA32556@sigill.intra.peff.net>
 <CAN7MxmWP9N==0DnoE-0=Xr7NWkNMSGBC+yiz1a3wS5EbHigvKg@mail.gmail.com>
 <20140228062715.GE32556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Cc: Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 23:15:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJViG-00061n-Vy
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 23:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbaB1WPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 17:15:15 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:52250 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752435AbaB1WPM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 17:15:12 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:4ddd:8d7a:e496:d6fd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9B2B328088;
	Fri, 28 Feb 2014 22:15:10 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>,
	Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140228062715.GE32556@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243022>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2014 at 01:27:15AM -0500, Jeff King wrote:
> On Fri, Feb 28, 2014 at 03:17:28PM +0900, Brian Gesiak wrote:
> > Patch is on the way, just waiting for the tests to complete. Thanks
> > for pointing that out! Also, sorry if it's in the Makefile somewhere,
> > but is there an easy way to run just a single test file in the t
> > directory?
>=20
> You can run "./tXXXX-....sh" explicitly.

You can also use Perl's prove command, which provides some nice-to-have
features, such as exiting abnormally if your tests abort prematurely.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTEQppAAoJEL9TXYEfUvaLVEAP/iJ+uoBAAWxN8ardXPsdFNvt
PG+jWYv7cXfeC473VKYmdspmlo8Rpy9Xi3/mJDHHp0MokeOAPAn86xO31BMqp61h
gmX26zHeyWPOPfvcNu+/uNv0nfLYxBHHagkfePYtLdrGXElOfDo3YEpKork954Yg
NTpRz2momkHNf5wQa2jkzzlEdymRiywbMKsB/VRifA325m0eTy7fdzAKAR7vvk0R
6tOQitr9EAcagImG5/74YE1bpfNELTvnYMHJbiC3NfneZHC++ETspYP7Ut98rYoW
leTZzqIZLIaZ94c73fIhJewCb24LN8aGS9cOfOiJ7nqPBXmVdeXPehx/UG6H3BFB
PMOt8kxhpC/XlYurKfKQjSjxAf8V35zPhAesBNKtIOlEDyjzZDR4HYNl0FMTtfwu
pqT2DpA9l5JGvxwHRYmoQcdc4/2SaenIYx0BYRdwl8O0ovSs1ok82s3E6zlXozLb
4hM1YITRIK8hV+BUXdcNkKntDULH8OaVLFp7RSkTTxd199xWhgJRnzGtv/FFJnCC
lIb4kPjGQG7GqCUZyVHahGIrBwXzb5+XYyvb0NOmJ6erAx7OIbTKLiRPFQdmmcK1
QQkV+ik2PM4IYsE2rahQsRnBZ0icofhvp7rqxEaieiSXz3jFlJSAdMxUA9+INj9z
mkdyqqigapFFCyVqAFxu
=7MRZ
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
