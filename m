From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 16:39:11 -0600
Message-ID: <200812301639.17248.bss@iguanasuicide.net>
References: <gj68a0$u56$3@ger.gmane.org> <200812301549.26538.bss@iguanasuicide.net> <200812301617.15496.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2304574.8R7iV9ZtBu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Zorba" <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 30 23:40:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHnG3-0002qb-2E
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 23:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbYL3Wix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 17:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbYL3Wix
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 17:38:53 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:47116 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbYL3Wiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 17:38:52 -0500
Received: from [206.104.161.8]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LHnEh-0005I5-Sq; Tue, 30 Dec 2008 22:38:51 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <200812301617.15496.bss@iguanasuicide.net>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104219>

--nextPart2304574.8R7iV9ZtBu
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2008 December 30 16:17:11 Boyd Stephen Smith Jr. wrote:
> git checkout -b versionB &&

Should be:

git checkout -b versionB master &&

to match the other section and fix this part of the output:
> Switched to branch "versionB"
> total 4
> -rw-r--r-- 1 bss users 4 2008-12-30 16:10 ABC.txt
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2304574.8R7iV9ZtBu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklaoxUACgkQdNbfk+86fC32PgCeJiMFGGUz7fVvx0nTm2OtkGzZ
otMAn3+i7CDGYtpRYjogEXQkr9RC85R8
=T7D6
-----END PGP SIGNATURE-----

--nextPart2304574.8R7iV9ZtBu--
