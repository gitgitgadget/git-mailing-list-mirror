From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: [Announce] gitview-0.1
Date: Wed, 1 Feb 2006 22:02:04 +0100
Message-ID: <20060201210204.GB15900@ferdyx.org>
References: <cc723f590601312016vabba201ye6d3739b3927f1a@mail.gmail.com> <20060201205805.GA6384@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Cc: Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 22:02:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4P7G-0005Ox-Ag
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 22:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422927AbWBAVCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 16:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWBAVCK
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 16:02:10 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:27533
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S932453AbWBAVCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 16:02:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 78E668D34B;
	Wed,  1 Feb 2006 21:56:37 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05424-09; Wed, 1 Feb 2006 21:56:35 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id A69F48D343;
	Wed,  1 Feb 2006 21:56:34 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Wed,  1 Feb 2006 22:02:04 +0100 (CET)
To: Alex Riesen <raa.lkml@gmail.com>
Mail-Followup-To: Alex Riesen <raa.lkml@gmail.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060201205805.GA6384@steel.home>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15447>


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2006 at 09:58:05PM +0100, Alex Riesen wrote:
| Gentoo, Python 2.4.2, pycairo 1.0.2.

Just upgrade to a newer pygtk and it'll work fine:

[ebuild   R   ] dev-python/pygtk-2.8.2  -doc +opengl 0 kB

I had the same problem until I installed the above version.

Cheers,
Ferdy

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD4SHMCkhbDGC9KNQRAkBRAJ0V7PjEio/UYvvAxiqJ8KkEN/chogCcD9No
/BTcyFuMaMELHPzOb2c9/0k=
=M4cc
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--
