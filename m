From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: commit.template
Date: Fri, 26 Dec 2008 17:50:06 -0600
Message-ID: <200812261750.12204.bss@iguanasuicide.net>
References: <20081227070232.6117@nanako3.lavabit.com> <87tz8qsgn2.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4012819.dE4dLUurzE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: jidanni@jidanni.org, nanako3@lavabit.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 00:51:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGMSf-0002wi-AT
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 00:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYLZXtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 18:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbYLZXtz
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 18:49:55 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:44958 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbYLZXty (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 18:49:54 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LGMRF-0008C9-72; Fri, 26 Dec 2008 23:49:53 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <87tz8qsgn2.fsf_-_@jidanni.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103962>

--nextPart4012819.dE4dLUurzE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2008 December 26 16:42:09 jidanni@jidanni.org wrote:
> NS> Didn't you mean "Signed-off-by: =E7=A9=8D=E4=B8=B9=E5=B0=BC <jidanni@=
jidanni.org>"?
>
> No. I want in fact just to use "Signed-off-by: jidanni@jidanni.org",
> but apparently
> 1) man git-config mentions
>        commit.template
>            Specify a file to use as the template for new commit messages.
>
> but doesn't mention what file is being used presently, so one can know
> what to adjust.

git commit --help tells how this configuration option is used, in the=20
documentation of the "-t" option.

> 3) Making a line without a name would probably break other things.

Well, then use your legal name -- unicode is allowed.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart4012819.dE4dLUurzE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklVbbQACgkQdNbfk+86fC3IqQCfRiMgiflx3UNszZTq1TKbMqi6
vd4AnRxZ9ZDXrFlWcs4XDNW9FQo1FyCz
=saTM
-----END PGP SIGNATURE-----

--nextPart4012819.dE4dLUurzE--
