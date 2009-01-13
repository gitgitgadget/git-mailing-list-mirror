From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH 3/3] Adds a #!bash to the top of bash completions so that editors can recognize, it as a bash script. Also adds a few simple comments above commands that, take arguments. The comments are meant to remind editors of potential, problems that can occur when the script is sourced on systems with "set, -u."
Date: Tue, 13 Jan 2009 14:03:11 -0600
Message-ID: <200901131403.16012.bss@iguanasuicide.net>
References: <496CBD17.3000207@tedpavlic.com> <20090113164518.GS10179@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1753199.ekpEeZU6h4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 21:04:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMpUW-00085K-Vz
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 21:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757198AbZAMUCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 15:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756851AbZAMUCj
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 15:02:39 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:50399 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756279AbZAMUCg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 15:02:36 -0500
Received: from [206.104.163.94]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMpT7-0000dK-Gm; Tue, 13 Jan 2009 20:02:33 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <20090113164518.GS10179@spearce.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105526>

--nextPart1753199.ekpEeZU6h4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2009 January 13 10:45:18 Shawn O. Pearce wrote:
>See [...] how the subject is a niceshort, one
>line summary of the module impacted and the change?

My rule for this is absolutely no more than 80 characters.  Generally, you=
=20
wouldn't want more than 60 or so, since it is used as the Subject: header a=
nd=20
generally has some prefix added.

As shown says, details can go in the rest of the commit message.  If you ar=
e=20
using more than 60-80 characters even without details, you might think abou=
t=20
splitting the patch.

>This is all based on the formatting at the time of commit.
>Anything up to the first "\n\n" in a commit message goes into the
>email subject line.

IIRC, multiple "-m" options to "git commit" will be separated by "\n\n", so=
=20
that's one way to do it if you don't like your $EDITOR for some reason.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1753199.ekpEeZU6h4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkls84QACgkQdNbfk+86fC0ndQCfTNrht2T6WLq1ue2Y1mljnYPx
PFkAnjrQ7YMuwqLzOZRfMPzye+qE4+ir
=X8S+
-----END PGP SIGNATURE-----

--nextPart1753199.ekpEeZU6h4--
