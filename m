From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Use backticks instead of $(command) to maintain /bin/sh compatibility
Date: Sat, 7 May 2005 19:24:29 +0200
Message-ID: <20050507172429.GJ3562@admingilde.org>
References: <20050507084549.GF23680@cip.informatik.uni-erlangen.de> <7v3bszbeoo.fsf@assigned-by-dhcp.cox.net> <20050507090543.GG23680@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zFjDrgRWvOv91yyn"
X-From: git-owner@vger.kernel.org Sat May 07 19:17:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUSvv-0007aF-HH
	for gcvg-git@gmane.org; Sat, 07 May 2005 19:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVEGRYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 13:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVEGRYj
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 13:24:39 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:30081 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262729AbVEGRYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 13:24:37 -0400
Received: from faui31y.informatik.uni-erlangen.de (mnwaitz@faui31y [131.188.33.40])
	by faui3es.informatik.uni-erlangen.de (8.13.4/8.13.4/Debian-1) with ESMTP id j47HOVvW002631;
	Sat, 7 May 2005 19:24:32 +0200
Received: (from mnwaitz@localhost)
	by faui31y.informatik.uni-erlangen.de (8.13.4/8.13.4/Submit) id j47HOTnD031279;
	Sat, 7 May 2005 19:24:29 +0200
To: GIT <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20050507090543.GG23680@cip.informatik.uni-erlangen.de>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--zFjDrgRWvOv91yyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, May 07, 2005 at 11:05:43AM +0200, Thomas Glanzmann wrote:
> * Junio C Hamano <junkio@cox.net> [050507 10:54]:
> > A quick question.  Which construct in this bashism?
> > Not using backtick but saying $(command)?
>=20
> Exactly:

huh? which broken shell does not understand $()?

--=20
Martin Waitz

--zFjDrgRWvOv91yyn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCfPnNj/Eaxd/oD7IRAu7mAJ9dd/pODiMbGTN6TWh+Iiwydi8XRQCfekdt
4a+NdUsQESvS1ANTqzsJ4kw=
=n8QS
-----END PGP SIGNATURE-----

--zFjDrgRWvOv91yyn--
