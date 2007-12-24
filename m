From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Mon, 24 Dec 2007 13:50:55 +0100
Message-ID: <20071224125055.GC23659@genesis.frugalware.org>
References: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl> <476E42BF.1010300@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Mon Dec 24 13:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6mmA-0003vN-7J
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 13:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbXLXMu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 07:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbXLXMu5
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 07:50:57 -0500
Received: from virgo.iok.hu ([193.202.89.103]:22068 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbXLXMu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 07:50:57 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0AE2D1B2527;
	Mon, 24 Dec 2007 13:50:56 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id EA62D4465C;
	Mon, 24 Dec 2007 13:49:32 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9E297176C048; Mon, 24 Dec 2007 13:50:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <476E42BF.1010300@garzik.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69214>


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2007 at 06:13:03AM -0500, Jeff Garzik <jeff@garzik.org> wro=
te:
> Another year, another update!  :)
>=20
> The kernel hacker's guide to git has received some updates:
>=20
> 	http://linux.yyz.us/git-howto.html

one minor note:

i would suggest using:

$ git shortlog master..HEAD

instead of

$ git log master..HEAD | git shortlog

to avoid unnecessary complexity :)

thanks,
- VMiklos

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHb6sve81tAgORUJYRArjKAKCopDkv4T6GaZ/gyZcRbRBvi7wKEACeOb2T
m5UcBatSuM2uIemdHbUNRQw=
=pJZy
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
