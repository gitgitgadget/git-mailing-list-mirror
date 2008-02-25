From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 21:55:05 +0100
Message-ID: <20080225205505.GY31441@genesis.frugalware.org>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org> <20080225183413.GA15131@sigill.intra.peff.net> <vpqoda43lva.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jnCIwN96y15MEy/K"
Cc: Jeff King <peff@peff.net>, John Goerzen <jgoerzen@complete.org>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTkMU-0001rs-CK
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbYBYUzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 15:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbYBYUzI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:55:08 -0500
Received: from virgo.iok.hu ([193.202.89.103]:10773 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbYBYUzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 15:55:07 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8F9771B2524;
	Mon, 25 Feb 2008 21:55:05 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id EDEA544668;
	Mon, 25 Feb 2008 21:52:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 178E211901F5; Mon, 25 Feb 2008 21:55:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <vpqoda43lva.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75068>


--jnCIwN96y15MEy/K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 25, 2008 at 07:57:13PM +0100, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> The really nice thing with the way darcs does it is that it makes it
> extremely easy for an occasional contribution. If the maintainer
> configured his stuff correctly, it's really "darcs get; ... ; darcs
> record; darcs send". git-send-email is nice, but harder to use for a
> first-timer.

that's true, while the practice can be the opposite. darcs forces you to
have an smtpd on localhost, while git allows you to send the patch from
your mail client. this _is_ easier for people sometimes. (especially
these days when everybody blocks dhcp address ranges and an avarage user
doesn't configure a proxy smtpd on localhost usually i think.)

- VMiklos

--jnCIwN96y15MEy/K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHwyspe81tAgORUJYRAj8+AKCDxFJvmEunje42WKPj0LuZqXPC7ACfcbvq
Mwo//8amvj7wehzAkP0rEvQ=
=LmI/
-----END PGP SIGNATURE-----

--jnCIwN96y15MEy/K--
