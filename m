From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 9/8] CodingGuidelines: on splitting a long line
Date: Fri, 2 May 2014 21:00:42 +0000
Message-ID: <20140502210042.GH75770@vauxhall.crustytoothpaste.net>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
 <xmqqiopnaopg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uAgJxtfIS94j9H4T"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 23:00:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKZe-0005Mj-FZ
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 23:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbaEBVAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 17:00:46 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47503 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752662AbaEBVAq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 17:00:46 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:406f:e13c:7c96:bfde])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 70A7E28087;
	Fri,  2 May 2014 21:00:45 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqiopnaopg.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247980>


--uAgJxtfIS94j9H4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 01:51:55PM -0700, Junio C Hamano wrote:
> + - When splitting a long logical line, with everything else being
> +   equal, it is preferrable to split after the operator at higher

dict.org says that it should be "preferable", not "preferrable".

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--uAgJxtfIS94j9H4T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTZAd5AAoJEL9TXYEfUvaLG5sP/33MAYyNIcl/bzJsrbx+iXqU
Vy4/fbSLyW/z523f6iGJqOtNQ0OozzzcNorZX3d1Q7T4oj096i0KnMk2gWywTlsM
JfEnoB5550wAPmZhH6SZ/WXvBaRZ0nTJslNOv8zZ0hFy2Vye9+tkR/f8/oftfTv/
L407bvUUU61vm7MfEGzlEqC0qCpDUkRqvemSv3exbIqMVFh3dsRo75zrbezyRVxe
TzdNgwwEqHYgcJDK9ozlwqZ3lsjceI3Ba08o2NVURHc2LJPlDnu/Qh8MjiwXs1W4
kau4PPeC59CfnaUsNc1E2WsRFc8sbD4AdN1lbCFB5PsGakAg3DJfBFmOrRnuMKZk
kWUzCEo9nMC+ZdsKtuPjKrkZgRrEvBW0gYUxA4rGcz1+gPYzgoWh3kN9i7188rid
joOaSJw5Esdr0XYTAx6Z5KJJbIeQ0i/ouAPfcBmwlCmHW06l2RbwKve+9NgHL777
t7NMFnn32JwwOvIX2j43vk+05G9OFPkar50mzBfBMAT8EhZtb8yJd5xJO25AnQq5
ys33YyxwL8FIn9Mpi8D/zlAmjuKQudXpgjgZxLOeeNO6Tq1if/GiCtq1RRFNw5Tk
UulbAdHFWJ9MhpcMOXdhMOd2kvtvFBxk5odYP48PhLggJrRUkBtYCu8vvOjgOtWI
ZP1Qfv8O50nFfkHCo/4l
=2GuY
-----END PGP SIGNATURE-----

--uAgJxtfIS94j9H4T--
