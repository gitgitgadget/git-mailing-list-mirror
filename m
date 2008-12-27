From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: commit.template
Date: Fri, 26 Dec 2008 18:53:51 -0600
Message-ID: <200812261853.55464.bss@iguanasuicide.net>
References: <200812261750.12204.bss@iguanasuicide.net> <87hc4qscz5.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3948606.nnR20mMsUW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: jidanni@jidanni.org, nanako3@lavabit.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 01:54:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGNSE-0007RZ-6l
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 01:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYL0Axh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 19:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbYL0Axh
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 19:53:37 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:36392 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbYL0Axh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 19:53:37 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LGNQu-0008Ev-5a; Sat, 27 Dec 2008 00:53:36 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <87hc4qscz5.fsf@jidanni.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103977>

--nextPart3948606.nnR20mMsUW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2008 December 26 18:01:18 jidanni@jidanni.org wrote:
> OK, both
>
> >> 1) man git-config mentions
> >> commit.template
>
> and
> BSS> git commit --help tells how this configuration option is used, in the
> BSS> documentation of the "-t" option.
> should
>
> >> mention what file is being used presently

There is no file being used presently.  With the "-m" or "-F" option, no=20
template is ever used.  Without those options, either the argument to "-t" =
or=20
the value of commit.template is used in that order; the editor is invoked o=
n=20
that.  Finally if neither of those are defined the editor is invoked on a=20
new, empty file.

> as one needs a template in order to modify a template.

You aren't modifying the template with commit.template or "-t", you are=20
specifying one.  You can create one from scratch in your editor of choice.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3948606.nnR20mMsUW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklVfKMACgkQdNbfk+86fC0jEgCfUZIsn0vHrcRB8qMPMVnJ5zPE
WpEAniK8Onw7Sqp4e1qAQt1+S147zrXL
=GgZH
-----END PGP SIGNATURE-----

--nextPart3948606.nnR20mMsUW--
