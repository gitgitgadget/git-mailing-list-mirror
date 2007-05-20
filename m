From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 01:12:01 +0200
Message-ID: <20070520231200.GR5412@admingilde.org>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520195930.GX942MdfPADPa@greensroom.kotnet.org> <20070520205444.GC25462@steel.home> <20070520214026.GL5412@admingilde.org> <20070520222410.GF25462@steel.home> <20070520225521.GP5412@admingilde.org> <20070520230248.GI25462@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Cc: skimo@liacs.nl, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 01:12:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpuZN-0004UU-Qm
	for gcvg-git@gmane.org; Mon, 21 May 2007 01:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155AbXETXMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 19:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758179AbXETXMF
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 19:12:05 -0400
Received: from mail.admingilde.org ([213.95.32.147]:41865 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758155AbXETXME (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 19:12:04 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HpuZF-0007B4-FZ; Mon, 21 May 2007 01:12:01 +0200
Content-Disposition: inline
In-Reply-To: <20070520230248.GI25462@steel.home>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47950>


--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 21, 2007 at 01:02:48AM +0200, Alex Riesen wrote:
> > If the user did commit and then you do a supermodule checkout -m you
> > will get a merge.
>=20
> Only if the user continue to use the last branch (or the detached
> head) the subproject was on. He don't have to, he can even return to
> the commit which does not conflict, unless he have to complicate
> things.

just curious:
so you want to differenciate between a subproject HEAD which was
set by the superproject and other ones?

--=20
Martin Waitz

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUNXAj/Eaxd/oD7IRAhKvAJ4j0JFMb2Rn1yG+K5ft31WbpM5NtACfXB7U
6XnSRDyJygSfII5oOmAMpxY=
=iG4q
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--
