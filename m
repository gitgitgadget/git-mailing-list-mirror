From: Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH] git-mktree: reverse of git-ls-tree.
Date: Mon, 20 Feb 2006 22:52:30 -0800
Message-ID: <1140504750.16926.111.camel@evo.keithp.com>
References: <7vk6bp43qm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xbpHmHCeMWnMnFCra9li"
Cc: keithp@keithp.com, Tommi Virtanen <tv@debian.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 07:53:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBROe-0000oO-DT
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 07:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161408AbWBUGxE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 01:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161417AbWBUGxE
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 01:53:04 -0500
Received: from home.keithp.com ([63.227.221.253]:19982 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1161408AbWBUGxD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 01:53:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 5E167130039;
	Mon, 20 Feb 2006 22:53:01 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 25531-01; Mon, 20 Feb 2006 22:53:00 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id 99C77130038; Mon, 20 Feb 2006 22:53:00 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 899B414001;
	Mon, 20 Feb 2006 22:53:00 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1FBRNw-00088b-Gy; Mon, 20 Feb 2006 22:52:32 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6bp43qm.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16519>


--=-xbpHmHCeMWnMnFCra9li
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<internationalization-pedant-mode>
On Mon, 2006-02-20 at 22:37 -0800, Junio C Hamano wrote:

> + * Copyright (c) Junio C Hamano, 2006

I've been told by at least two lawyers that the string '(c)' has no
legal meaning in the US. If you want to indicate copyright, the only
symbol which does carry legal weight is the c-in-a-circle mark '=C2=A9'.=20

Of course, this does force the issue of what encoding to present source
files in. I suggest that sources should be UTF-8, which also provides
opportunities to encode author names correctly, rather than
transliterating them to Latin. X.org uses UTF-8 for source files now
without difficulty across a wide range of compilers. Of course,
non-ascii glyphs are present only in comments.

</internationalization-pedant-mode>
--=20
keith.packard@intel.com

--=-xbpHmHCeMWnMnFCra9li
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD+riuQp8BWwlsTdMRAsiMAJ42jEFYpXgwuiyvm01Dy8COWkQgqwCfQEOZ
wl2mRxtZ+Q9PhH9Xizbkb3A=
=z2C4
-----END PGP SIGNATURE-----

--=-xbpHmHCeMWnMnFCra9li--
