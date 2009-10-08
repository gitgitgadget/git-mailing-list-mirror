From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Documentation - pt-BR.
Date: Thu, 8 Oct 2009 02:12:49 +0200
Message-ID: <20091008001248.GS32702@genesis.frugalware.org>
References: <1253730339-11146-1-git-send-email-tfransosi@gmail.com>
 <7vhbuek3ma.fsf@alter.siamese.dyndns.org>
 <20091005100910.GA866@coredump.intra.peff.net>
 <20091006094701.GG32702@genesis.frugalware.org>
 <a4c8a6d00910060820se973fcci31c94c42937c7eb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNBQKW1gq53AWuRo"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 02:22:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvgmS-0002Q4-Fa
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 02:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbZJHAWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 20:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755101AbZJHAWN
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 20:22:13 -0400
Received: from [157.181.151.9] ([157.181.151.9]:51755 "EHLO mx2.mail.elte.hu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754984AbZJHAWM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 20:22:12 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1MvgkZ-0007kQ-Si
	from <vmiklos@frugalware.org>; Thu, 08 Oct 2009 02:21:00 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 10DBD11F0029; Thu,  8 Oct 2009 02:12:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a4c8a6d00910060820se973fcci31c94c42937c7eb2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.5
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129666>


--CNBQKW1gq53AWuRo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2009 at 12:20:00PM -0300, Thiago Farina <tfransosi@gmail.com> wrote:
> > $ ls -1 /etc/asciidoc/lang-*
> > /etc/asciidoc/lang-de.conf
> > /etc/asciidoc/lang-en.conf
> > /etc/asciidoc/lang-es.conf
> > /etc/asciidoc/lang-fr.conf
> > /etc/asciidoc/lang-hu.conf
> > /etc/asciidoc/lang-ru.conf
> In my system I only have installed lang-es.conf, how I could install the others?

This is with asciidoc 8.5.0, I guess you have a bit older version.

> Sure, I made the lang-pt-BR.conf, and I sent it to asciidoc@googlegroups.com.

Great, then sooner or later you could have those 'NAME' and 'SYNOPSIS'
strings localised. Till then, I would suggest having them in English -
git typically supports building with older asciidoc versions.

--CNBQKW1gq53AWuRo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrNLoAACgkQe81tAgORUJa0aQCgqxcrPt35ul7eMQ7oefdanIct
DjcAoJN6hZE9cryT8DoqEnCnI89BBqwl
=ZzzM
-----END PGP SIGNATURE-----

--CNBQKW1gq53AWuRo--
