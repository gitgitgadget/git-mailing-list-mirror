From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: git daemon request logging?
Date: Fri, 15 May 2009 15:22:07 -0700
Message-ID: <20090515222207.GA9483@curie-int>
References: <4A0DC4E0.7020001@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
To: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 16 00:22:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M55nH-0001lp-Dd
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 00:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757816AbZEOWWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 18:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757668AbZEOWWN
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 18:22:13 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:51005 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756877AbZEOWWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 18:22:12 -0400
Received: (qmail 13213 invoked from network); 15 May 2009 22:22:11 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Fri, 15 May 2009 22:22:11 +0000
Received: (qmail 19206 invoked by uid 10000); 15 May 2009 15:22:07 -0700
Content-Disposition: inline
In-Reply-To: <4A0DC4E0.7020001@garzik.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119306>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2009 at 03:39:12PM -0400, Jeff Garzik wrote:
> Does the git daemon do any sort of request logging?  Could it?
You could probably get it easily from my upcoming selective-deny of
pull/clone patch.

I described my plans here:
http://thread.gmane.org/gmane.comp.version-control.git/115600/focus=3D116588

Hopefully I'll have a patch out sometime next week.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkoN6w8ACgkQPpIsIjIzwiwogACeMqaa1Rc7L6uEFzPXvP6pv9jX
n/0AoNtRO4GWrideOICdeEyI8FtarUQ5
=hPwW
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
