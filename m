From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Error 128 Clone succeeded, but checkout failed
Date: Wed, 18 Jun 2014 23:55:39 +0000
Message-ID: <20140618235539.GL368384@vauxhall.crustytoothpaste.net>
References: <05c29ee7-8629-424e-b2db-de49db976e55@US-BV-EXH02-P.global.tektronix.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RNRUMt0ZF5Yaq/Aq"
Cc: git@vger.kernel.org
To: warren.l.dodge@tektronix.com
X-From: git-owner@vger.kernel.org Thu Jun 19 01:55:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxPhm-0000lr-GD
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 01:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbaFRXzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 19:55:46 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48416 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753095AbaFRXzq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 19:55:46 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:4482:19b0:51d5:328f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 340E62808E;
	Wed, 18 Jun 2014 23:55:43 +0000 (UTC)
Mail-Followup-To: warren.l.dodge@tektronix.com, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <05c29ee7-8629-424e-b2db-de49db976e55@US-BV-EXH02-P.global.tektronix.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252082>


--RNRUMt0ZF5Yaq/Aq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2014 at 04:03:40PM -0700, warren.l.dodge@tektronix.com wrot=
e:
> git.exe clone      --progress -v  L:\GIT_REPOSITORY L:\warrend\fail
>=20
> Cloning into L:\warrend\fail
> Done.
> Fatal: unable to read "Long hash key"
> Warning: clone succeeded, but checkout failed.
> You can inspect what was checked out with git status
> And retry the checkout with git checkout -f HEAD

What git version are you using?

Also, is this the exact (copy-and-pasted) message you're getting?  There
are several similar messages starting with "unable to read", and knowing
the exact error message (including casing) is important in order to be
able to help you.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--RNRUMt0ZF5Yaq/Aq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJToib7AAoJEL9TXYEfUvaL198P/3JJgwDjrZuAW6csPZy5sqdh
kl5RH/UPw4A9Zsf1WyV74gKyku5TJPe4BfmGVVXUy2YDiWQkWbrjpSBwkoX/iRx8
o/LP8xpfBIww/NndPZzhy3YnIyFfqCK1BbttRyckqhCCG5Vi4fmZ81PxuzQfFX15
MvPYEDPDOLGiUVxtvqrfN46FD8oQ6ae2bDVPtyy1SJZ9ZrCwiT5NkzLOC7510sis
jiWs/X+9WNcCdzsa9lmwa/bTfxt9cJwQjfNDw3cAHSe6lqclcdGMopv6Wxxe86Dx
F5R0s22DYyWf1JB68Jx4+QFDezOQPBOgp492JsUVuSM2ZbSLZQDxuR8z8MBYX+c2
z9hWbebZf/yMuGhMF7cnNwiwByR2psqN+eLPwYOhocmkIeQFZAw4rmbnd2GYbWN1
pIMo645eYGtnJKyVEYshbZJPVneuEB4xGsASNJcsbSnQCuVnnxnIxI0EnfltRX77
C3jWf44FeMGZe/dlA8o5pQJvogmsLg7hCm6Fx2vzjuz+p2Y2x9MM4o5kywgSEe/B
EAOQUP9B9NGZXygUlyZMzBYIt8KjT89ejMJESUS4MMPD5uKhmu0CjTs+gLyT+C4n
UZAlPOJAkmn4PUturnhqGQBiovi9YpAk9OE0JKG2wWSjLsE9W9oFF1vzda/HNfef
4uJV2NGE4b8FvzPB073D
=Ey6u
-----END PGP SIGNATURE-----

--RNRUMt0ZF5Yaq/Aq--
