From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC 0/6] sort tags by date (git tag -l -D)
Date: Mon, 23 Feb 2009 10:11:51 +0100
Message-ID: <200902231011.54574.trast@student.ethz.ch>
References: <e29894ca0902221006s1c1af9f9o8c13ff9e06670d95@mail.gmail.com> <200902231004.25784.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart308866485.jO7IGpsXAk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "=?utf-8?q?Marc-Andr=C3=A9?= Lureau" <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 10:13:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbWsb-0001Bg-9Z
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 10:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbZBWJMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 04:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbZBWJMI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 04:12:08 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:38140 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbZBWJMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 04:12:07 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Feb 2009 10:12:05 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 23 Feb 2009 10:12:05 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <200902231004.25784.trast@student.ethz.ch>
X-OriginalArrivalTime: 23 Feb 2009 09:12:05.0079 (UTC) FILETIME=[CBA1EE70:01C99596]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111125>

--nextPart308866485.jO7IGpsXAk
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> Marc-Andr=E9 Lureau wrote:
> > I needed to sort my tags by date, and not only the annotated tags.
>=20
> As others have pointed out, there's no sane way to sort
=2E.. lightweight tags of blobs or trees.

*sigh*

Also, do not take my shell command to mean that I don't like this
series.  It would be nice to have a porcelain feature for it.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart308866485.jO7IGpsXAk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmiaFoACgkQqUud07tmzP1rNACgnW3pimAUxT7b7+7HSGs4k4d0
Vz4Anjnba+4Km6QMZ1veYQA7NMT3cXH6
=9w6F
-----END PGP SIGNATURE-----

--nextPart308866485.jO7IGpsXAk--
