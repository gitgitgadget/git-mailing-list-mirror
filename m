From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Thu, 18 Dec 2008 21:29:00 -0600
Message-ID: <200812182129.01021.bss@iguanasuicide.net>
References: <200812182039.15169.bss@iguanasuicide.net> <alpine.DEB.1.00.0812190353520.14632@racer> <7vej04eui5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2043901.NGxQA4X6jE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alan <alan@clueserver.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 04:30:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDW3z-0004op-Jc
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 04:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYLSD2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 22:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYLSD2t
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 22:28:49 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:33445 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYLSD2s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 22:28:48 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LDW2g-00068D-0p; Fri, 19 Dec 2008 03:28:46 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <7vej04eui5.fsf@gitster.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103536>

--nextPart2043901.NGxQA4X6jE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 2008 December 18 21:03:46 Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 			warning("revert on a merge commit may not do what you "
> > 				"expect.");
>
> [T]he new warning does
> not give you enough clue where to go next, so this warning does not give
> real value.  It is pretty much meaningless noise to users.

At least, it might make someone read the manpage again.  Still, I'm unhappy=
=20
with the message, but I didn't want to be too wordy.  A URL or manpage=20
reference would be nice, but I didn't know of a good guide that explained t=
he=20
dangers of reverting a merge commit as well as Linus's emails.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2043901.NGxQA4X6jE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklLFP0ACgkQdNbfk+86fC1cTQCfZbcziniN6T0/6KSxH5wtzuAj
5FgAn1rdzlMOBpI5Kq2iOpkCKqEIl2Cf
=0ui6
-----END PGP SIGNATURE-----

--nextPart2043901.NGxQA4X6jE--
