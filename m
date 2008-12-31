From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Wed, 31 Dec 2008 09:14:25 -0600
Message-ID: <200812310914.25779.bss@iguanasuicide.net>
References: <BB5F02FD3789B54E8964D38D6775E718242D36@ALTMORE-SVR.altmore.local> <200812302141.02248.bss@iguanasuicide.net> <7v7i5hymp7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2783858.9JSClHkYoQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Conor Rafferty" <conor.rafferty@altmore.co.uk>,
	"Jeff Whiteside" <jeff.m.whiteside@gmail.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 16:16:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI2oa-0008Su-29
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 16:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbYLaPO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 10:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbYLaPO2
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 10:14:28 -0500
Received: from eastrmmtao103.cox.net ([68.230.240.9]:46749 "EHLO
	eastrmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbYLaPO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 10:14:27 -0500
X-Greylist: delayed 133244 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Dec 2008 10:14:27 EST
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081231151428.LAXD18445.eastrmmtao103.cox.net@eastrmimpo03.cox.net>;
          Wed, 31 Dec 2008 10:14:28 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id xrES1a0032i4SyG02rESbb; Wed, 31 Dec 2008 10:14:26 -0500
X-Authority-Analysis: v=1.0 c=1 a=9f81XiW3As4A:10 a=jo3Ua4_GZn8A:10
 a=Fq1VQ0LPAAAA:8 a=gDasAThQWZADh8aGZIMA:9 a=LpdXce83YFb0sHCgnUVFuSug_Y8A:4
 a=qIVjreYYsbEA:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=FvJnvPXeic7SlDz_5HMA:9 a=bHWxRHOReWlq3YAPrp4hDHr9m2oA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LI2m9-0005jf-Qy; Wed, 31 Dec 2008 09:14:25 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <7v7i5hymp7.fsf@gitster.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104273>

--nextPart2783858.9JSClHkYoQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 30 December 2008, Junio C Hamano <gitster@pobox.com> wrote=20
about 'Re: for newbs =3D little exercise / tutorial / warmup for windows an=
d=20
other non-sophisticated new Git users :-) [Scanned]':
>"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:
>> "git checkout <branch> <paths>" is similar to "hg revert -r <branch>
>> <paths>",
>
>No it is not.
>
>The form of the command is makes this request:
>
>    Please look into that named <tree-ish>, and check out the named
>    <paths> out of it to my work tree.

That seems similar to "hg revert":
Using the -r option, revert the given files or directories to their
contents as of a specific revision.

>    Because the reason I want them in=20
>    my work tree is so that I can include them as part of the next commit
>    I am preparing to create in the index, please update these paths in
> my index while at it.

This part is odd to me, but does make some sense.  I can only think of a=20
few reasons to retrieve a file from a different tree-ish without=20
immediately turning around and doing "git add <bar>".
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2783858.9JSClHkYoQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklbjFEACgkQ55pqL7G1QFkiHgCfQq50IyWvsURDGKF2UzCTIU1A
ggYAn3vSsoVlEWCUQWd5snmw42HELOw1
=bKpm
-----END PGP SIGNATURE-----

--nextPart2783858.9JSClHkYoQ--
