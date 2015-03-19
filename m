From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] git=p4.py rebase now honor's client spec
Date: Thu, 19 Mar 2015 21:58:17 +0000
Message-ID: <20150319215816.GI612775@vauxhall.crustytoothpaste.net>
References: <D1303946.5CED%Sam.Bishop@blackboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q5r20fdKX+PFtYHw"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sam Bishop <Sam.Bishop@blackboard.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:58:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYiSU-000645-7o
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 22:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbbCSV60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 17:58:26 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50606 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750731AbbCSV6Z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2015 17:58:25 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1E4072808F;
	Thu, 19 Mar 2015 21:58:24 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sam Bishop <Sam.Bishop@blackboard.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <D1303946.5CED%Sam.Bishop@blackboard.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265846>


--q5r20fdKX+PFtYHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 12:28:09PM +0000, Sam Bishop wrote:
> When using the git-p4.py script, I found that if I used a client spec when
> cloning out a perforce repository, and then using a git-p4.py rebase, that
> the rebase command would be using the current perforce client spec,
> instead of the one used when doing the initial clone. My proposed patch
> causes the rebase command to switch to the perforce client spec used when
> doing the initial git-p4.py clone.
>=20
> This email and any attachments may contain confidential and
> proprietary information of Blackboard that is for the sole use of the
> intended recipient. If you are not the intended recipient, disclosure,
> copying, re-distribution or other use of any of this information is
> strictly prohibited. Please immediately notify the sender and delete
> this transmission if you received this email in error.

You might want to read Documentation/SubmittingPatches for information
on patch submission procedures.  Most notably, you'll need to sign-off
your work to indicate that you can submit it under the appropriate
license.

The confidentiality notice above is not only inappropriate for a public
mailing list, it discourages people from even looking at your patch, as
you just claimed it was confidential and proprietary and nobody wants to
be sued.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--q5r20fdKX+PFtYHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVC0Z4AAoJEL9TXYEfUvaLoeoP/3LvOk3WShMJ1TzGsM9Wz0tT
RJEVaAhgBfeQNNma+YcngCLNtS5o9UMchoADJYkZ7y6K9fapJC+dh/naGi/MlovX
2rTlGrzuaJIKUHBf9bp6gc5SFmucM08ISo6bi8Nxu66JVSJ2L6MSZ2dozspqgH+U
L7hheSvlUPQrqTE0L6jkmQQYamKIlIz4vCB/GzdWsmJNJ2n4B+wcBQHbbCVvV6i7
UAFDAvR0H7ygHImZZS2nzpKz7YOs+uyVkgo2jM3nOyDF+COMpuJ4Z2lDYWyq47mm
GgwSfk6Xar4fRw8V6k9abfhPwQ2qiUKndBN7d0qSEjY9+tlgp6+sd4xjlAVsxUQk
ptrbkjRV7ZIJkfNpdT0uUF7ZEN6ajDwSPPX6eV6glSGNKrECpFs065Bd61B/7jOy
QMqPrpnkS/S8SmNOruqT4bDFS7pPN6vfsgBr1Gs/5kdte1tJ8kjnfWd23GUL1ZGg
MyIG2CuWWWkvtUNGj2wTfvRpZkIvcfEQytcdOH9f305mKCd3esAWnIUKxSddAlKL
jobYxLG3Xyu0yTJrHNIZ/T6TGSdKkC17iP9/cajN4tP3AYGxvcHAC4ntRW1H+DNH
oNXWpavUupGjSCLK3ZZIgNq/IAGM05AbeKGoLqAaBG1E92a9RDFrb5zv2JP9V85y
s2NLW810uEsL2fkmTmcX
=WN4t
-----END PGP SIGNATURE-----

--q5r20fdKX+PFtYHw--
