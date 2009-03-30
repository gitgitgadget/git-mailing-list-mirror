From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Mon, 30 Mar 2009 13:03:35 +0200
Message-ID: <20090330110335.GF22446@genesis.frugalware.org>
References: <op.urifmtkkso3nzr@sulidor.mdjohnson.us> <20090329121700.GN22446@genesis.frugalware.org> <op.urk20nanso3nzr@sulidor.mdjohnson.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYfJCIN5rqlfy3K0"
Cc: git@vger.kernel.org
To: Michael Johnson <redbeard@mdjohnson.us>
X-From: git-owner@vger.kernel.org Mon Mar 30 13:06:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoFJe-0006RN-5T
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 13:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbZC3LDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 07:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbZC3LDj
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 07:03:39 -0400
Received: from virgo.iok.hu ([212.40.97.103]:35004 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbZC3LDj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 07:03:39 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 60036580F0;
	Mon, 30 Mar 2009 13:03:36 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4CFAB44783;
	Mon, 30 Mar 2009 13:03:35 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4D45911F0824; Mon, 30 Mar 2009 13:03:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <op.urk20nanso3nzr@sulidor.mdjohnson.us>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115135>


--WYfJCIN5rqlfy3K0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2009 at 09:39:49PM -0500, Michael Johnson <redbeard@mdjohns=
on.us> wrote:
> Well, I've got a backtrace, but I don't have debugging symbols, =20
> apparently. There is not a Debian package I can find that has them. I =20
> checked debug.debian.net, as well as the standard sid repository. So I =
=20
> will have to rebuild the package with debugging turned on. I will not be =
=20
> able to do that tonight, unfortunately. I will probably have a chance =20
> tomorrow evening.

Okay, no rush. In case Dscho's patch does not fix your problem, please
rebuild git with debug symbols enabled and send a normal trace.

Thanks.

--WYfJCIN5rqlfy3K0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknQpwcACgkQe81tAgORUJZQvgCcC6hdD7K/DDTNcShf5URSxmYx
J18AoKciPD0RL6g7CdjsPSoUYohoztoy
=FUYS
-----END PGP SIGNATURE-----

--WYfJCIN5rqlfy3K0--
