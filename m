From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: post-rebase hook (correction from Re: post-update hook)
Date: Sun, 7 Jun 2009 15:37:08 -0700
Message-ID: <robbat2-20090607T223615-931190896Z@orbis-terrarum.net>
References: <4A2BC306.3000001@box.net> <4A2BC367.7020309@box.net> <20090608054148.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vy1A5eXR7jld12ZH"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 08 00:37:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQzW-0002R5-8M
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 00:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbZFGWhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 18:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756098AbZFGWhM
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 18:37:12 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:45960 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755183AbZFGWhL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 18:37:11 -0400
Received: (qmail 29569 invoked from network); 7 Jun 2009 22:37:11 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 07 Jun 2009 22:37:11 +0000
Received: (qmail 24991 invoked by uid 10000); 7 Jun 2009 15:37:08 -0700
Content-Disposition: inline
In-Reply-To: <20090608054148.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121017>


--Vy1A5eXR7jld12ZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2009 at 05:41:48AM +0900, Nanako Shiraishi wrote:
> There are five valid reasons you might want a hook to a git operation.
> http://thread.gmane.org/gmane.comp.version-control.git/70781/focus=3D71069
> I don't think yours is backed by any of them.
That's a nice writeup. Could we consider adding this to the githooks
documentation?

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--Vy1A5eXR7jld12ZH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkosQRQACgkQPpIsIjIzwiwjsACgyUK7PJD5KQ6TNUioQQeyWQ/A
kEYAnApeHRFsXYa0oZpm+GyYpNT0D8CE
=X60P
-----END PGP SIGNATURE-----

--Vy1A5eXR7jld12ZH--
