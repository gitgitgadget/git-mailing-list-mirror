From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] rev-parse doc: clarify use of optional / required
 arguments
Date: Mon, 14 Oct 2013 23:57:42 +0000
Message-ID: <20131014235742.GF865149@vauxhall.crustytoothpaste.net>
References: <1381760611-9573-1-git-send-email-boklm@mars-attacks.org>
 <20131014143632.GD21200@google.com>
 <20131014152529.GU4589@mars-attacks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Tue Oct 15 01:58:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVs1M-0006RG-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 01:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848Ab3JNX5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 19:57:52 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33037 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753884Ab3JNX5v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Oct 2013 19:57:51 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BBDD62807C;
	Mon, 14 Oct 2013 23:57:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131014152529.GU4589@mars-attacks.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236153>


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2013 at 05:25:29PM +0200, Nicolas Vigier wrote:
> The reason that I looked at this documentation in the first place was
> that I was looking at adding an option '-S[<keyid>], --gpg-sign[=3D<keyid=
>]'
> to git-rebase, similar to the option in git-commit, so that rebased
> commits can be signed. In git-commit this option takes an optional argume=
nt,
> so I think it would make sense to make it optional in git-rebase too.

It's funny you say that, because I literally started on that yesterday.
I have cherry-pick and revert working, but I haven't gotten to anything
else yet.  Feel free to work on it if you're interested, as I probably
won't get around to finishing it for some time.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSXIT2AAoJEL9TXYEfUvaLjGYP/0OG1TsyHypSsxNzUhgzDqzC
ONW6OaGL0T/sWIFxiiHPnc17htROdRsp9+66N4jGr27Psfchss+c5I3j58+3DB+M
49dfgqiMCmUHi+SAkH66QsKVAwk4PeFLW21LFU4nhTCaEbD9CXUEPpfeg+M7O9Yi
a1DwX4Ou0/8GFitcb0q8TT5bnSKl+AocT+4LGC86/fpz+ar6UVhXYBLWxo1KpNpE
GgOs1K6AdHZoGSuI/7rdJkOYvH3jup8Aal7E3zeU8c7yamEDZd2HuluIszn3Sxed
CY1AgY39O1uQAaLp8tQPcKWdVOw7B9qcpMDrB2Rwo4H/pBuOAwENgqQnPoAefrs8
CFMfez0NF4KCbeLahTA4k4JpiItxTE1u9D4K3gnOATM/4ztlc1RLwYPdWwW2P2sv
caAkgSp9crpfb3zjilW1veXe5r+IAeQZdgwPLSv1L6OF3IBNdhvhPA3ioAq9QWpp
7qxGwx8svCfvYfx3n4NgeMs/+Mjm4v2zYQP3mxKPr5pO9xaZ5my+DPGoHtybSLBl
pi9QpW+AhVTbAhzyw5vHNa07gShD4xG4+B4wa0SPUf2RCCcnhblyMvUUa1lOlpqG
0BP6kPEj+Crk+b4r6X847AZYCnW7+tFkKBD8YiQXQsyZ7qvZRdLuv672zqVIk34E
WyB+I8OXWNItESrjmo9J
=ADdQ
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--
