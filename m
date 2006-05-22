From: Martin Waitz <tali@admingilde.org>
Subject: Re: Current Issues #3
Date: Mon, 22 May 2006 12:20:29 +0200
Message-ID: <20060522102029.GE12810@admingilde.org>
References: <7v8xoue9eo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 12:20:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi7We-0006Kp-IF
	for gcvg-git@gmane.org; Mon, 22 May 2006 12:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWEVKUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 06:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWEVKUd
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 06:20:33 -0400
Received: from admingilde.org ([213.95.32.146]:20653 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1750716AbWEVKUd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 06:20:33 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Fi7WX-0006Bm-9I; Mon, 22 May 2006 12:20:29 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xoue9eo.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20496>


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 22, 2006 at 01:44:15AM -0700, Junio C Hamano wrote:
>     1. "upstream" refers to the remote section to use when
>        running "git-{fetch,pull,push}" while on that branch.
>=20
> 	[branch "master"]
> 		upstream =3D "origin"

what do you do for [branch "next"] here?

Does it make sense to regard all refs/remotes/*/<branchname> as
upstream and merge these into the current branch when pulling?

Perhaps a pull could even merge all newly fetched remote heads
into the corresponding branch, but for that we'd need to be
able to merge without using the working dir.

--=20
Martin Waitz

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEcZBtj/Eaxd/oD7IRArywAJwMPfPUjTqX/hQoXEiwpjw3B67AJACfbjLj
poqfBRvjka0WP7aCKU1NqWk=
=7qDo
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
