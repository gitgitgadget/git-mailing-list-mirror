From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [TOY PATCH] git-resurrect: find traces of a branch name and resurrect it
Date: Tue, 20 Jan 2009 14:50:48 -0600
Message-ID: <200901201450.53450.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901161213370.3586@pacific.mpi-cbg.de> <200901201001.54979.trast@student.ethz.ch> <200901201057.18127.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3740432.LDpEl36s6v";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 20 21:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPNZJ-0004lb-3O
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 21:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762671AbZATUuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 15:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762623AbZATUuG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 15:50:06 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:45663 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762487AbZATUuF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 15:50:05 -0500
Received: from [63.167.79.115]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPNXv-000288-Q8; Tue, 20 Jan 2009 20:50:03 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <200901201057.18127.bss@iguanasuicide.net>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106522>

--nextPart3740432.LDpEl36s6v
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2009 January 20 10:57:17 Boyd Stephen Smith Jr. wrote:
>On Tuesday 2009 January 20 03:01:50 Thomas Rast wrote:
>>It was really intended as a toy patch, but if people find it useful
>>(Boyd?) I can add the rest of the options so that all searches can be
>>chosen independently, and shape it as a "real" contrib patch.
>
>I'll test it out later today and get back to you.

In my particular case, it wasn't useful without the -m option, but I=20
understand why it is not the default.

I think it could be quite nice; "undelete"-type commands are generally=20
well-received by users and when run against reflogs alone, that's what the=
=20
command is.

It's useful enough to me that I'd love to see it mainlined.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3740432.LDpEl36s6v
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl2OS0ACgkQdNbfk+86fC1xmgCfYaRFeeTz0OH8KMoeDidAK/dc
b30An24byvGoIzJPwHEHIsRUjW/xJfmW
=Li4P
-----END PGP SIGNATURE-----

--nextPart3740432.LDpEl36s6v--
