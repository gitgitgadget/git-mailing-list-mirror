From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Mon, 23 Sep 2013 01:41:57 +0000
Message-ID: <20130923014157.GE235845@vauxhall.crustytoothpaste.net>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
 <20130921212904.GA235845@vauxhall.crustytoothpaste.net>
 <CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
 <20130921235647.GC235845@vauxhall.crustytoothpaste.net>
 <CAPc5daWa0BPXdrYqek=WzixVVfh0DvHhxjtOh2LW6bgR0MAOPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 03:42:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNvAC-0001pf-QA
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 03:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab3IWBmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 21:42:08 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60452 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752892Ab3IWBmH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Sep 2013 21:42:07 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 29E5528074;
	Mon, 23 Sep 2013 01:42:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPc5daWa0BPXdrYqek=WzixVVfh0DvHhxjtOh2LW6bgR0MAOPw@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235175>


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2013 at 05:00:44PM -0700, Junio C Hamano wrote:
>  - Moving away from higher-level scripting languages such as shell and Pe=
rl.
>    Recent "clean --interactive" may have added some code that could be
>    reused for a rewrite of "add -i" (which I think is in Perl), for examp=
le.
>    The minimum "You need to have these to use Git" should be made more
>    portable by doing *less* in shell or Perl, not by adding more in the h=
igher-
>    level languages, and certainly not by adding other languages, be it Ru=
by or
>    Lua.

I can certainly go for that.  C is faster and the codebase can be more
consistent (and more portable to non-Unix).  My concern was that if
we're going to be adding additional languages, some previous warning
would be appropriate.  As I said, I wouldn't be able to deploy a git
using Ruby immediately, and I'm sure I'm not the only one.  If we're not
going to be adding another language, then obviously the issue becomes
moot.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSP5xlAAoJEL9TXYEfUvaLBGoQAKy8d+MlXkTSnOkopTYxWmYH
/Qa6617UCHZBh6guPNzTJgWyEGjfrQwHkgEavdwPCI7CmXF4ZfDgLbUldi8HYHG9
7Xj+7KwKbkf2BJLyfB7wjpH1yP1OdOaQq/7YwCxVC8qU2GWidXpI5SyldfUwA78z
e+X90/ytNdV71SqZ9kbg87GyCrrJO2Bax+oVxQ6wq2V2HY4YsMF1PMlaGMsJeyOz
jaxgBDXyTEXQEbhpusKqWTiMQY0QNl1rSZ/Mgba4FQe7Fp6kI8kMiXGmOgY0y/3t
cWrmjPOIk+8cP56ZPO6T/fcKf78NI6bfzNoLqm8BWiyLUHALZ2QENU+b6uu4Faem
88JY/ffpMUkMvXxQ2Jk1wFkgV1RXozl4iXs/o6rTNEYssh9nfYEwGjXeCgCLOAnx
efCHFLA//xRdJk8dpwetnfU2LAYNvIrXhlcxP2QUgZuVpsNQpJgkO3fBhYFW2QRT
dzJIba8om7VbKLsG1cOi736++jZ9+KyzABGhm6qTcKsFhgjn7r42SqWTkxlnmY7y
tSJsJ9wf00GX9X2Ws2deaKQk0lRxFEf8WMhqtNJ7XTF+kpRl9tEUyLO9jsVm7D4Z
V5cgdvvOPLeBIlrtPW2D72Mn1+aqdGRVXNkvTEA+fQsHA1SJOVh41s3VMbUJe+R2
yjyFzyGWP4Svhbzdzoca
=1/Wo
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
