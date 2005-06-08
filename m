From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] Add missing Documentation/*
Date: Wed, 08 Jun 2005 08:26:32 -0400
Message-ID: <1118233592.7564.1.camel@jmcmullan.timesys>
References: <20050607141736.GA2157@jmcmullan.timesys> <7vvf4qhuht.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-Mmg+8QAZinKU5SS5rcCi";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: "GIT Mailling list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 14:25:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dfzb8-00089J-43
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 14:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVFHM1b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 08:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVFHM1b
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 08:27:31 -0400
Received: from mail.timesys.com ([65.117.135.102]:61247 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262196AbVFHM0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 08:26:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 08 Jun 2005 08:26:33 -0400
In-Reply-To: <7vvf4qhuht.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Wed, 8 Jun 2005 08:19:27 -0400
Message-ID: <1118233592.7564.1.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add missing Documentation/*
thread-index: AcVsJFCmz6mBteGORcaNk/pAlGWTmA==
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-Mmg+8QAZinKU5SS5rcCi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-06-07 at 11:50 -0700, Junio C Hamano wrote:
> I would suggest dropping "and the git-list" and the rest from
> all the new files.  The doc is by you, at least until somebody
> else mucks on it.

Understood. AFAICT, 'and the git-list' was convention.


> +++ b/Documentation/git-get-tar-commit-id.txt
>
> This is by Rene Scharfe.  There is no single line from Linus in
> the source file get-tar-commit-id.c, according to my "surviving
> line counter".

Oops! I though I had 'de-Linused' all the ones he didn't do. Guess I
missed one or two. Thanks for the catch!

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-Mmg+8QAZinKU5SS5rcCi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpuP48/0vJ5szK6kRArlyAKC8Y7oQH32DDwTXmNZTYX9YntyOVwCgxcto
AXvp7YES1QpcpgxE6+0WkE4=
=yWng
-----END PGP SIGNATURE-----

--=-Mmg+8QAZinKU5SS5rcCi--
