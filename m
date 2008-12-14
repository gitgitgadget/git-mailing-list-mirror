From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (Dec 2008, #02; Sun, 14)
Date: Sun, 14 Dec 2008 14:15:08 +0100
Message-ID: <20081214131508.GA5691@genesis.frugalware.org>
References: <7v7i632mg9.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812141142300.2014@eeepc-johanness> <m3ljujdn2k.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgVgbXf0Vb2tUvlQ"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 14:16:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBqpg-0007CX-NJ
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 14:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbYLNNPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 08:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbYLNNPL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 08:15:11 -0500
Received: from virgo.iok.hu ([212.40.97.103]:48142 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835AbYLNNPK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 08:15:10 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F235658091;
	Sun, 14 Dec 2008 14:15:07 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B45164465E;
	Sun, 14 Dec 2008 14:15:07 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 11C6D11B887E; Sun, 14 Dec 2008 14:15:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3ljujdn2k.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103080>


--dgVgbXf0Vb2tUvlQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2008 at 03:17:05AM -0800, Jakub Narebski <jnareb@gmail.com>=
 wrote:
> So the answer is that AsciiDoc does not generate LaTeX, so pdflatex
> would be not enough.
>=20
> By the way, from the AsciiDoc page:
>=20
>  NOTE: Owning to to other commitments, Benjamin is unable to maintain
>        this backend. I don't have the expertise or time to take this
>        on consequently the LaTeX backend has not been tested or
>        updated since AsciiDoc version 8.2.7 and is currently
>        unsupported.

Yes, this is the LaTeX backend, which would allow not to use dblatex,
but generate tex directly from asciidoc. That's why my patch uses
dblatex instead.

--dgVgbXf0Vb2tUvlQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklFBtsACgkQe81tAgORUJYRPwCgl7ID8kCBT/+mmsBJlxXW54L2
fNQAoJbV2+iz4DNetVn5EeBSO1oHeQiU
=Y2/T
-----END PGP SIGNATURE-----

--dgVgbXf0Vb2tUvlQ--
