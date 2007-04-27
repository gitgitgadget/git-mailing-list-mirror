From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch
	content
Date: Fri, 27 Apr 2007 13:35:34 -0700
Message-ID: <20070427203534.GA7846@curie-int.orbis-terrarum.net>
References: <ps5qyry4.fsf@cante.net> <7vslalmwcx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bgVZo3zXaTQrZhjg"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 22:35:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhXAX-0004Qr-Dp
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 22:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216AbXD0Uft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 16:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757218AbXD0Ufr
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 16:35:47 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:59911 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757213AbXD0UfW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 16:35:22 -0400
Received: (qmail 6622 invoked from network); 27 Apr 2007 20:35:21 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Fri, 27 Apr 2007 20:35:21 +0000
Received: (qmail 2023 invoked by uid 10000); 27 Apr 2007 13:35:34 -0700
Content-Disposition: inline
In-Reply-To: <7vslalmwcx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45750>


--bgVZo3zXaTQrZhjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2007 at 12:49:02PM -0700, Junio C Hamano wrote:
> On the other hand, in circles whose recipients are prepared to
> (or even "prefer to") accept messages formatted with --attach,
> there should be no harm done if the patch text is base64
> encoded either.
+1 for having this feature on my end.

I do some work on other projects where patches that aren't multipart
aren't even accepted (the author has an applying system that he bounces
the patches into, and refuses to change it :-( ) [again, projects that
aren't git upstream, but I track with git because that makes development
much easier].

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--bgVZo3zXaTQrZhjg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGMl6WPpIsIjIzwiwRArVtAJ48Dml+Bs9Pvr/iRqQr4w7sHCK2nQCfVOZi
voGu5VVnkUqU/MJFOJYg0WQ=
=wpnd
-----END PGP SIGNATURE-----

--bgVZo3zXaTQrZhjg--
