From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] docs: give more hints about how "add -e" works
Date: Sun, 24 Oct 2010 02:32:14 +0200
Message-ID: <20101024003213.GF22105@genesis.frugalware.org>
References: <20101021143034.GA16083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uez3XWYSTYqFCK2C"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 24 02:44:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9ohX-0003aC-Qo
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 02:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758605Ab0JXAoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 20:44:23 -0400
Received: from virgo.iok.hu ([212.40.97.103]:36846 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758583Ab0JXAoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 20:44:22 -0400
X-Greylist: delayed 725 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Oct 2010 20:44:22 EDT
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 851DB5809D;
	Sun, 24 Oct 2010 02:32:15 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 430014496B;
	Sun, 24 Oct 2010 02:32:15 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AA8F5132C38D; Sun, 24 Oct 2010 02:32:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20101021143034.GA16083@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159833>


--uez3XWYSTYqFCK2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 21, 2010 at 10:30:35AM -0400, Jeff King <peff@peff.net> wrote:
> The previous text was not exactly accurate; it is OK to
> change space and minus lines, but only in certain ways. This
> patch attempts to cover explicitly what can be done at the
> individual line level, and cautions the user that
> conceptually larger changes (like modifying a line) require
> some understanding of the patch format.

Thanks for collecting those corner cases. :)

--uez3XWYSTYqFCK2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzDfo0ACgkQe81tAgORUJYsTgCgjr9VbIMx+MoHCKBgOeJFKSu7
26IAnR8EXBfASqkm/wNq0IaVth0OC34i
=gYjV
-----END PGP SIGNATURE-----

--uez3XWYSTYqFCK2C--
