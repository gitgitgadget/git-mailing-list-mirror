From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 16:42:35 -0700
Message-ID: <20090405T234147Z@curie.orbis-terrarum.net>
References: <20090404220743.GA869@curie-int> <20090405195714.GA4716@coredump.intra.peff.net> <20090405T230552Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 01:44:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqc11-0007t6-N4
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 01:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbZDEXmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 19:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbZDEXmk
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 19:42:40 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:49824 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753550AbZDEXmk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 19:42:40 -0400
Received: (qmail 3743 invoked from network); 5 Apr 2009 23:42:37 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 05 Apr 2009 23:42:37 +0000
Received: (qmail 3514 invoked by uid 10000); 5 Apr 2009 16:42:35 -0700
Content-Disposition: inline
In-Reply-To: <20090405T230552Z@curie.orbis-terrarum.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115740>


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2009 at 04:38:31PM -0700, Robin H. Johnson wrote:
> > Have you tried with a more recent git to see if it is any better? There
> > have been a number of changes since 1.6.0.6, although it looks like
> > mostly dealing with better recovery from corrupted packs.
> Testing right now, the above on the LAN setup was w/ current git HEAD.
Just following up, there seems to be no significant change in results
with v1.6.2.2 over v1.6.0.6.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknZQesACgkQPpIsIjIzwiz7VgCcDNB/823sSDWipn/GWBDSzuRP
dYsAn2tFcskTsObPxgaooymdmFnfYg01
=bzsE
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
