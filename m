From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: General question about minimal documentation patches
Date: Sat, 7 Jun 2008 00:46:04 +0200
Message-ID: <20080606224604.GE31040@leksak.fem-net>
References: <4849B8E8.1090506@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?iso-8859-1?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat Jun 07 00:47:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4kim-0001MW-Bb
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 00:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099AbYFFWqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 18:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbYFFWqW
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 18:46:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:44150 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753799AbYFFWqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 18:46:21 -0400
Received: (qmail invoked by alias); 06 Jun 2008 22:46:19 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp025) with SMTP; 07 Jun 2008 00:46:19 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+pgec/lvupTS9aLECoz/wdtH0Fs01kuvCe9u3yZC
	QtGwo171cAnWw6
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K4khA-0005q0-Sc; Sat, 07 Jun 2008 00:46:04 +0200
Content-Disposition: inline
In-Reply-To: <4849B8E8.1090506@dirk.my1.cc>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84127>


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> Do you mind if people submit _very_ minimal patches for the
> docs that fix only some typing errors or the like? I, personally,
> am a friend of correct spelling and such and when I discover
> such errors I prefer to have them fixed.

I don't see a reason why tiny documentation fixes (be it typos or not)
should be less important than tiny feature code fixes,
so imho it is totally ok ;-)

Out of curiosity I looked for typo-only fixes in git, and found:
88f6dbaf99f43053f86474b28beedd91e77c64d9
	builtin-apply: typofix
e77b0b5d0fdac411607dbae11ccad87dccd332d3
	git-am: fix typo in usage message
ed020917147ca733477a0186f3bb1791ec6e5b5c
	Documentation/git-web--browse.txt: fix small typo
51836e9e125f67aa26724154757b4734c08057e4
	Documentation/git-submodule: typofix
ca593f795994badf7cd543d24d1ed24aabc0d8e1
	Documentation/git-request-pull: Fixed a typo ("send" -> "end")
and so on ;-)

What I want to say: just send the patches in ;-)

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFISb4sbt3SB/zFBA8RAqkJAKCzNxWbaCiwbgPL7Z/ieseAoGlrIQCfW/UH
hm8TmkSxRr2VxpmYwFKvYb4=
=upxC
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
