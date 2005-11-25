From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: git-send-mail in sh
Date: Fri, 25 Nov 2005 12:06:51 +0100
Message-ID: <20051125110651.GA9924@ferdyx.org>
References: <4386DD45.6030308@op5.se> <20051125101209.GA8868@puritan.petwork> <4386EE7B.7070604@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 12:08:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfbPx-0004tX-Dl
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 12:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVKYLG7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 06:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVKYLG7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 06:06:59 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:56497
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S1751446AbVKYLG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 06:06:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 19C948D33B;
	Fri, 25 Nov 2005 12:06:53 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18491-07; Fri, 25 Nov 2005 12:06:50 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 7C81D8D30B;
	Fri, 25 Nov 2005 12:06:49 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Fri, 25 Nov 2005 12:06:52 +0100 (CET)
To: Andreas Ericsson <ae@op5.se>
Mail-Followup-To: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4386EE7B.7070604@op5.se>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12736>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2005 at 11:59:07AM +0100, Andreas Ericsson wrote:
| As for implementation, I don't think most "mail" programs have the=20
| functionality necessary to do so (dunno though since I didn't investigate=
).

You can always generate a 'valid' mail message and use the sendmail
binary directly. That way you can set proper Message-Id: and proper
References: and/or In-Reply-To: in the following mails.

Cheers,
Ferdy

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDhvBLCkhbDGC9KNQRAtvBAJ9b2TOuLQg+qX+/tj4mawQO6mZh6ACgkK7D
SFqxgVdoy6fkxpmZvDKrGdU=
=Sozq
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
