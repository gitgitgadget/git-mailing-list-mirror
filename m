From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Re: [PATCH] Add USER environment variable to executed git
	commands when serving
Date: Wed, 3 Jun 2009 13:50:04 -0700
Message-ID: <robbat2-20090603T204719-922480112Z@orbis-terrarum.net>
References: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com> <20090602135659.GA4320@macbook.lan> <2e24e5b90906021804tf3db263qc41a6f8b171111e1@mail.gmail.com> <2e24e5b90906022324pe6769d5vfa5e3eec44daeaf3@mail.gmail.com> <20090603202701.GA8739@macbook.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ztcJpsdPpsnnlAp8"
Cc: Sitaram Chamarty <sitaramc@gmail.com>, tv@eagain.net
To: Heiko Voigt <hvoigt@hvoigt.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 22:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBxQE-00073q-C7
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 22:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbZFCUup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 16:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbZFCUuo
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 16:50:44 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:49603 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751783AbZFCUun (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 16:50:43 -0400
Received: (qmail 4458 invoked from network); 3 Jun 2009 20:50:42 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 03 Jun 2009 20:50:42 +0000
Received: (qmail 14334 invoked by uid 10000); 3 Jun 2009 13:50:04 -0700
Content-Disposition: inline
In-Reply-To: <20090603202701.GA8739@macbook.lan>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120640>


--ztcJpsdPpsnnlAp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2009 at 10:27:02PM +0200, Heiko Voigt wrote:
> You are welcome. An interesting addition would be to propagate allowed
> branchnames from gitosis.conf. That way you can implement write-
> protected branches using an update hook.
=2E..
> A nice solution to steer this directly from gitosis.conf? I never got
> around implementing it.
Has anybody implemented something like cvs_acls.pl (used by FreeBSD) for
Git?

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--ztcJpsdPpsnnlAp8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkom4fwACgkQPpIsIjIzwiyrowCgxYZQqCU95kgWVXCXW4o2VxEd
2KsAoL+/9Tl4QMq7doLFBuYiI92R2YF/
=dxqG
-----END PGP SIGNATURE-----

--ztcJpsdPpsnnlAp8--
