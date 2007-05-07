From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] submodule merge support
Date: Mon, 7 May 2007 21:33:14 +0200
Message-ID: <20070507193314.GL30511@admingilde.org>
References: <20070506190224.GG30511@admingilde.org> <20070506220745.GA2439@steel.home> <alpine.LFD.0.98.0705061517380.12945@woody.linux-foundation.org> <20070507090346.GI30511@admingilde.org> <463EFFC6.12A1B0A1@eudaptics.com> <alpine.LFD.0.98.0705070857100.3802@woody.linux-foundation.org> <20070507164434.GK30511@admingilde.org> <alpine.LFD.0.98.0705070959060.3802@woody.linux-foundation.org> <alpine.LFD.0.98.0705071015230.3802@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZVh52eu0Ophig4D"
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 07 21:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl8xV-0001LF-Fu
	for gcvg-git@gmane.org; Mon, 07 May 2007 21:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966236AbXEGTdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966256AbXEGTdQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 15:33:16 -0400
Received: from mail.admingilde.org ([213.95.32.147]:41976 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966236AbXEGTdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 15:33:16 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hl8xO-0005sA-9k; Mon, 07 May 2007 21:33:14 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705071015230.3802@woody.linux-foundation.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46480>


--YZVh52eu0Ophig4D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 07, 2007 at 10:17:11AM -0700, Linus Torvalds wrote:
> Oh, btw, you should also look out for the case where the superproject=20
> doesn't actually have the subprojects in question checked out. What=20
> happens then? Just leave them conflicted?

yes, I think that's the only sane thing one can do.

--=20
Martin Waitz

--YZVh52eu0Ophig4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGP376j/Eaxd/oD7IRAvQ9AJ9SFwvrv32DaqqvgYZXyd/KFk+6FQCdEaFR
5tRK4dsPq5eH5J+0ooC3VWI=
=KTsK
-----END PGP SIGNATURE-----

--YZVh52eu0Ophig4D--
