From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Best practices on updating documentation?
Date: Sun, 13 Oct 2013 20:42:40 +0000
Message-ID: <20131013204240.GD865149@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 13 22:43:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVSVF-0004mK-3Y
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 22:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab3JMUmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 16:42:47 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33015 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755256Ab3JMUmq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Oct 2013 16:42:46 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 22EA12807C
	for <git@vger.kernel.org>; Sun, 13 Oct 2013 20:42:44 +0000 (UTC)
Content-Disposition: inline
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236081>


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If I'm going to be adding an option to a command, should I update the
documentation in the same commit or in a separate commit?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSWwW/AAoJEL9TXYEfUvaLjQ4QALYq1OZCeISnNTE0gxOWri7F
1UIJgzyL49tsYDrnp4pffQm0Z88WuxUZ5jn9NZM2yGz8Q+M87SA7xID4nO5FSe8y
LURA5LaSxRi05BM5nUFcP9Mk0we7EYJqS44qoTtoqGnPGft/IIGcvSZTntu3hV47
HzhNQmTv+WLy5vWmdwptPT4sKVskqqzFMRcLm9BHZ/ZnSEmZw6IiwESyFbmpnMTq
1PKWPVKqD2u1eInU2VZwgVZBYNkf5w7XD+rwvKKfI0rtfHylb089NcYwg9dUuhl1
4i81FRtINERQkZMfW4D5zA0NJMhra8Ep3fTN5aNw42aUvdT/ORUag8P4EFBsED9g
a+TFrXPqrek+kCT7DFhDG10lYwVXDHkmKGXJOpHhrOAD9GBNlYtVVOCueo7jr9eW
H6fyEEPcMxlPG7DnNe5FDdj2J851JqeLsBfNZ3BQxXIwn3vFXkvTvUmUrfGgQS7O
xhGo4M6oPUBD8RuUpcp6wnCqWNGzyyiq5O2hyiVS6Msr2vIl/jnA7VMDVbGZQWZK
AgErabND+DePrIfsxUw8QUm8EV2KrBJeQTw8cbI/ifVauTze6fSrL/4RYtYEDeMA
13noBaj9/b+zMldFXiiGdFfwkvve7oELxWw5SFGiLrAbnGol4g+QjmS2o4oKqTT4
usLkYc5o7XL65Dwhn54Q
=onOP
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
