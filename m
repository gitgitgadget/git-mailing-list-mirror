From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] cvsimport: die on cvsps errors
Date: Mon, 24 Dec 2007 13:43:18 +0100
Message-ID: <20071224124318.GB23659@genesis.frugalware.org>
References: <20071222171801.GE15286@genesis.frugalware.org> <20071224030551.GA12495@sigill.intra.peff.net> <20071224030819.GA15485@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Sperling <stsp@stsp.name>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 24 13:43:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6men-0002Du-JN
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 13:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbXLXMnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 07:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbXLXMnV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 07:43:21 -0500
Received: from virgo.iok.hu ([193.202.89.103]:22056 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbXLXMnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 07:43:20 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 177831B2526;
	Mon, 24 Dec 2007 13:43:19 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9A1334465C;
	Mon, 24 Dec 2007 13:41:55 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2E404176C048; Mon, 24 Dec 2007 13:43:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071224030819.GA15485@sigill.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69213>


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2007 at 10:08:19PM -0500, Jeff King <peff@peff.net> wrote:
> > That being said, it's awful that git-cvsimport doesn't stop when cvsps
> > exits with an error, producing all of those meaningless errors. Patch
> > will follow.
>=20
> And here it is.

great, thanks :)

- VMiklos

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHb6lme81tAgORUJYRAuNeAJwNCYDg3Rn46a63Mw+YmXsvfNwQxQCfZM0n
SlRsMED7i0iTD7QSq1LWiWY=
=FlWr
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
