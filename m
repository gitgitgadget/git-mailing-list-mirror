From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCHv2] Have manpage reference new documentation on reverting merges.
Date: Sun, 21 Dec 2008 18:04:01 -0600
Message-ID: <200812211804.07486.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1640563.baqiehGNEX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 01:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEYIH-0001xM-SZ
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 01:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbYLVADu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 19:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbYLVADu
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 19:03:50 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:55393 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbYLVADu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 19:03:50 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LEYGz-0001tl-2F; Mon, 22 Dec 2008 00:03:49 +0000
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103734>

--nextPart1640563.baqiehGNEX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 2008 December 21 15:54:18 you wrote:
> "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
> > I took the alternative approach.
>
> Thanks.  I was thinking about doing this instead; how the reference to the
> HOW-TO is done is different, and I am hoping that it would give better
> result for HTML version at least.

I like the different link style (still learning asciidoc here), although I =
am=20
mainly concerned with the manpage output.

However, I intentionally avoided using the word "branch" in my prose, becau=
se=20
that implies (to me) that the ref is what is remembered and important. =20
That's not technically correct, as refs are not part of the history that is=
=20
considered during the later merge.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1640563.baqiehGNEX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklO2XcACgkQdNbfk+86fC3hpgCfVu53+HhmNhFBC+4CFtscELUW
8FQAniFDx7eAe29L2VTGqAm6e8pJhpmz
=pdZc
-----END PGP SIGNATURE-----

--nextPart1640563.baqiehGNEX--
