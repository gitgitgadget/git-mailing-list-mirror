From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Wed, 7 Jan 2009 13:46:32 -0600
Message-ID: <200901071346.41658.bss@iguanasuicide.net>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com> <200901070948.34117.bss@iguanasuicide.net> <slrngm9rdm.gcv.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1592285.SNyUQqE6C0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 20:47:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKeNH-0008E2-KL
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 20:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759571AbZAGTqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 14:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758253AbZAGTqL
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 14:46:11 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:51127 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757325AbZAGTqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 14:46:09 -0500
Received: from [206.104.164.114]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LKeLw-0006Tg-Os; Wed, 07 Jan 2009 19:46:08 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <slrngm9rdm.gcv.sitaramc@sitaramc.homelinux.net>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104823>

--nextPart1592285.SNyUQqE6C0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2009 January 07 12:00:22 Sitaram Chamarty wrote:
> On 2009-01-07, Boyd Stephen Smith Jr. <bss@iguanasuicide.net> wrote:
> > On Wednesday 2009 January 07 04:55:56 you wrote:
> >> So when you say "group", you're saying "0660", and when you
> >> say "0660", you're overriding users umask value.
> >
> > it could just have been the version of git I was using (1.4.4.4, IIRC)
> > -- still using that in at least one place, as it is the current
> > version in Debian Etch.
>
> 1.4.4.4 is 2 years and 2 days old today!  [I've heard
> stories about Debian, but never thought it was this
> conservative!]

Once a stable is released, no new versions of packages come in, only=20
backported bug and security fixes.  The pre-release freeze also limits new=
=20
versions from being considered.  Lenny should be out RSN, so I can move up =
to=20
1.5.6.5. :)

$ apt-cache policy git-core
git-core:
  Installed: 1:1.4.4.4-4
  Candidate: 1:1.4.4.4-4
  Version table:
     1:1.6.0.6-1 0
        300 http://localhost experimental/main Packages
     1:1.5.6.5-2 0
        700 http://localhost testing/main Packages
        500 http://localhost unstable/main Packages
     1:1.5.6.5-1~bpo40+1 0
        800 http://localhost etch-backports/main Packages
 *** 1:1.4.4.4-4 0
        900 http://localhost stable/main Packages
        100 /var/lib/dpkg/status
     1:1.4.4.4-2.1+etch1 0
        900 http://localhost stable/updates/main Packages
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1592285.SNyUQqE6C0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkllBqEACgkQdNbfk+86fC3fHwCbB0JlETnuDVF2FL5erQa8I0NY
q4wAn0LEh8DIJMRD8F4C8YC1s6oJN0h7
=UFCt
-----END PGP SIGNATURE-----

--nextPart1592285.SNyUQqE6C0--
