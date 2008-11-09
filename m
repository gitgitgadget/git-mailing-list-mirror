From: Kai Blin <kai@samba.org>
Subject: Re: How it was at GitTogether'08 ?
Date: Sun, 9 Nov 2008 16:36:51 +0100
Message-ID: <200811091636.55343.kai@samba.org>
References: <200811080254.53202.jnareb@gmail.com> <ee77f5c20811072108o21f97c97i8174f4f7ecd67030@mail.gmail.com> <200811081631.06229.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1415412.RkbMGv8TVr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "David Symonds" <dsymonds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 17:03:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzCl8-0003sk-HX
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 17:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287AbYKIQCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 11:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755282AbYKIQCJ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 11:02:09 -0500
Received: from mail.samba.org ([66.70.73.150]:43490 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755194AbYKIQCI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 11:02:08 -0500
X-Greylist: delayed 1509 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Nov 2008 11:02:08 EST
Received: from ip6-localhost (localhost [127.0.0.1])
	by lists.samba.org (Postfix) with ESMTP id 398D2163A72;
	Sun,  9 Nov 2008 15:36:46 +0000 (GMT)
User-Agent: KMail/1.9.10
In-Reply-To: <200811081631.06229.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100454>

--nextPart1415412.RkbMGv8TVr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 08 November 2008 16:31:04 Jakub Narebski wrote:

> > > * Tim: Git as a Media Repository
> > >  http://www.thousandparsec.net/~tim/media+git.pdf
> >
> > This has kicked off some mailing list discussion; I think this can be
> > a major weak point for git, since checking out only a subtree (and
> > only the latest revision) is the common SVN way, which copes with
> > media repositories and the like just fine.
>
> Well, you can workaround this weakness by (ab)using submodules...
> ...and one should always remember that casual partial checkouts
> interfere a bit with whole-tree commits.

Interesting. How would you use submodules to work around the fact that bina=
ry=20
file changes diff very bad and produce huge histories with basically no val=
ue=20
for the user of the working copy? Can you do this from a GUI, easily? We're=
=20
talking about media repositories here, so our users are artists.

Cheers,
Kai


=2D-=20
Kai Blin
WorldForge developer  http://www.worldforge.org/
Wine developer        http://wiki.winehq.org/KaiBlin
Samba team member     http://www.samba.org/samba/team/
=2D-
Will code for cotton.

--nextPart1415412.RkbMGv8TVr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBJFwOXEKXX/bF2FpQRAnwYAJ9G+F9n2SAxSSQO8VONV+oQcpZuawCfZSiI
ajjhonG/kJeyowlo22zvixs=
=NfhN
-----END PGP SIGNATURE-----

--nextPart1415412.RkbMGv8TVr--
