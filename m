From: Timo Sirainen <tss@iki.fi>
Subject: Re: [PATCH] -Werror fixes
Date: Tue, 09 Aug 2005 21:11:27 +0300
Message-ID: <1123611087.21306.48.camel@hurina>
References: <1123601422.21306.46.camel@hurina>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yAxFzFk4VuoPBXOou77i"
X-From: git-owner@vger.kernel.org Tue Aug 09 20:12:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Ya8-0002YH-MV
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 20:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVHISLf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 14:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVHISLe
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 14:11:34 -0400
Received: from kone17.procontrol.vip.fi ([212.149.71.178]:26499 "EHLO
	danu.procontrol.fi") by vger.kernel.org with ESMTP id S964905AbVHISLe
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 14:11:34 -0400
Received: from hurina (82-203-177-3.dsl.gohome.fi [82.203.177.3])
	by danu.procontrol.fi (Postfix) with ESMTP id 7D0291C351C6
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 21:11:27 +0300 (EEST)
To: git@vger.kernel.org
In-Reply-To: <1123601422.21306.46.camel@hurina>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-yAxFzFk4VuoPBXOou77i
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-09 at 18:30 +0300, Timo Sirainen wrote:
> GCC's format __attribute__ is good for checking errors, especially with
> -Werror=3D2 parameter. Patch below fixes most of the reported problems
> against 2005-08-09 snapshot.

Eh. -Wformat=3D2 of course. What was I thinking..


--=-yAxFzFk4VuoPBXOou77i
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC+PHPyUhSUUBViskRAiJWAJ9dByzLV52ajGbwe0TJm5LiytWw9wCgjSet
XWnTKDPBPMoGsGVNt8HZCys=
=QClK
-----END PGP SIGNATURE-----

--=-yAxFzFk4VuoPBXOou77i--
