From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Mon, 19 Jan 2009 13:06:49 -0600
Message-ID: <200901191306.49979.bss@iguanasuicide.net>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch> <20090119172939.GA14053@spearce.org> <46a038f90901191000i250326e7k2184c149b70fcc8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1570802.xEHSq468qn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 20:26:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOzT4-0004GH-A2
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 20:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbZASTGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 14:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbZASTGA
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 14:06:00 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:34279 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbZASTGA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 14:06:00 -0500
Received: from [206.104.167.41]
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LOzRe-0000EJ-Tn; Mon, 19 Jan 2009 19:05:58 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <46a038f90901191000i250326e7k2184c149b70fcc8d@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106384>

--nextPart1570802.xEHSq468qn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 2009 January 19 12:00:10 Martin Langhoff wrote:
>On Mon, Jan 19, 2009 at 12:29 PM, Shawn O. Pearce <spearce@spearce.org>=20
wrote:
>> ...  If we had
>> an inotify sort of daemon to keep the data current so the prompt
>> doesn't have to stat every source file on every display it would
>> be reasonable, but we don't have such a thing yet for Git.
>
>[T]he kernel's cache will outperform any userland
>attempting to keep track of the fs via inotify.

Really?  Why have inotify then?  I thought its only purpose is "to keep tra=
ck=20
of the fs".  If it is never a net win, why even use/provide it?
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1570802.xEHSq468qn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl0z0kACgkQdNbfk+86fC1gtACfcFQmF98UE2hB+n0fSAqXhzbI
HxcAnjOlGuVGJBvqMi0BexoHIoawMj8L
=t0ye
-----END PGP SIGNATURE-----

--nextPart1570802.xEHSq468qn--
