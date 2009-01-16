From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Fri, 16 Jan 2009 20:04:29 +0100
Message-ID: <200901162004.32557.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <adf1fd3d0901160102y32a08e26q96728495fc0b6fcf@mail.gmail.com> <adf1fd3d0901160401s7a363076x1bcd8e90db4f56a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1579019.bPuNfdvNSL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 20:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNu0z-0002JN-Nt
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 20:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761977AbZAPTET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 14:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756191AbZAPTES
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 14:04:18 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:20692 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760346AbZAPTER (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 14:04:17 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 20:04:15 +0100
Received: from [192.168.0.3] ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 20:04:14 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <adf1fd3d0901160401s7a363076x1bcd8e90db4f56a1@mail.gmail.com>
X-OriginalArrivalTime: 16 Jan 2009 19:04:14.0974 (UTC) FILETIME=[396729E0:01C9780D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart1579019.bPuNfdvNSL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Santi B=E9jar wrote:
> Hi,
>=20
>   can you both provide a public repository to be able to test the
> lastest version without having to search and apply them?

I set up a clone at

  git://repo.or.cz/git/trast.git

The respective topics are js/word-diff-p1 and tr/word-diff-p2.  For
your testing convenience, there are master/next branches that merge
tr/word-diff-p2 to Junio's master/next.  I *think* I should have
gathered all squashes from Dscho, too.

The tip commit has some tweaks to the builtin regexes that aren't in
any mailed version yet; I'll resend RSN.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1579019.bPuNfdvNSL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklw2kAACgkQqUud07tmzP1PPgCggBcpBCWGbaUxP353I/B+aunR
mtEAnje/dh921DIVveHlykgouCuF89ix
=Ii9j
-----END PGP SIGNATURE-----

--nextPart1579019.bPuNfdvNSL--
