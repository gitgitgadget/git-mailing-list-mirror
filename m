From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] path-list documentation: document all functions and
	data structures
Date: Sun, 15 Jun 2008 00:50:29 +0200
Message-ID: <20080614225029.GM29404@genesis.frugalware.org>
References: <1213404964-25161-1-git-send-email-vmiklos@frugalware.org> <4853BE8E.4030009@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vLMw7YUSGBnioq2/"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Don Zickus <dzickus@redhat.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sun Jun 15 00:51:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7eaj-0002YQ-3L
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 00:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbYFNWub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 18:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489AbYFNWub
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 18:50:31 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48356 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755449AbYFNWua (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 18:50:30 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C2C9A1B24F0;
	Sun, 15 Jun 2008 00:50:29 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 815B64469F;
	Sun, 15 Jun 2008 00:31:00 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A801F1770022; Sun, 15 Jun 2008 00:50:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4853BE8E.4030009@free.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85050>


--vLMw7YUSGBnioq2/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2008 at 02:50:22PM +0200, Olivier Marin <dkr+ml.git@free.fr=
> wrote:
> What about just `memset(&list, 0, sizeof(list))` instead?
>=20
> It's readable in the text format, clean in html and this is the way
> memset() is used.

Good idea, thanks. Will do in a bit.

--vLMw7YUSGBnioq2/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhUSzUACgkQe81tAgORUJbbjwCbBBvPdlwiR7EeVFSJrQeM0AJ7
fJAAnjqifos0qX3LYTpqqViWvfGu1IzD
=5sx4
-----END PGP SIGNATURE-----

--vLMw7YUSGBnioq2/--
