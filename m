From: Joey Hess <joey@kitenet.net>
Subject: git commit synopsis typo?
Date: Mon, 29 Nov 2010 13:37:58 -0400
Message-ID: <20101129173758.GA2279@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 18:38:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN7g2-0005ZM-1j
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 18:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272Ab0K2RiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 12:38:07 -0500
Received: from wren.kitenet.net ([80.68.85.49]:47481 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847Ab0K2RiF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 12:38:05 -0500
Received: from gnu.kitenet.net (dialup-4.153.251.123.Dial1.Atlanta1.Level3.net [4.153.251.123])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id B264D11915E
	for <git@vger.kernel.org>; Mon, 29 Nov 2010 12:38:03 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id CE90D4EB45; Mon, 29 Nov 2010 13:37:58 -0400 (JEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162407>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Shouldn't the -i and -o options be listed before the -- option?

       git commit [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dr=
y-run]
                  [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-auth=
or]
                  [--allow-empty] [--allow-empty-message] [--no-verify] [-e=
] [--author=3D<author>]
                  [--date=3D<date>] [--cleanup=3D<mode>] [--status | --no-s=
tatus] [--]
                  [[-i | -o ]<file>...]

--=20
see shy jo

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTPPk88kQ2SIlEuPHAQjBtRAAs8Y+CzBzsqfyX2v38nujuJ2Nl13xJSTM
VqTEKu1USvRggXK6PHSsYjQ7DcnqgWds1++gYt2Czzhhzp20jRZsoLKPL8eRRkSi
8tT7RRul4pVMJVDjDA01WQ9gi1lRnbLecw7EHmp5PbWqw+1DXjj7KBN0dAgSHtLq
wDS9tDoi6JN2sxi1vh75N/Xgz+0MW8gwwmSLZkhjE7yfcMI8PoqevuGqwLz2MFsr
1w4yGEGxdNHSBZFZzze+4OJ5o4TXeYmEUarQp1cm8Qd1GZiNAfbdYHC0QrKtaA3Z
Kn5A84Of6AKwgNkqIBPVNVOxZQmQKrEpcr1yoESLdiC1CQe8rvwOgDRy7yEavN8/
gqyyqeQ3w4nImbjRrUQ5fg9sZGYJ0pJKo5bDtV3hZhm+f5QJqb+SekMDkOz/RrSj
6vK57xH3FjPl5rfFZupUvbWkFfIhgd+oUavqzoSauh+YLDGy4oGbAAYPcDrYaYSa
hPLrk/ETuoQ5PEskAj7ob5kVpgw+GfQ75EWW86y0emvgVFUYAU+QT3VtO0rwd64C
C0F6bbOh7leJTQmg8AFy6Ni0Q/c9s74aFT3sX6kTwu7j5cwEzM8BO/GV5G1v5zZ2
Y0yQh3UE/IpnVhsmEySbiSUDer+sr/mh3UjDHpKKe9ekoGVyVPSZRCMi61s1JggJ
czO8NAuLL4I=
=p+En
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
