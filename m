From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH 4/4] Add an expensive test for git-notes
Date: Fri, 19 Dec 2008 17:49:39 -0600
Message-ID: <200812191749.43512.bss@iguanasuicide.net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <alpine.DEB.1.00.0812192347261.30769@pacific.mpi-cbg.de> <alpine.DEB.1.00.0812200035590.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1874507.B1d9pqAMUx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Govind Salinas <govind@sophiasuchtig.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 20 04:02:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDs6m-0004rZ-Uv
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 04:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbYLTDBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 22:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYLTDBJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 22:01:09 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:47770 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYLTDBI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 22:01:08 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LDs5S-0007Mu-8O; Sat, 20 Dec 2008 03:01:06 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0812200035590.30769@pacific.mpi-cbg.de>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103618>

--nextPart1874507.B1d9pqAMUx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2008 December 19 17:37:15 Johannes Schindelin wrote:
> +=A0=A0=A0=A0=A0=A0=A0test_expect_success 'notes timing' "time_notes 100"
                                                         ^^^
Probably should be ${count}.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1874507.B1d9pqAMUx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklMMxcACgkQdNbfk+86fC02fACfd00t/VlZIdutP8ftaJb7gnFp
IzQAnRo6wPdnwgsFKzoFXEkVd4EryU+k
=sgfr
-----END PGP SIGNATURE-----

--nextPart1874507.B1d9pqAMUx--
