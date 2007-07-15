From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Questions about git-fast-import for cvs2svn
Date: Sun, 15 Jul 2007 16:21:15 -0700
Message-ID: <20070715232115.GD12664@curie-int.orbis-terrarum.net>
References: <469A2B1D.2040107@alum.mit.edu> <200707152356.58304.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EcSFpNr6Vcxykj4g"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:21:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADPI-00010h-1J
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545AbXGOXVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755838AbXGOXU7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:20:59 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:49826 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755534AbXGOXU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:20:58 -0400
Received: (qmail 20564 invoked from network); 15 Jul 2007 23:20:54 -0000
Received: from S010600022af11287.vc.shawcable.net (HELO curie.orbis-terrarum.net) (24.85.131.30)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 15 Jul 2007 23:20:54 +0000
Received: (qmail 27151 invoked by uid 10000); 15 Jul 2007 16:21:15 -0700
Content-Disposition: inline
In-Reply-To: <200707152356.58304.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52599>


--EcSFpNr6Vcxykj4g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 15, 2007 at 11:56:56PM +0200, Robin Rosenberg wrote:
> s?ndag 15 juli 2007 skrev Michael Haggerty:
> >    b. CVS tag/branch creation events do not even include a username.
> > Any suggestions for what to use here?
> The CVSROOT/history file contains the user name and timestamp of the tag
> creation. CVS can be told not to update the file. It is appended to by de=
fault.
This assumes that said file is intact, and that LogFormat was not
changed to not put entries into the file on tag/branch.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--EcSFpNr6Vcxykj4g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGmqvrPpIsIjIzwiwRAsGhAJ9vD3QdeoRvrCm7hNNrXaXQmEOxHgCfT+Zt
tGrwAyOx61sh4csIHEnfKRw=
=a5uO
-----END PGP SIGNATURE-----

--EcSFpNr6Vcxykj4g--
