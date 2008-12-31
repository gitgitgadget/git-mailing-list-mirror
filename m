From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 20:56:17 -0600
Message-ID: <200812302056.21748.bss@iguanasuicide.net>
References: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1341295.gxpIAS8DQu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 03:57:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHrGt-0005b7-LJ
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 03:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300AbYLaC4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 21:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755301AbYLaC4E
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 21:56:04 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:33787 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300AbYLaC4D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 21:56:03 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.124])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LHrFY-0005Wd-8K; Wed, 31 Dec 2008 02:56:01 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <BB5F02FD3789B54E8964D38D6775E718242D35@ALTMORE-SVR.altmore.local>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104245>

--nextPart1341295.gxpIAS8DQu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2008 December 30 20:27:26 Conor Rafferty wrote:
> -----Original Message-----
> wtf is wrong with
>
> git checkout <something>
>
> ??
>
> ** It doesn't reliably put the files that were in that revision into the
> working directory - a fairly major flaw, for what I'm using SCM for (and
> 80% of the market IMHO)

And you would be wrong, IMHO.  Many people have untracked files or director=
ies=20
in their working directory ('cause they are working there) that they don't=
=20
want deleted willy-nilly.  Build files, modifications that should be on a=20
different branch, etc.  There's another thread active on the list complaini=
ng=20
that git removes too much from the working tree.

Most users of SCMs do make active modifications to the files in the SCM.  I=
t's=20
not a system only for archiving static projects.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1341295.gxpIAS8DQu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkla31UACgkQdNbfk+86fC12iQCgiVjarLXsdntf2/qEIbh+dYXE
ib4AnA9OP3l3U04QWhUGAeO0VT3TPPpm
=H0v3
-----END PGP SIGNATURE-----

--nextPart1341295.gxpIAS8DQu--
