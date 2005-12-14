From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: StGIT usage
Date: Wed, 14 Dec 2005 17:53:04 +0100
Message-ID: <20051214165304.GA9272@ferdyx.org>
References: <68948ca0512140844u677fea36ob94bdf213a6a110@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
X-From: git-owner@vger.kernel.org Wed Dec 14 17:58:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmZsS-0004q9-6x
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 17:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVLNQxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 11:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVLNQxN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 11:53:13 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:48776
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S932400AbVLNQxM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 11:53:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 862568D33E
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 17:48:28 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03542-09 for <git@vger.kernel.org>;
	Wed, 14 Dec 2005 17:48:25 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 005F18D33B
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 17:48:23 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Wed, 14 Dec 2005 17:53:05 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <68948ca0512140844u677fea36ob94bdf213a6a110@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13633>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2005 at 11:44:34AM -0500, Don Zickus wrote:
| I couldn't find in the StGIT documentation on how to use a 'series'
| file or to pull a whole bunch of patches from a directory.  It seems
| the import command could only handle a patch at a time.  Any
| tips/help?

If import will do once at a time, and you are sure all of them apply
cleanly; why don't you just use a for + import over the patches ?

Cheers,
Ferdy

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDoE3wCkhbDGC9KNQRAoimAKCOSiDvl0oo2ltjiYStu53lSufp/QCdGPO8
e8JE88kMyVfVH52b3rCDDp4=
=Bu0d
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
