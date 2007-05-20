From: Martin Waitz <tali@admingilde.org>
Subject: RFC: submodule terminology
Date: Sun, 20 May 2007 23:44:17 +0200
Message-ID: <20070520214417.GM5412@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 23:44:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HptCR-0000JW-Vl
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657AbXETVoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756746AbXETVoT
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:44:19 -0400
Received: from mail.admingilde.org ([213.95.32.147]:59461 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756657AbXETVoS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:44:18 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HptCL-00064x-Kc
	for git@vger.kernel.org; Sun, 20 May 2007 23:44:17 +0200
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47928>


--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

I think we should agree to one name for what currently is named
submodule / subproject / dirlink / gitlink.

Or use one name for the low-level plumbing (have a tree entry
which points to another commit): dirlink or gitlink and another
one for the high-level UI think: submodule or subproject.
But then we should use those names consequently.

Oppinions?

--=20
Martin Waitz

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUMExj/Eaxd/oD7IRAgObAJ9yM3/KoYzQ17smwaYyAWhffbLA3gCfY7oW
HQBkRaw9QmG1LpSoauDYvHI=
=sIKG
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
