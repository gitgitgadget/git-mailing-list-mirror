From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-merge.c: Fix option parsing
Date: Sun, 20 Jul 2008 15:08:25 +0200
Message-ID: <20080720130825.GG10347@genesis.frugalware.org>
References: <200807201434.47545.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sBy3cog7RUybpTge"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 15:09:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKYfI-0000vL-GE
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 15:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906AbYGTNI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 09:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754462AbYGTNI3
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 09:08:29 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47947 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754166AbYGTNI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 09:08:29 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D3CBB1B251F;
	Sun, 20 Jul 2008 15:08:27 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0F8E24465E;
	Sun, 20 Jul 2008 14:28:49 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5D48D177001C; Sun, 20 Jul 2008 15:08:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807201434.47545.barra_cuda@katamail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89199>


--sBy3cog7RUybpTge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 20, 2008 at 02:34:47PM +0200, Michele Ballabio <barra_cuda@katamail.com> wrote:
> Now "git merge -m" needs a message, and errors out with the usage
> text if none is given.
> This way, t7600-merge.sh is fixed.

Thanks, I was about to fix this, but you were faster. ;-)

--sBy3cog7RUybpTge
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiDOMkACgkQe81tAgORUJZ6LACgpYpFeHhk2RmhAA8eUq5RgIMs
sbAAnj+V6tOBFj53LsSjGaKPDIBKbzL/
=NGnG
-----END PGP SIGNATURE-----

--sBy3cog7RUybpTge--
