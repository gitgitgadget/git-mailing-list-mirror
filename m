From: alxneit <ivo.alxneit@psi.ch>
Subject: expat.h missing
Date: Sun, 6 Nov 2005 21:39:04 +0100
Message-ID: <200511062139.15622.ivo.alxneit@psi.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1828835.2dkGyjdeUF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Nov 06 20:29:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYqCT-0000hB-SL
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 20:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVKFT3B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 14:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVKFT3B
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 14:29:01 -0500
Received: from mail12.bluewin.ch ([195.186.19.61]:48585 "EHLO
	mail12.bluewin.ch") by vger.kernel.org with ESMTP id S1751095AbVKFT3A
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 14:29:00 -0500
Received: from [192.168.1.33] (83.77.94.62) by mail12.bluewin.ch (Bluewin 7.2.068.1)
        id 435F84AF002C64E9 for git@vger.kernel.org; Sun, 6 Nov 2005 19:28:59 +0000
To: git <git@vger.kernel.org>
User-Agent: KMail/1.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11224>

--nextPart1828835.2dkGyjdeUF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Nick Hengevelds patch to add support for pushing to a remote repository usi=
ng=20
HTTP/DAV (58e60dd203362ecb9fdea765dcc2eb573892dbaf)
introduces "#include expat.h" in http-push.c. this file seems to be missing.

=2D-=20
Dr. Ivo Alxneit
Laboratory for Solar Technology   phone: +41 56 310 4092
Paul Scherrer Institute             fax: +41 56 310 2688
CH-5232 Villigen                   http://solar.web.psi.ch
Switzerland                   gnupg key: 0x515E30C7

--nextPart1828835.2dkGyjdeUF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDbmnzAd7CE1FeMMcRAkwaAJ4yaGozptPW04TCGQSZIiQGmI5s/wCfbmV1
HyV1QKIH8v9Mtl0O71PBSnY=
=0b0b
-----END PGP SIGNATURE-----

--nextPart1828835.2dkGyjdeUF--
