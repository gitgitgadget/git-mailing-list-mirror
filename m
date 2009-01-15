From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Thu, 15 Jan 2009 14:27:35 +0100
Message-ID: <200901151427.38447.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de> <871vv4soul.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1553120.WvOuAAjYOm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:28:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSHF-0007CL-Hm
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbZAON1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756575AbZAON1X
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:27:23 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:28757 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756283AbZAON1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:27:21 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 14:27:20 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 14:27:19 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <871vv4soul.fsf@iki.fi>
X-OriginalArrivalTime: 15 Jan 2009 13:27:19.0711 (UTC) FILETIME=[FDC112F0:01C97714]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105798>

--nextPart1553120.WvOuAAjYOm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Teemu Likonen wrote:
> Johannes Schindelin (2009-01-15 13:41 +0100) wrote:
>=20
> > Exactly because it works logically, I do not want to change it.  This i=
s=20
> > what the user said, and for a change, it could be what the user meant.
>=20
> I'm just saying that it would be helpful (to me at least) if the man
> page included this advice. Thomas Rast already suggested this in his
> version of the man page change:
>=20
>     You may want to append `|\S` to your regular expression to make sure
>     that it matches all non-whitespace characters.

Dscho requested that I put the extended docs in one of my patches, so
it's currently in

  http://article.gmane.org/gmane.comp.version-control.git/105716

Comments welcome of course.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1553120.WvOuAAjYOm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklvOcoACgkQqUud07tmzP2cCgCbBM4h2xfNE3UEvy9zpDvEd2va
okEAoJBCJmzWwdEY0APyyVePez7aNQEN
=JqpR
-----END PGP SIGNATURE-----

--nextPart1553120.WvOuAAjYOm--
