From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git Help needed
Date: Fri, 1 Aug 2014 20:59:41 +0000
Message-ID: <20140801205939.GA57436@vauxhall.crustytoothpaste.net>
References: <898fcfcd0c4f41da805abdd41622058f@DM2PR08MB477.namprd08.prod.outlook.com>
 <20140801200459.GA53075@vauxhall.crustytoothpaste.net>
 <6a7fe740d5bd4e4fb3a3f6d8a81b4c26@DM2PR08MB477.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Cc: git@vger.kernel.org
To: RaviKiranGoud_Palpanoori@vfc.com
X-From: git-owner@vger.kernel.org Fri Aug 01 23:00:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDJvh-00018B-5Q
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 22:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960AbaHAU7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 16:59:53 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49259 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755270AbaHAU7w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 16:59:52 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.141.156.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6047A2808F;
	Fri,  1 Aug 2014 20:59:44 +0000 (UTC)
Mail-Followup-To: RaviKiranGoud_Palpanoori@vfc.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <6a7fe740d5bd4e4fb3a3f6d8a81b4c26@DM2PR08MB477.namprd08.prod.outlook.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc6-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254665>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2014 at 08:27:24PM +0000, RaviKiranGoud_Palpanoori@vfc.com =
wrote:
> Hi brian,
> Thanks for your quick reply.
>=20
> I downloaded git 1.9.0 from the site
> https://code.google.com/p/git-core/downloads/list.

That URL is obsolete.  Try https://www.kernel.org/pub/software/scm/git/
Google Code no longer allows anyone to upload tarballs.

> Does it mean the package available at above location has built with
> specific version of OpenSSL. How can I find out which OpenSSL version
> is used in the packages available at the above location.

If you're downloading the source tarball and building it yourself, then
it's whatever version of OpenSSL is on your system.  To my knowledge,
nobody provides pre-built packages of git for AIX.

> Could you please suggest the site from where I need to download git
> for AIX OS.

As I mentioned above, you'll probably need to build it yourself.

> Who are the vendors of git so that I will check how to proceed on this.

When I referred to having your vendor patch the check out, I meant your
vendor of OpenSSL.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT2/+7AAoJEL9TXYEfUvaLuV8P/jvaLOI416Y1JYz6lVo5kSfB
pU1Ob28VuqUg1M4W2XnYCcnK5531+92/Qw9W9I2p/CCGSb03sOas/JzGAN05G9ta
H3hzzfFBsIUXcSejugASl+Oio95XXz4z1tQw/jSiq5QnV6BlIiC08VlpMmr6tai8
PNrtdy3rn4uo1rvj/joE7hVnQpaWTSe2798/QsrQ5M0sjNVFahmF9UnQ0BQlFvgj
cGFJAhiwcAVi0qvYGSGNkvaX+yLRfmkYQmPzda6Rl8x9DU6e86iUVxe6xAonaSRI
0J3XAWvKREflXvS4PV6X3rsGZqY0PekV3kZScAvFD2DZc8YMVnvrSRXyuCauMFUX
j8itHptmvNh44CLNbXg/0oIuFqgA+fK3Qn7tklbmywpUXk7oA0AtrsSRfvwy37SA
qjaTxXRlr58EjBTpMldGMNfFxrZ9bjXM1YYgzJAaFaZMzemM2WVTTDYQkITdT8A5
Fqf0F4mTwbBofelThjUFWlZMG+GMwqlA798LXDWIFFgUNBrfbcZbjPlIx8BjFKah
sNBCSaBMN9zEcyj8KnF68DTYxU8Wxl+xffR7PKuah+ILC1k20ieOMUoQjALUKPiZ
rcDoIh/JsP7tpr+68+6Nn/jCv4JKkvrbNO+OHBwSVP4FyMLcjjieWDoRzqPMDZB6
GerPNAXMly2FdgGJydAA
=iPW9
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
