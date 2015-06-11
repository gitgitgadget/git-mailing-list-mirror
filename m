From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/8] object_id part 2
Date: Thu, 11 Jun 2015 00:02:52 +0000
Message-ID: <20150611000251.GB786544@vauxhall.crustytoothpaste.net>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqq381zi3ev.fsf@gitster.dls.corp.google.com>
 <20150610235114.GA786544@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 11 02:03:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2pxX-00039I-5t
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 02:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbbFKAC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 20:02:59 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:39727 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752640AbbFKAC6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 20:02:58 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [63.226.122.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 997842808F;
	Thu, 11 Jun 2015 00:02:56 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Disposition: inline
In-Reply-To: <20150610235114.GA786544@vauxhall.crustytoothpaste.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271369>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2015 at 11:51:14PM +0000, brian m. carlson wrote:
> On Wed, Jun 10, 2015 at 03:50:32PM -0700, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > >   Convert struct object to object_id
> >=20
> > It seems that the last one didn't make it...
>=20
> It appears the mail was too large for vger.  Unfortunately for
> bisectability reasons, it is necessarily large.  I'll resubmit the patch
> with less context.

Unfortunately, the only patch I can generate that falls under to 100 KB
limit is with -U0, which isn't very useful.  How do you want to proceed?
The branch is available at [0], or I can send the -U0 patch, or I can
split it into unbisectable pieces.

[0] https://github.com/bk2204/git.git object-id-part2
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVeNArAAoJEL9TXYEfUvaLTIUP/2NWphfhwqDarZKR0h7ufP/F
gD53QsQ+g5qMPVAJvJIWqBr/c7e+9hmOqSpqZArs3psWG6iP75+fwbkYARUELlz4
UcnCmFgvKabUymTgA141pHvY+35aEZmvaEQyn/2YLk3hrEoYqBMMmcLFOmYP8k2y
yVuINO2//z5E9615E+6Gz2LaVcHHivD6mo+yuCiYH78TpNHJgcZb+0EaDfyw/IxR
7MEzDYjKKYb4EHhnaaC52J2Xd6TiRasbjut2tcKjjpGrcCULBlga84fO/6kLw5yp
4nIxA86cs840Pgw+MpXBtLURGGZj9ViK9khaLRX9ZJOnLl9DBoYvpsQXNemAH/yc
KkXSvK9dzZT0cRuMfmjMEDMpTlkyDdrdeSlEM9DYtd6El/ZijelWn0v4aU4dg4C9
ngiZOhPiGSHPEaylXQ8jULEeKK6TJfgr4XiLifqwRDhRg7apqxet6MheWidEaB6G
3HKCtgfx4qD/wg4jcvkK/NNP1T2b4JYD5Tslt7sbr8hB9ZxxywV2UFHtdOonAERU
kfYevFylr4JGQR0bGafOSEf26PWY5kmaZOAKzrJPAjbHd/VgdGL/Y+VAwbfB2mJS
oZzL2PjbmzxqB11lhA5PbEQ0VaIYhc8p/GrjwMpJOPkuxqyN4SO7XxVNDXX1etVQ
Zw2+LJ62LWKsoSfIrD8p
=2a8o
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
