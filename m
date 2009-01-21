From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] color-words: Support diff.color-words config option
Date: Wed, 21 Jan 2009 10:09:35 -0600
Message-ID: <200901211009.36081.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901202146.58651.bss@iguanasuicide.net> <alpine.DEB.1.00.0901210923580.7929@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8113742.CK0vDe3LjE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 17:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPfff-0008J9-VD
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 17:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbZAUQJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 11:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbZAUQJm
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 11:09:42 -0500
Received: from eastrmmtao107.cox.net ([68.230.240.59]:53342 "EHLO
	eastrmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbZAUQJl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 11:09:41 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090121160937.XAQG23750.eastrmmtao107.cox.net@eastrmimpo01.cox.net>;
          Wed, 21 Jan 2009 11:09:37 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id 6G9c1b00A2i4SyG02G9cKv; Wed, 21 Jan 2009 11:09:37 -0500
X-Authority-Analysis: v=1.0 c=1 a=t9CT8Fk1vxQA:10 a=n34bIBn4snMA:10
 a=Fq1VQ0LPAAAA:8 a=5wJBXZkotYWQqA4tibEA:9 a=hxa0U61fqA3eU7KZKut0pXa2ni4A:4
 a=_RhRFcbxBZMA:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=3tYdKgcdDdftEZxqGagA:9 a=Ajhu2DkEwvPIgNYWfpZ6AL2GsXIA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LPfe4-000P4V-6a; Wed, 21 Jan 2009 10:09:36 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901210923580.7929@racer>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106622>

--nextPart8113742.CK0vDe3LjE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 21 January 2009, Johannes Schindelin=20
<Johannes.Schindelin@gmx.de> wrote about 'Re: [PATCH] color-words: Support=
=20
diff.color-words config option':
>On Tue, 20 Jan 2009, Boyd Stephen Smith Jr. wrote:
>> I'm not entirely satisfied with it.  There should probably be some way
>> to force the default behavior (which is a bit faster) even if a global
>> config or diff driver exists.  Also, I think camelCase is better than
>> runtogether so I'd prefer to change "wordregex" -> "wordRegex" across
>> the entire patch set.
>
>Well, the thing is, it _should_ be "wordRegex", _except_ in the strcmp()
>because the config helpers get a downcased key.

It would have been nice to know that last night.  I spent far longer than I=
=20
should have on the "wordregex" -> "wordRegex" patch.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart8113742.CK0vDe3LjE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl3SMAACgkQ55pqL7G1QFl09QCfeNy/zaNv4lVs2DFd1gRQY5JD
TjsAnjY1ISAZGBdrlXtu5+15hTDwT6l6
=yA+R
-----END PGP SIGNATURE-----

--nextPart8113742.CK0vDe3LjE--
