From: =?utf-8?q?K=C4=81rlis_Repsons?= <k@11.lv>
Subject: Re: What happens in this example case?
Date: Tue, 6 Apr 2010 16:25:55 +0000
Message-ID: <201004061625.58742.k@11.lv>
References: <201004060913.56760.k@11.lv> <loom.20100406T173712-277@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1712256.cir9MThjjp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 18:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzBbR-0007Qd-1T
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 18:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446Ab0DFQ0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 12:26:07 -0400
Received: from [85.15.210.5] ([85.15.210.5]:48527 "EHLO pasts.trikata.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755976Ab0DFQ0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 12:26:04 -0400
Received: from keeper.loca (unknown [85.15.210.9])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pasts.trikata.com (Postfix) with ESMTPSA id 65AD96E7DA;
	Tue,  6 Apr 2010 19:29:50 +0300 (EEST)
Received: from station.localnet (station [192.168.7.93])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by keeper.loca (Postfix) with ESMTPSA id 7A90314FDD05;
	Tue,  6 Apr 2010 16:25:59 +0000 (GMT)
User-Agent: KMail/1.12.4 (Linux/2.6.32-gentoo-r7-2010-03-28; KDE/4.3.5; x86_64; ; )
In-Reply-To: <loom.20100406T173712-277@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144154>

--nextPart1712256.cir9MThjjp
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 April 2010 15:42:05 Eric Raible wrote:
> Hi,
> it would be good if someone did basic research before asking such
>  questions.
>=20
> Start with http://book.git-scm.com.
Thanks, silly enough I didn't see that link in the documentation page, wher=
e=20
"Git Community Book : The git-scm.com community-built comprehensive online=
=20
book" was just a headline of some kind to me...

So, as I now understand it: git stores all unique contents of a file into a=
=20
blob; there is no need to descend into the previous commits to get the actu=
al=20
contents of a file (as I was admitting, it could happen with help of diffs).

--nextPart1712256.cir9MThjjp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAku7YJYACgkQHuSu329e3GHtWwCfeG4maDdc3fqEjpu6YfzUMoxg
8rMAoMGdZ77cgSRca9tfsr9bKO9iYkRE
=7/TY
-----END PGP SIGNATURE-----

--nextPart1712256.cir9MThjjp--
