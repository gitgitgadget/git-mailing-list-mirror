From: "Jeffrey C. Ollie" <jeff@ocjtech.us>
Subject: Re: git.or.cz IPv6
Date: Mon, 14 May 2007 11:30:23 -0500
Message-ID: <1179160223.12911.2.camel@lt21223.campus.dmacc.edu>
References: <20070513094054.GB18546@cip.informatik.uni-erlangen.de>
	 <20070514005410.GG4489@pasky.or.cz>
	 <20070514054232.GD17207@cip.informatik.uni-erlangen.de>
	 <1179144251.9637.6.camel@lt21223.campus.dmacc.edu>
	 <20070514124518.GO18965@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-N54hZ3P9LOnjOqTDX+5T"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 18:29:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HndQT-000679-9c
	for gcvg-git@gmane.org; Mon, 14 May 2007 18:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542AbXENQ3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 12:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757190AbXENQ3Z
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 12:29:25 -0400
Received: from homer.isunet.net ([63.175.164.9]:45856 "EHLO homer.isunet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756905AbXENQ3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 12:29:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by homer.isunet.net (Postfix) with ESMTP id EA365388563
	for <git@vger.kernel.org>; Mon, 14 May 2007 10:36:45 -0500 (CDT)
Received: from homer.isunet.net ([63.175.164.9])
 by localhost (homer [63.175.164.9]) (amavisd-new, port 10024) with ESMTP
 id 07174-09 for <git@vger.kernel.org>; Mon, 14 May 2007 10:36:44 -0500 (CDT)
Received: from max1.ocjtech.us (dsl-ppp239.isunet.net [63.175.164.239])
	by homer.isunet.net (Postfix) with ESMTP id 80355388585
	for <git@vger.kernel.org>; Mon, 14 May 2007 10:36:43 -0500 (CDT)
Received: from [172.16.0.186]
	by max1.ocjtech.us with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.62)
	(envelope-from <jeff@ocjtech.us>)
	id 1HndQQ-0001KO-26
	for git@vger.kernel.org; Mon, 14 May 2007 11:29:30 -0500
In-Reply-To: <20070514124518.GO18965@albany.tokkee.org>
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
X-Virus-Scanned: by amavisd-new at isunet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47266>


--=-N54hZ3P9LOnjOqTDX+5T
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-05-14 at 14:45 +0200, Sebastian Harl wrote:
>=20
> It works fine for me - might be fixed by now:
>=20
> traceroute to rover.or.cz (2a01:b0:0:2::) from 2001:780:106::f1, 30 hops =
max, 1s
> [...]
>  5  so-1-0-0.fra40.ip6.tiscali.net (2001:668:0:2::4b0)  4.971 ms  4.962 m=
s  4.9s 6  so-0-0-0.dus11.ip6.tiscali.net (2001:668:0:2::1:1)  8.468 ms  8.=
45 ms  8.55s
>  7  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  13.964 ms  13.683=
 ms  1s
>  8  rover.xs26.eu (2a01:b0:0:2::)  37.079 ms  37.146 ms  37.145 ms

Nope, I still get timeouts after so-0-0-0.ham10.ip6.tiscali.net.  Can
you check the ipv6 routing table on rover.xs26.eu?

Jeff


--=-N54hZ3P9LOnjOqTDX+5T
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGSI6artk7xyyIQRERApiyAJsE5STKOCg3aQtCm7LZP+OKNW8aawCeLTKy
riIJB5Ee6C1qVifIP/b72oE=
=9kb4
-----END PGP SIGNATURE-----

--=-N54hZ3P9LOnjOqTDX+5T--
