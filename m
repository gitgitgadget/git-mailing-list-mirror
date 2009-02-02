From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: duplicate sign-off-by error
Date: Mon, 2 Feb 2009 14:28:01 -0600
Message-ID: <200902021428.11084.bss@iguanasuicide.net>
References: <79FCCC4F-9C66-470E-AC32-8F3AE3C81EE9@columbia.edu> <200902021405.00562.bss@iguanasuicide.net> <597340B9-A11E-4C69-8389-326D3777D9BA@columbia.edu>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2414696.AhqelC3jCY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sharib Khan <sak2109@columbia.edu>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:28:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU5PJ-0003FU-FG
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 21:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbZBBU1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 15:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbZBBU1L
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 15:27:11 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:41824 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbZBBU1K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 15:27:10 -0500
Received: from h15.154.102.166.static.ip.windstream.net ([166.102.154.15] helo=dellbuntu.localnet)
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LU5Nt-00062n-Do; Mon, 02 Feb 2009 20:27:09 +0000
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <597340B9-A11E-4C69-8389-326D3777D9BA@columbia.edu>
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108118>

--nextPart2414696.AhqelC3jCY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 02 February 2009 14:16:30 you wrote:
> On Feb 2, 2009, at 3:04 PM, Boyd Stephen Smith Jr. wrote:
> > On Monday 02 February 2009 11:22:36 Sharib Khan wrote:
> >> I m getting a Duplicate Sign-off by error when trying to=20
commit to
> > the
> >> repository.
> >> I am using git 1.5.6 on solaris
> > It's looking for lines in the commit message like:
> > Signed-off-by: Joe Hacker <jhacker@uni.edu>
> but where are the commit messages stored - which file where i can=20
find
> this
> is it the COMMIT_EDITMSG file ?

Usually.

> > If you can't see the duplication, please try to put together a=20
series
> > operations we can preform to reproduce your error.
>
> series of operations is
>
> 1. change to the file
> 2. save the file
> 3. git commit -a -m "change message"

This is *not* what I asked for.  I asked for a series of operations=20
*we* can perform to *reproduce* your error.  If I do this here, it=20
works (no error).  The best way to give what I asked for is to=20
start the series of operations with "git init" in an empty=20
directory, but that's not the only way.

What if you just "git commit -a" as step 3?
What is "the file"?

> is this something related to solaris or git crashing - the commit=20
had
> worked earlier ?

Possibly.  I can't look into it that much until I can reproduce it=20
here.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2414696.AhqelC3jCY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmHV1sACgkQdNbfk+86fC2EaACfV77K/e7VKm1G+m7ub2Rurb2V
8hUAn1/ofl1rZVu6S317Atr12Od7P+ez
=Nxjm
-----END PGP SIGNATURE-----

--nextPart2414696.AhqelC3jCY--
