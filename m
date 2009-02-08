From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Enable setting attach in .gitconfig for git-format-patch.
Date: Sat, 7 Feb 2009 22:50:53 -0600
Message-ID: <200902072250.53902.bss@iguanasuicide.net>
References: <498E038F.3090704@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3303469.dthkn9RTy2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 05:54:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW1gx-0005tZ-Vs
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 05:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbZBHEu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 23:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbZBHEu5
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 23:50:57 -0500
Received: from eastrmmtao106.cox.net ([68.230.240.48]:36201 "EHLO
	eastrmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbZBHEu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 23:50:56 -0500
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090208045056.MZTI18213.eastrmmtao106.cox.net@eastrmimpo02.cox.net>;
          Sat, 7 Feb 2009 23:50:56 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo02.cox.net with bizsmtp
	id DGqu1b00C2i4SyG02GquUY; Sat, 07 Feb 2009 23:50:55 -0500
X-Authority-Analysis: v=1.0 c=1 a=PVR-C2e-d28A:10 a=9ODD1XI32d0A:10
 a=Fq1VQ0LPAAAA:8 a=9-1z3q9W1nM_A-PLKHkA:9 a=p00q24XIZlTKucR5HZeKrkjp0j4A:4
 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10 a=dUki85ESELrxuljrNVUA:9
 a=vSO87M7VUac8drd6oUkV5EaXB04A:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LW1d8-000F7C-0E; Sat, 07 Feb 2009 22:50:54 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <498E038F.3090704@codeweavers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108919>

--nextPart3303469.dthkn9RTy2
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 07 February 2009 15:56:31 Jeremy White wrote:
> +static char *extra_attach =3D NULL;

The initializer is just noise here, yes?  If the " =3D NULL" is not needed,=
 we=20
generally drop it.
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart3303469.dthkn9RTy2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmOZK0ACgkQ55pqL7G1QFkJ8wCfb99ljJ7vYjkClG5rZdD4erOK
cgsAnR+eI5MoPtzSVh/nPW+QmvzAqnvt
=dLzO
-----END PGP SIGNATURE-----

--nextPart3303469.dthkn9RTy2--
