From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] doc/bundle: Use the more conventional suffix '.bundle'
Date: Sat, 7 Feb 2009 23:02:36 -0600
Message-ID: <200902072302.36991.bss@iguanasuicide.net>
References: <1234045309-3626-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart17915141.pa0W549bP3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 06:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW1pz-0007JX-Sm
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 06:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbZBHFCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 00:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbZBHFCk
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 00:02:40 -0500
Received: from eastrmmtao105.cox.net ([68.230.240.47]:33550 "EHLO
	eastrmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbZBHFCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 00:02:39 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090208050237.SLTX4139.eastrmmtao105.cox.net@eastrmimpo01.cox.net>;
          Sun, 8 Feb 2009 00:02:37 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id DH2d1b0062i4SyG02H2eeK; Sun, 08 Feb 2009 00:02:38 -0500
X-Authority-Analysis: v=1.0 c=1 a=ryI2rUtTaDEA:10 a=VIyw5D3L1boA:10
 a=Fq1VQ0LPAAAA:8 a=am_7ZdcTVRxmYrirEVkA:9 a=7hJm_khb0Hdzzb2KBSAA:7
 a=kpp93ewIOCOiTD9O5kpyJ9_Gh84A:4 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=ZjyxaH7FFjwnLaCn_oYA:9 a=ZV_vEqQuVaFkdoaKbDfuVcnFuZYA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LW1oT-000FBa-3c; Sat, 07 Feb 2009 23:02:37 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <1234045309-3626-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108921>

--nextPart17915141.pa0W549bP3
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 07 February 2009 16:21:49 Santi B=C3=A9jar wrote:
> Although it does not matter in general it is handled different by
> "git clone", as it removes it to make the "humanish" name of the
> new repository.

I'm mixed on this, particularly with the increasing numbers of MySysGit use=
rs=20
we attract.  Perhaps it would be better to teach clone to remove .bdl as we=
ll.

General Query:
Is the bundle format stable enough to register a MIME-type (and associated=
=20
extensions)?
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart17915141.pa0W549bP3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmOZ2wACgkQ55pqL7G1QFl+OACfVMjYbYuzc9mh8FnVozgASMvU
luIAn3UhCbYtXnwgVAtvOy2A2n7YsSIj
=cKuL
-----END PGP SIGNATURE-----

--nextPart17915141.pa0W549bP3--
