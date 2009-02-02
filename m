From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] add -p: prompt for single characters
Date: Mon, 2 Feb 2009 09:34:02 +0100
Message-ID: <200902020934.06128.trast@student.ethz.ch>
References: <1233520511-13061-1-git-send-email-trast@student.ethz.ch> <cfbcd2f00902011931h48ef51a4n9badbed9051879ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2441754.qYv3FGEp8x";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Suraj Kurapati <sunaku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 09:35:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTuHF-0008I7-JF
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 09:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbZBBIeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 03:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbZBBIeI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 03:34:08 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:37042 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbZBBIeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 03:34:07 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 09:34:05 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 09:34:04 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <cfbcd2f00902011931h48ef51a4n9badbed9051879ca@mail.gmail.com>
X-OriginalArrivalTime: 02 Feb 2009 08:34:04.0545 (UTC) FILETIME=[01A74F10:01C98511]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108070>

--nextPart2441754.qYv3FGEp8x
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Suraj Kurapati wrote:
> On Sun, Feb 1, 2009 at 12:35 PM, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> >  http://thread.gmane.org/gmane.comp.version-control.git/100146
> >
> > I can't find the v4 promised there, so I assume Suraj dropped it.
>=20
> Yes, I lost the motivation to develop the patch any further.  Sorry.

Ok.

I see Junio has already merged wp/add-patch-find, so I'll rebuild on
top of that and see what needs to be changed.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2441754.qYv3FGEp8x
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmGr/4ACgkQqUud07tmzP3CTQCfTkmw4JjWU3QBfG4QmXriTWSa
UUMAnigRLyWd1JcyhLrPfGil7Tud13oG
=t1Aj
-----END PGP SIGNATURE-----

--nextPart2441754.qYv3FGEp8x--
