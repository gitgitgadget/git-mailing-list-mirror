From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: ignored files stilll listed in git ls-files
Date: Wed, 4 Mar 2009 19:41:55 -0600
Message-ID: <200903041941.55693.bss@iguanasuicide.net>
References: <53e35fd50903041731v1a3c10c9sbb9295f322a819ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2619106.tkkvT1mrFH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: David Shen <davidshen84@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 02:43:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf2cU-0001J5-4J
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 02:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbZCEBmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 20:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbZCEBmA
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 20:42:00 -0500
Received: from eastrmmtao103.cox.net ([68.230.240.9]:39551 "EHLO
	eastrmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbZCEBl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 20:41:59 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090305014157.HGRA11476.eastrmmtao103.cox.net@eastrmimpo03.cox.net>;
          Wed, 4 Mar 2009 20:41:57 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id PDhw1b0052i4SyG02Dhw7z; Wed, 04 Mar 2009 20:41:57 -0500
X-Authority-Analysis: v=1.0 c=1 a=KtRaMN0YvjIA:10 a=-PnpIfyR764A:10
 a=Fq1VQ0LPAAAA:8 a=s7AGbQyKB7oTQqRtsX4A:9 a=Mbic9PruA2E8qKFyNhgA:7
 a=FlJoXr5z1qk5uy4TfEqT8RzV1SYA:4 a=LY0hPdMaydYA:10 a=T3brmoaXcPoA:10
 a=m2EcmGflS-wMVfnHNTsA:9 a=JsaT86pRIVdYXZfy5e_6Rcj60nMA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1Lf2ax-0004P0-O7; Wed, 04 Mar 2009 19:41:55 -0600
User-Agent: KMail/1.11.1 (Linux/2.6.26-1-amd64; KDE/4.2.1; x86_64; ; )
In-Reply-To: <53e35fd50903041731v1a3c10c9sbb9295f322a819ce@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112254>

--nextPart2619106.tkkvT1mrFH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 04 March 2009 19:31:55 you wrote:
> I add all the files to git before I learned the .gitignore file. Then
> I remove those unwanted files from the index. But those files still
> appear in git ls-files. This is really annoying. Is there any want to
> prevent those ignored files from git ls-files?

git filter-branch
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart2619106.tkkvT1mrFH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmvLeMACgkQ55pqL7G1QFk9BACfcGwW3nohcQXQCP/XDHSEJYN5
EHMAn2oGH+s2VL98eybQpo5ojsGYX5ny
=uzeS
-----END PGP SIGNATURE-----

--nextPart2619106.tkkvT1mrFH--
