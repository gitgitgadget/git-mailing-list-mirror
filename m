From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Wed, 14 Jan 2009 23:11:32 +0100
Message-ID: <200901142311.37342.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <200901142059.09005.trast@student.ethz.ch> <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart88001939.kMxFpJkXoA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 23:13:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNDyk-0003EC-IP
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbZANWLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755555AbZANWLX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:11:23 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:12982 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519AbZANWLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:11:22 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:11:20 +0100
Received: from [192.168.0.3] ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:11:20 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Jan 2009 22:11:20.0540 (UTC) FILETIME=[078919C0:01C97695]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105711>

--nextPart88001939.kMxFpJkXoA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> Which reminds me... should we activate REG_EXTENDED by default?

We (you :-) do, and I think so.  Consider that funcname is not even
documented any more, in favour of xfuncname.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart88001939.kMxFpJkXoA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkluYxkACgkQqUud07tmzP2AmACfU8AGWyNUcxehCeqwhPFucnQw
6yUAn1K64SY0LLop7V6H6AQzYyJ+SQB/
=O8i9
-----END PGP SIGNATURE-----

--nextPart88001939.kMxFpJkXoA--
