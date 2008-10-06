From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: how to restrict commit for a repo
Date: Mon, 6 Oct 2008 21:58:56 +0200
Message-ID: <20081006195856.GS23137@genesis.frugalware.org>
References: <c94f8e120810060509w5eaa9138m92f1df36c9c36db6@mail.gmail.com> <20081006130042.GQ23137@genesis.frugalware.org> <c94f8e120810061012p29210247sfd3c1b3c05e871ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5eYgouiXv72wBrai"
Cc: Git Mailing List <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 22:00:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmwFa-0001vK-Sr
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 22:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbYJFT67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 15:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbYJFT67
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 15:58:59 -0400
Received: from virgo.iok.hu ([193.202.89.103]:59241 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbYJFT66 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 15:58:58 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0FE995809E;
	Mon,  6 Oct 2008 21:58:57 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C5BD04465E;
	Mon,  6 Oct 2008 21:58:56 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AC78311901A1; Mon,  6 Oct 2008 21:58:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <c94f8e120810061012p29210247sfd3c1b3c05e871ee@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97621>


--5eYgouiXv72wBrai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2008 at 10:42:06PM +0530, Dilip M <dilipm79@gmail.com> wrot=
e:
> > Have you seen contrib/hooks/update-paranoid?
>=20
> Miklos,  I am totally new to this tool ( don't know SVN too).

That's good, since your mind is clear yet. :)

> Can you please consider giving some more info...or guiding me to some
> good links...:)
>=20
> Thanks in advance..

In general, I would suggest reading the user manual and everyday.txt,
both are under Documentation/.

Second, read man githooks, and then you'll understand how to use the
mentioned hook.

HTH

--5eYgouiXv72wBrai
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjqbgAACgkQe81tAgORUJbtewCfTQhbVzT7vFCJ4MJSPg2so7p1
IdYAoJaej+o4L1397ZEmUHLZMrhTyKB2
=RYu1
-----END PGP SIGNATURE-----

--5eYgouiXv72wBrai--
