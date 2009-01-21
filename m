From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Change the spelling of "wordregex".
Date: Wed, 21 Jan 2009 10:22:22 +0100
Message-ID: <200901211022.24995.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901202259.54886.bss@iguanasuicide.net> <alpine.DEB.1.00.0901210925430.7929@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3127708.vz5A3aBN47";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:23:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPZJB-0008K9-Lq
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 10:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbZAUJWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 04:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbZAUJWK
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 04:22:10 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:57467 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1749667AbZAUJWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 04:22:09 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 21 Jan 2009 10:22:06 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 21 Jan 2009 10:22:06 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0901210925430.7929@racer>
X-OriginalArrivalTime: 21 Jan 2009 09:22:06.0962 (UTC) FILETIME=[BAC03D20:01C97BA9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106584>

--nextPart3127708.vz5A3aBN47
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> And Thomas just imitated "xfuncname", which just so happens to be without=
=20
> an "_".

Then again I ignored the 'x' for "extended regex", so it's not
entirely consistent.

[Mostly because I think the user expects a "<something>" whenever
there's an "x<something>", and "funcname" is actually deprecated/not
documented any more, so introducing a basic-regex version seemed
silly.]

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3127708.vz5A3aBN47
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl26VAACgkQqUud07tmzP1oJQCfaw/nA4/IX/cvInVnkSEJxXtJ
pQcAoJ4mqHLvGT17yRoqndiP2YZ1zAEy
=p/vM
-----END PGP SIGNATURE-----

--nextPart3127708.vz5A3aBN47--
