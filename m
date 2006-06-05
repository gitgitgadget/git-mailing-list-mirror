From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH, take 2] Add example xinetd(8) configuration to Documentation/everyday.txt
Date: Mon, 5 Jun 2006 17:12:37 +0400
Message-ID: <20060605131237.GA31565@basalt.office.altlinux.org>
References: <20060605000144.GA12641@basalt.office.altlinux.org> <200606050054.k550sFCC018490@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 15:12:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnEss-00024O-9q
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 15:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWFENMj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 09:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWFENMj
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 09:12:39 -0400
Received: from mh.altlinux.org ([217.16.24.5]:27329 "EHLO mh.altlinux.org")
	by vger.kernel.org with ESMTP id S1750713AbWFENMi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 09:12:38 -0400
Received: from basalt.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by mh.altlinux.org (Postfix) with ESMTP
	id 9CD2E5F406; Mon,  5 Jun 2006 17:12:37 +0400 (MSD)
Received: by basalt.office.altlinux.org (Postfix, from userid 501)
	id 72EA0B0D92; Mon,  5 Jun 2006 17:12:37 +0400 (MSD)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200606050054.k550sFCC018490@laptop11.inf.utfsm.cl>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21318>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 04, 2006 at 08:54:15PM -0400, Horst von Brand wrote:
> Dmitry V. Levin <ldv@altlinux.org> wrote:
> > It is a bad advice to run git-daemon as root.
>=20
> Right, my bad. Fixed patch below.
[...]
> +        user            =3D root

Really?


--=20
ldv

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEhC3FfKvmrJ41Nh4RAjR4AJwOB05c7ORdsvWNjyQq4Z/X8/LEEwCgmU6t
BSNWc+yR/zXnFOqyJIjbBkc=
=zYhi
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
