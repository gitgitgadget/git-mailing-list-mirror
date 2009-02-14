From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 0/2] git notes show: handle empty notes gracefully
Date: Sat, 14 Feb 2009 18:46:36 +0100
Message-ID: <200902141846.49961.trast@student.ethz.ch>
References: <1233937075-31194-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1302308.HUHS9bcQOp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 18:51:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYOfR-0005gh-KP
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 18:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbZBNRrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 12:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbZBNRq7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 12:46:59 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:8944 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbZBNRq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 12:46:59 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 18:46:58 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 18:46:57 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <1233937075-31194-1-git-send-email-git@drmicha.warpmail.net>
X-OriginalArrivalTime: 14 Feb 2009 17:46:57.0412 (UTC) FILETIME=[3B2E1C40:01C98ECC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109885>

--nextPart1302308.HUHS9bcQOp
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Michael J Gruber wrote:
> Michael J Gruber (2):
>   git notes show: test empty notes
>   handle empty notes gracefully

Tested-by: Thomas Rast <trast@student.ethz.ch>

The previous message was especially annoying because it would fire up
the pager on narrow terminals.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1302308.HUHS9bcQOp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmXA4kACgkQqUud07tmzP3GKQCglFoZKz2eHg/+DJD+RoC176oZ
sxEAnRPip+6X9qfNDr2t4wHv6p+5phuH
=r8bQ
-----END PGP SIGNATURE-----

--nextPart1302308.HUHS9bcQOp--
