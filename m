From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 3/3] pretty: support multiline subjects with format:
Date: Sun, 28 Dec 2008 02:44:07 +0100
Message-ID: <20081228014407.GD21154@genesis.frugalware.org>
References: <200812280024.59096.markus.heidelberg@web.de> <1230338961.8363.101.camel@ubuntu.ubuntu-domain> <20081228090909.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXhH8iG0/4JcYZU2"
Cc: markus.heidelberg@web.de,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 02:50:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGknO-0000gM-UI
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 02:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbYL1BoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 20:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbYL1BoL
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 20:44:11 -0500
Received: from virgo.iok.hu ([212.40.97.103]:55609 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673AbYL1BoK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 20:44:10 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E1AFB5808D;
	Sun, 28 Dec 2008 02:44:07 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id AD6D44465E;
	Sun, 28 Dec 2008 02:44:07 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9D5B811B8630; Sun, 28 Dec 2008 02:44:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081228090909.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104039>


--BXhH8iG0/4JcYZU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2008 at 09:09:09AM +0900, Nanako Shiraishi <nanako3@lavabit=
=2Ecom> wrote:
> The last message mentions a bug in "git rebase" that internally uses
> "git am" when replaying the changes. It was corrected later with:
>=20
> 	http://thread.gmane.org/gmane.linux.ports.sh.devel/3833/focus=3D79735
>=20
> Reading the discussion in the messages in this thread will help
> understanding the issues, after understanding why "the first line" was
> problematic, as discussed in the other threads.

Actually in that thread I asked if a patch that would make this
configurable would be ever accepted (so I would work on it), but I got
no answer. In the meantime I just learned to live with this, partially
because the vim highlight script highlights anything written to the
second line as red. ;-)

--BXhH8iG0/4JcYZU2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklW2ecACgkQe81tAgORUJbKEwCghoKhzNUEsGqqSy5koxjqL4cN
8HcAnAqldKzKkvQH9YKjN2Q4hwj3QRnH
=i1uS
-----END PGP SIGNATURE-----

--BXhH8iG0/4JcYZU2--
