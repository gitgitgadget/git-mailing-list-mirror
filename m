From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: turn off "LF will be replaced by CRLF" thingy
Date: Mon, 29 Dec 2008 20:13:07 -0600
Message-ID: <200812292013.12217.bss@iguanasuicide.net>
References: <gjaqta$tg7$4@ger.gmane.org> <alpine.DEB.1.10.0812290928370.15026@asgard.lang.hm> <gjbr5k$r89$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6621018.C89Lpt4env";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Zorba" <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 30 03:34:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHUQt-00029M-PQ
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 03:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbYL3Ccu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 21:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYL3Ccu
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 21:32:50 -0500
Received: from eastrmmtai114.cox.net ([68.230.240.45]:47509 "EHLO
	eastrmmtai114.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbYL3Cct (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 21:32:49 -0500
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081230021343.QDHF3950.eastrmmtao101.cox.net@eastrmimpo02.cox.net>;
          Mon, 29 Dec 2008 21:13:43 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo02.cox.net with bizsmtp
	id xEDi1a0082i4SyG02EDjt7; Mon, 29 Dec 2008 21:13:43 -0500
X-Authority-Analysis: v=1.0 c=1 a=xMYJqRaXwNMA:10 a=KHbNotjZZaoA:10
 a=Fq1VQ0LPAAAA:8 a=ut6pTKq9U--6MmPBOREA:9 a=kdb7xQ-xgo_PhL2Iahq1hJlvGeAA:4
 a=8TgfTs2EN6kA:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=lQdru0G1moTrP1POYnwA:9 a=1S0Onx0yWyUNvimL4aJKdZbKDJcA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LHU6f-000LRV-BK; Mon, 29 Dec 2008 20:13:17 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <gjbr5k$r89$4@ger.gmane.org>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104146>

--nextPart6621018.C89Lpt4env
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 29 December 2008, "Zorba" <cr@altmore.co.uk> wrote about 'Re:=20
turn off "LF will be replaced by CRLF" thingy':
>I'd like to be certain, as 500 out of 5000 files could just get changed
> here !

"git reset" will unstage all your changes.  You can then issue another "git=
=20
add" to stage what you want, and see any warnings or errors.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart6621018.C89Lpt4env
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklZg7QACgkQ55pqL7G1QFlWBwCeMtcxqHR4kxzLvqZOOy/m2nJf
ERwAn22QzOv8P51x56gwXGWsCRPsZqrq
=Fjkq
-----END PGP SIGNATURE-----

--nextPart6621018.C89Lpt4env--
