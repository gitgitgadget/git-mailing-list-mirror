From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/RFH] Fun things with git-notes, or: patch tracking backwards
Date: Wed, 11 Feb 2009 23:58:20 +0100
Message-ID: <200902112358.23763.trast@student.ethz.ch>
References: <200902091508.11460.trast@student.ethz.ch> <7vprhpkgzk.fsf@gitster.siamese.dyndns.org> <200902112352.40955.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2816878.2vnGgPAyF8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 00:00:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXO3n-0007RM-Nh
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 00:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbZBKW6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 17:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbZBKW6b
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 17:58:31 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:59550 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbZBKW6a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 17:58:30 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Feb 2009 23:58:29 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Feb 2009 23:58:28 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <200902112352.40955.trast@student.ethz.ch>
X-OriginalArrivalTime: 11 Feb 2009 22:58:28.0853 (UTC) FILETIME=[40E86A50:01C98C9C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109542>

--nextPart2816878.2vnGgPAyF8
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> I'm already short on sleep.
[...]
>   git://repo.or.cz/trackgit.git notes/full
>   git://repo.or.cz/trackgit.git notes/terse

Q.E.D.!  The correct repository is

  git://repo.or.cz/git/trast.git notes/full
  git://repo.or.cz/git/trast.git notes/terse

Sorry for the noise.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2816878.2vnGgPAyF8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmTWA8ACgkQqUud07tmzP3DkQCgkwVU5fjc0Z/Xa36fCqYi3rat
Y2MAniNbJ9pIaXiWTpgYuQq5wAabH+js
=wbk/
-----END PGP SIGNATURE-----

--nextPart2816878.2vnGgPAyF8--
