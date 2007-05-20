From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 09/15] entry.c: optionally checkout submodules
Date: Sun, 20 May 2007 23:18:50 +0200
Message-ID: <20070520211850.GJ5412@admingilde.org>
References: <11796842882917-git-send-email-skimo@liacs.nl> <11796842892490-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun May 20 23:19:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpsnp-0004bB-Cb
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756719AbXETVSw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756725AbXETVSw
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:18:52 -0400
Received: from mail.admingilde.org ([213.95.32.147]:45641 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719AbXETVSv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:18:51 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hpsni-0005tW-I3; Sun, 20 May 2007 23:18:50 +0200
Content-Disposition: inline
In-Reply-To: <11796842892490-git-send-email-skimo@liacs.nl>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47921>


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

have you seen my patch to checkout submodules?

The submodule checkout should really check that the requested commit
is really available and have some other path for creating submodules
which are not currently checked out / able to be checked out.

--=20
Martin Waitz

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGULs6j/Eaxd/oD7IRAuuTAJ9QsUCjbuSfcpVeihORLEIayC4IVwCfV/Qc
aK98pn31W3peUxG03OdP9pI=
=+Lby
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
