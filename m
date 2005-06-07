From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: [PATCH 3/4] Generic support for pulling refs
Date: Tue, 07 Jun 2005 09:18:56 -0400
Message-ID: <1118150337.8970.49.camel@jmcmullan.timesys>
References: <Pine.LNX.4.21.0506061635070.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-dGS2v4yDLPtQkpEI+Jpm";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Petr Baudis" <pasky@ucw.cz>,
	"Junio C Hamano" <junkio@cox.net>,
	"GIT Mailling list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 15:17:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dfdvr-0004Wr-A6
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 15:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVFGNTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 09:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVFGNTS
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 09:19:18 -0400
Received: from mail.timesys.com ([65.117.135.102]:9401 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261855AbVFGNS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2005 09:18:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 07 Jun 2005 09:18:57 -0400
In-Reply-To: <Pine.LNX.4.21.0506061635070.30848-100000@iabervon.org>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Tue, 7 Jun 2005 09:11:54 -0400
Message-ID: <1118150337.8970.49.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/4] Generic support for pulling refs
thread-index: AcVrYnnwOpxUaklHRv+EQF9/r3ch3Q==
To: "Daniel Barkalow" <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-dGS2v4yDLPtQkpEI+Jpm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-06-06 at 16:38 -0400, Daniel Barkalow wrote:
> This adds support to pull.c for requesting a reference and writing it to =
a
> file. All of the git-*-pull programs get stubs for now.
>
> [snip snip]

Well, looks like you beat me to the punch, Daniel!

I hereby concede the Deathmatch to git-ssh-pu{sh,ll}, and withdraw
git-sync from consideration.

Way to go Daniel!

"Welcome to Git Thunderdome. Two codes enter, one code leaves."

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-dGS2v4yDLPtQkpEI+Jpm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpZ7A8/0vJ5szK6kRAmnxAJwONtsyRDyOdnm2HRAQFDBt4r/LyQCgwptY
8WCzGR2i7TvMS7ReKuImS1s=
=ptI8
-----END PGP SIGNATURE-----

--=-dGS2v4yDLPtQkpEI+Jpm--
