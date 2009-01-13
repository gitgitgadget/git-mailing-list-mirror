From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: git/webdav is refusing to authenticate properly.
Date: Mon, 12 Jan 2009 19:53:15 -0600
Message-ID: <200901121953.16183.bss@iguanasuicide.net>
References: <137c54e10901121354l284f11ag675abb003fc83e93@mail.gmail.com> <alpine.DEB.1.00.0901130003490.3586@pacific.mpi-cbg.de> <496BE1E0.9010908@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1544254.3pxXQcpkyP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Spierenburg <ionlyusethisaddressforlists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMYUN-0006SR-NT
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 02:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbZAMBxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 20:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753602AbZAMBxT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 20:53:19 -0500
Received: from eastrmmtao105.cox.net ([68.230.240.47]:50609 "EHLO
	eastrmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbZAMBxS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 20:53:18 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090113015317.SBZD4139.eastrmmtao105.cox.net@eastrmimpo03.cox.net>;
          Mon, 12 Jan 2009 20:53:17 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 2ptG1b00K2i4SyG02ptHgu; Mon, 12 Jan 2009 20:53:17 -0500
X-Authority-Analysis: v=1.0 c=1 a=YCmOk6km9xMA:10 a=NEuutZkdHscA:10
 a=Fq1VQ0LPAAAA:8 a=9s7QVCMrmdqOmRW7i1wA:9 a=VYcHS6hOEo6o5gHsQUGs4zM7i_cA:4
 a=oxVw0hCxh30A:10 a=MSl-tDqOz04A:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=rGYsbNlBCWO13mK0pXUA:9 a=LAwQRtXjrMG9XvX58ywyxDCkyNQA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LMYSy-000PWs-9q; Mon, 12 Jan 2009 19:53:16 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <496BE1E0.9010908@gmail.com>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105439>

--nextPart1544254.3pxXQcpkyP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 12 January 2009, Peter Spierenburg=20
<ionlyusethisaddressforlists@gmail.com> wrote about 'Re: git/webdav is=20
refusing to authenticate properly.':
>C'mon, leave my password 'in-the-clear', in a text file on a networked
>box? That is the kind of prank a fourth-year student would try to pull
>on a freshman.
>
>How do I really do it?

AFAIK, that's the only way for now.

Personally, I'd welcome a patch that allowed fetch/push to prompt the user=
=20
for a password, but I'm not holding my breath.  If I want to limit access=20
to a few users, I serve that repository over ssh and depend on ssh for=20
authentication and filesystem permissions for authorization.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1544254.3pxXQcpkyP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklr9AwACgkQ55pqL7G1QFlxOACfbZnVFV55Wea9l2XffpJEjDri
TQIAnijtczyuK0ei61/9ZpSSOYESWTjR
=3ZMW
-----END PGP SIGNATURE-----

--nextPart1544254.3pxXQcpkyP--
