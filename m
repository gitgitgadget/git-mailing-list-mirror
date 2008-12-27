From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: commit.template
Date: Fri, 26 Dec 2008 19:48:52 -0600
Message-ID: <200812261948.58032.bss@iguanasuicide.net>
References: <200812261853.55464.bss@iguanasuicide.net> <874p0qsa2h.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9927329.eOuc3BI3GB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sat Dec 27 02:50:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGOJq-0000lL-2V
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 02:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbYL0Bsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 20:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbYL0Bsk
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 20:48:40 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:52138 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbYL0Bsj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 20:48:39 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LGOIA-0008Gj-He; Sat, 27 Dec 2008 01:48:38 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <874p0qsa2h.fsf@jidanni.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103979>

--nextPart9927329.eOuc3BI3GB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 2008 December 26 19:04:06 jidanni@jidanni.org wrote:
> OK, but there should be a reference to any %escapes available in
> templates, etc.

There are none, at least not right now.

> Or say the template is purely and additional ".signature" style file
> that will be inserted at some certain spot...

There's what it says:
"Use the contents of the given file as the initial version of the
commit message. The editor is invoked and you can make subsequent
changes. [...] This overrides the commit.template
configuration variable."
	-- 'git commit --help'

What isn't clear about that?  It's not an *extra* file; it is the template=
=20
(what you start with) for commit messages.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart9927329.eOuc3BI3GB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklViYoACgkQdNbfk+86fC172ACfXQgEW7+50pUqhB9tFhAcQCCT
UUAAn2JZCjKW8suIoWIfIv29S5xNArBi
=djJz
-----END PGP SIGNATURE-----

--nextPart9927329.eOuc3BI3GB--
