From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Re: Minor grammar fix in the 'Not a git repository' message
Date: Mon, 16 Feb 2009 21:16:54 -0600
Message-ID: <200902162116.55484.bss@iguanasuicide.net>
References: <cover.1234825069u.git.johannes.schindelin@gmx.de> <20090217001747.GA23278@vidovic> <7vk57pevig.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6237755.WcY6g0UCze";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 04:18:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZGTa-0008O1-8d
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 04:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbZBQDQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 22:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbZBQDQ6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 22:16:58 -0500
Received: from eastrmmtao103.cox.net ([68.230.240.9]:47914 "EHLO
	eastrmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZBQDQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 22:16:57 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090217031656.KRCU11476.eastrmmtao103.cox.net@eastrmimpo03.cox.net>;
          Mon, 16 Feb 2009 22:16:56 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id GrGw1b0012i4SyG02rGwfV; Mon, 16 Feb 2009 22:16:56 -0500
X-Authority-Analysis: v=1.0 c=1 a=xPHVcWJkFhcA:10 a=Ix2_u3lu_EMA:10
 a=Fq1VQ0LPAAAA:8 a=PCGKjU8y9NP-xFLcfxkA:9 a=UjRPSm7fzCbcK1rfHE5T1jN_1XIA:4
 a=yvZ1BPFDISIA:10 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10
 a=rqL2XWXoeu9F2CRjXIsA:9 a=EZ6bHZezPD8Pjp3SsDTqhzDiUjAA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LZGS7-000DwL-Ju; Mon, 16 Feb 2009 21:16:55 -0600
User-Agent: KMail/1.11.0 (Linux/2.6.26-1-amd64; KDE/4.2.0; x86_64; ; )
In-Reply-To: <7vk57pevig.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110303>

--nextPart6237755.WcY6g0UCze
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 16 February 2009 18:51:03 Junio C Hamano wrote:
> Nicolas Sebrecht <nicolas.s-dev@laposte.net> writes:
> > The message
> > 	"Not inside a git repository"
> > of Wincent looks like the clearest and the fairest one.
>
> I tend to agree.  I was only trying to see if we can salvage a more
> precise diagnosis f66bc5f (Always show which directory is not a git
> repository, 2008-12-22) tried to give users.

"Not in a git repository or work tree: %s", DEFAULT_GIT_DIR_ENVIRONMENT
?
=2D-=20
Boyd Stephen Smith Jr.                   ,=3D ,-_-. =3D.
bss@iguanasuicide.net                   ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy         `-'(. .)`-'
http://iguanasuicide.net/                    \_/


--nextPart6237755.WcY6g0UCze
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmaLCcACgkQ55pqL7G1QFlG7wCfeGwQ/9G6WbyWP1VQXIWgmZf0
nzgAn2NcOopOA0Jli51MDz+8Rc4bKbKP
=IH8l
-----END PGP SIGNATURE-----

--nextPart6237755.WcY6g0UCze--
