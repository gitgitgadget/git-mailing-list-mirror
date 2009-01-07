From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: git rebase orthodontics
Date: Wed, 7 Jan 2009 10:10:40 -0600
Message-ID: <200901071010.43926.bss@iguanasuicide.net>
References: <87sknvxje8.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2170365.M7snQt5NfS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Wed Jan 07 17:12:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKb0N-0005vN-5t
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 17:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbZAGQKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 11:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbZAGQKM
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 11:10:12 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:44587 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbZAGQKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 11:10:11 -0500
Received: from [206.104.164.114]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LKayv-0006I2-Rs; Wed, 07 Jan 2009 16:10:09 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <87sknvxje8.fsf@jidanni.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104807>

--nextPart2170365.M7snQt5NfS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

If you want to go from:
>               A jidanni
>              /
> D---E---F---G master

To:
> D---E---F---G---A master, jidanni

You don't want rebase.  You want 'git checkout master && git merge jidanni'=
=2E =20
I think you can throw --no-commit on the merge is you want to avoid a non-f=
f=20
update to the master ref.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2170365.M7snQt5NfS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklk1AMACgkQdNbfk+86fC3vJQCeILfdyOQBTLjFbqGDLngvvRjW
1AQAniPVqRprzVE1+l4oFMKeBwYqy4LH
=jzji
-----END PGP SIGNATURE-----

--nextPart2170365.M7snQt5NfS--
