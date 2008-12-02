From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: [PATCH] Modified the default git help message to be grouped by topic
Date: Tue, 2 Dec 2008 15:33:41 -0600
Message-ID: <200812021533.42114.bss03@volumehost.net>
References: <20081201173037.GA41967@agadorsparticus> <d411cc4a0812012210h4cb59974sbda71abd2c64f93b@mail.gmail.com> <885649360812021211u3d547982i8e1c3070972363e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2034898.y7MW8u74uu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "James Pickens" <jepicken@gmail.com>,
	"Scott Chacon" <schacon@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 22:35:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7cuO-0005AU-91
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 22:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYLBVef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 16:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbYLBVef
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 16:34:35 -0500
Received: from eastrmmtao107.cox.net ([68.230.240.59]:38382 "EHLO
	eastrmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbYLBVee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 16:34:34 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081202213433.RQXA26786.eastrmmtao107.cox.net@eastrmimpo03.cox.net>;
          Tue, 2 Dec 2008 16:34:33 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id mMaY1a0072i4SyG02MaYgo; Tue, 02 Dec 2008 16:34:33 -0500
X-Authority-Analysis: v=1.0 c=1 a=XtNNE2_OhqkA:10 a=bBTrS7EpCHUA:10
 a=nEQGfrJnAAAA:8 a=8JbW3EcZIuVG3hot9EQA:9 a=cPWaZQAX-6C3RmOnLoMA:7
 a=jC8I9CPDd-rXdHb8zBmOca_EBAEA:4 a=MSl-tDqOz04A:10 a=B7iFY6Z7H_gA:10
 a=LY0hPdMaydYA:10 a=KgLcOtmKYNsJaDyuznwA:9 a=VxYq9x35FncOjlbEWXBbPZQfQbYA:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss03@volumehost.net>)
	id 1L7csN-0006kX-4N; Tue, 02 Dec 2008 15:33:47 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <885649360812021211u3d547982i8e1c3070972363e8@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102178>

--nextPart2034898.y7MW8u74uu
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 02 December 2008, "James Pickens" <jepicken@gmail.com> wrote=20
about 'Re: [PATCH] Modified the default git help message to be grouped by=20
topic':
>On Mon, Dec 1, 2008 at 11:10 PM, Scott Chacon <schacon@gmail.com> wrote:
>> I sent a new patch that removes 'rm' and 'mv' and removes the
>> common-cmd.h build process. I did keep the 'status' command, since in
>> my personal experience people tend to like having that command.
>
>Even though 'rm' might not be used very often, I think it's an important
>enough command that it should not be removed from the 'basics' list.
>AFAIK, the only other way to delete a file is 'rm file' followed by 'git
>add -u' or 'git commit -a'.  Imagine a git newbie trying to figure that
>out.
>
>I'm tempted to say the same thing about 'mv' as well.  And FWIW, I use
>'status' a lot more than I use 'diff', so I would vote to keep 'status'
> in the list too.

x2 to all of both paragraphs, except that I'm not just "tempted"; I do say=
=20
that mv should be kept.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss03@volumehost.net                      ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.org/                      \_/    =20

--nextPart2034898.y7MW8u74uu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk1qbYACgkQ55pqL7G1QFklDQCfeiX2kxlCm5xSOy5gGEMjzWa5
xEsAn28iOTZ/QRTVzTKl90ju14Qx2mMy
=7jb4
-----END PGP SIGNATURE-----

--nextPart2034898.y7MW8u74uu--
