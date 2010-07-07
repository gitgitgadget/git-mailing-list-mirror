From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] rebase -i: use 'read -r' to avoid backslash acting as
 an escape character
Date: Wed, 7 Jul 2010 11:46:20 +0200
Message-ID: <20100707094620.GC31048@genesis.frugalware.org>
References: <20100706225522.GA31048@genesis.frugalware.org>
 <7vpqyz278o.fsf@alter.siamese.dyndns.org>
 <20100707091633.GB31048@genesis.frugalware.org>
 <AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="boT9Oj39GmgPxYhu"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Jul 07 11:46:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWRD4-0006T1-2G
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 11:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab0GGJqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 05:46:25 -0400
Received: from virgo.iok.hu ([212.40.97.103]:55638 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922Ab0GGJqY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 05:46:24 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D62885809C;
	Wed,  7 Jul 2010 11:46:20 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BACD944659;
	Wed,  7 Jul 2010 11:46:20 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8E97D12D90F0; Wed,  7 Jul 2010 11:46:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150461>


--boT9Oj39GmgPxYhu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 07, 2010 at 11:22:29AM +0200, Santi B=E9jar <santi@agolina.net>=
 wrote:
> No. This one:
>=20
> http://article.gmane.org/gmane.comp.version-control.git/150328
>=20
> :-)

Heh, then sorry for the noise. I noticed the problem on 2th, added the
"I should fix this" to my TODO, then made the patch yesterday. I forgot
to check the list archive again before sending the patch. ;-)

--boT9Oj39GmgPxYhu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkw0TOwACgkQe81tAgORUJZ+5wCcC0JclvrvaIlEr++6gRV3Ki2d
v6EAn0NJ6qbDScdzlSOZQ7Wc1E3wHgdC
=IZIA
-----END PGP SIGNATURE-----

--boT9Oj39GmgPxYhu--
