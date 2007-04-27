From: Johannes Berg <johannes@sipsolutions.net>
Subject: gitweb search page link slightly wrong
Date: Fri, 27 Apr 2007 22:43:13 +0200
Message-ID: <1177706593.3565.59.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Zzl+Etjy2sQN1UecxzLr"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 22:43:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhXHf-00071r-Bc
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 22:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757187AbXD0UnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757222AbXD0UnM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 16:43:12 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:39290 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757187AbXD0UnK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 16:43:10 -0400
Received: from [84.135.193.106] (helo=[10.0.0.4])
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.66)
	(envelope-from <johannes@sipsolutions.net>)
	id 1HhXHY-0004Nh-LL
	for git@vger.kernel.org; Fri, 27 Apr 2007 21:43:09 +0100
X-Mailer: Evolution 2.8.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45751>


--=-Zzl+Etjy2sQN1UecxzLr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Just noticed on the git.kernel.org interface that when you do a search
for something that includes an "@" sign, then the "next page" link will
include "\@" instead and gitweb won't actually find anything on the next
page. No idea if that bug was fixed already somewhere else, but at least
it's visible on git.kernel.org.

johannes

--=-Zzl+Etjy2sQN1UecxzLr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMmBh/ETPhpq3jKURAn9JAJkBhH1eUkL38/dBhkYfW9v6a1Xp2gCgqHOF
KBn0i5CFGMM5Gsco9y2I8gY=
=Kmgk
-----END PGP SIGNATURE-----

--=-Zzl+Etjy2sQN1UecxzLr--
