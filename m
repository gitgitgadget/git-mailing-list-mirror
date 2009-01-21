From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 13:09:09 -0600
Message-ID: <200901211309.10120.bss@iguanasuicide.net>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com> <20090121161940.GA20702@coredump.intra.peff.net> <alpine.LNX.1.00.0901211237530.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4819539.17cpyvhGVe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:12:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiTG-0002VZ-Uj
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbZAUTJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbZAUTJO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:09:14 -0500
Received: from eastrmmtao107.cox.net ([68.230.240.59]:34875 "EHLO
	eastrmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZAUTJM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:09:12 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090121190911.BISJ23750.eastrmmtao107.cox.net@eastrmimpo03.cox.net>;
          Wed, 21 Jan 2009 14:09:11 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 6K9A1b00L2i4SyG02K9BcJ; Wed, 21 Jan 2009 14:09:11 -0500
X-Authority-Analysis: v=1.0 c=1 a=zbplyEFExIwA:10 a=O3HRrzEFWLEA:10
 a=Fq1VQ0LPAAAA:8 a=3Nsdo6Ma0JHttvobUhkA:9 a=RBN8HvAViI3U2evUb72LNRY6YBQA:4
 a=JM1vJQTMoX0A:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=8g4YZJK_KT3MRTnCvVkA:9 a=dugI42Q9AMjjDSVZoE97PjEEYRAA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPiRq-000PyW-7V; Wed, 21 Jan 2009 13:09:10 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LNX.1.00.0901211237530.19665@iabervon.org>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106646>

--nextPart4819539.17cpyvhGVe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 21 January 2009, Daniel Barkalow <barkalow@iabervon.org> wrote=
=20
about 'Re: Deleting remote branch pointed by remote HEAD':
>I think it might be more appropriate to just care less about a broken
>symref, explain what's wrong if the user actually tries to use it, and
>otherwise mostly ignore it.

That sounds reasonable.  It's not like "find" complains about every broken=
=20
symlink it sees.  Simple traversal or the repository should probably not=20
complain about every broken symref.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart4819539.17cpyvhGVe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl3ctYACgkQ55pqL7G1QFnnmgCeKEexcTow28EyMFzwVupuRHFF
oYMAn3J3wrhiFReFQagrgSlYSwYLW0HB
=r8al
-----END PGP SIGNATURE-----

--nextPart4819539.17cpyvhGVe--
