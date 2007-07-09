From: VMiklos <vmiklos@frugalware.org>
Subject: Re: [PATCH] gitweb: New cgi parameter: filter
Date: Mon, 9 Jul 2007 23:18:41 +0200
Message-ID: <20070709211839.GT29994@genesis.frugalware.org>
References: <20070708013543.GD29994@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jl+DbTnyraiZ/loT"
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 09 23:19:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I80dI-0002RX-O7
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 23:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbXGIVSx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 17:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754438AbXGIVSx
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 17:18:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40142 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219AbXGIVSw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 17:18:52 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1I80d6-00088K-MM
	from <vmiklos@frugalware.org>; Mon, 09 Jul 2007 23:18:48 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 310F816A8084; Mon,  9 Jul 2007 23:18:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070708013543.GD29994@genesis.frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52021>


--Jl+DbTnyraiZ/loT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Na Sun, Jul 08, 2007 at 03:35:43AM +0200, Miklos Vajna <vmiklos@frugalware.=
org> pisal(a):
> Currently the only supported value is "nomerges". This allows one to filt=
er
> merges from many actions, like rss, log and shortlog.
>=20
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>

What do you think about this patch? Is it something that useful only for
me?

Some Frugalware users claimed about that most git-log-like command have
a --no-merges opcion but the rss feed, that's why i added such a
feature.

Thanks,

- VMiklos

--Jl+DbTnyraiZ/loT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGkqYve81tAgORUJYRAgj8AJ9iKUhqI6nHr0NfmjiFXNoWlVtqAACfeEE7
yiND2pZd1Nimg0tl/4gE5Ek=
=3AQw
-----END PGP SIGNATURE-----

--Jl+DbTnyraiZ/loT--
