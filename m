From: Ivo Alxneit <ivo.alxneit@psi.ch>
Subject: [BUG/RFC git-gui] password for push/pull in case of git+ssh://repo
Date: Thu, 06 Dec 2007 15:31:57 +0100
Message-ID: <1196951517.3294.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HRvjkkhvkGC6ijkiyPpz"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 15:38:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Hs0-0002Cc-KN
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 15:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbXLFOiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 09:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbXLFOiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 09:38:09 -0500
Received: from mail14.bluewin.ch ([195.186.19.62]:52599 "EHLO
	mail14.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbXLFOiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 09:38:08 -0500
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Dec 2007 09:38:08 EST
Received: from [192.168.1.36] (83.77.172.134) by mail14.bluewin.ch (Bluewin 7.3.121)
        id 472EF4D100787D1D for git@vger.kernel.org; Thu, 6 Dec 2007 14:31:57 +0000
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67292>


--=-HRvjkkhvkGC6ijkiyPpz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

when i use git-gui (0.9.0) to push/pull to/from a git+ssh://repo i have
to supply my password to ssh. i get the password prompt from ssh on the
controlling shell. as i often use several shells and git-gui might run
in the background it is rather bothering to find the correct shell where
ssh expects the password. could this be changed (in a safe way) in
git-gui e.g. like pinentry pops up a window when gpg is used to sign
emails?

p.s. please cc me. i have not subscribed to the list

thanks
--=20
Dr. Ivo Alxneit
Laboratory for Solar Technology   phone: +41 56 310 4092
Paul Scherrer Institute             fax: +41 56 310 2688
CH-5232 Villigen                   http://solar.web.psi.ch
Switzerland                   gnupg key: 0x515E30C7


--=-HRvjkkhvkGC6ijkiyPpz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHWAfdAd7CE1FeMMcRAo1uAKC02iPap/OD/cgBqGaZbT3GAs0FYwCeI2MW
MUDyzOo2T0TPbIb5Bs9vPWw=
=fD58
-----END PGP SIGNATURE-----

--=-HRvjkkhvkGC6ijkiyPpz--
