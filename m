From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Nov 2014, #04; Wed, 26)
Date: Sun, 30 Nov 2014 18:18:08 +0000
Message-ID: <20141130181808.GC90134@vauxhall.crustytoothpaste.net>
References: <xmqqoarto8xy.fsf@gitster.dls.corp.google.com>
 <20141127183901.GD4744@vauxhall.crustytoothpaste.net>
 <CACsJy8D7uf=TVDy1CYmQ8gO4KL=gSz=KMg6NmOEUzhjjjn=X_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 19:18:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv94i-0002IV-RF
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 19:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbaK3SSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 13:18:21 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54904 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752372AbaK3SSU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Nov 2014 13:18:20 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6F7372808F;
	Sun, 30 Nov 2014 18:18:14 +0000 (UTC)
Mail-Followup-To: Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACsJy8D7uf=TVDy1CYmQ8gO4KL=gSz=KMg6NmOEUzhjjjn=X_g@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260453>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2014 at 03:35:33PM +0700, Duy Nguyen wrote:
> I'm not Junio :) but I think the core changes are done. I wanted to
> actually add watchman support on top of untracked cache as well to see
> if it needs any more changes. I think I can see how it could be done
> now (not easy, but not terribly hard). I'm going to resend soon to fix
> some minor bugs (in a reroll that Junio has not picked up) and change
> file format to be more compact.

Excellent.  I want to see if this improves performance over sshfs, but I
don't want to enable it until I can put it on the server machine as well
to prevent incompatibilities.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUe19gAAoJEL9TXYEfUvaLTPgP/iqKX7tXY3sLNi88/YgL9v0k
n6tFc7QBUj2dPz0UAeS3ye/ls0NL2tBVQh4v7Jd5uTZS6ORCQ6xvMFgmkBVSu63V
HlVhRo3vViOOeDM3zyi5BeeGflTZXI9t36RIKyeE6+XuUFPzLdLrptM1udaUK6cf
WeGQ8NK+fNbzOZFPxWgrPoL6y4pOIp+3dfIXyK45fT+0Y+q6dwebpfYwT2njr7zN
ntMZjLl1TAQd0qkEq79dlFtSyg1Ayrxi4dQcOjDVj+HwdOev4f/OAu3riliNJ8oh
oyO684r62Wum9E4aF4TzITfBC6fba8/CELtdvrAnM4YD7uyXzc5Te2QRrW3S+lx4
NZeiyqRYErpQ/mtFyUCiVBaBpu8XHQXjaK2dn8C4p/SfBmi/pLFaVjH3jcSkvh9V
wRS0ynJ5W4GTjTPRKnKlBFratpw6XjI4uSUBfVBNnXdX/uqj/xcDz8Z/xO8tQ43R
SXR/u4PMck8DWd+7ZwZOVRaFXdwfQ4rs4aEDbesGF8VekxnUGvng6vXiikO5T0aP
eCi17VXCAxeu7mVoGofeZtIxWc0pSd8HQft66KRNDZvexaVh1388yrasLCmYq9sC
xL8qNVX5+17UH5EE7TjMrxqTrAHdMeD8Y2bNtYo5h8CPIccOmum1XlrDghiW2+7+
Rd5NGKvs1vJyXTGHfmJI
=ImKt
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
