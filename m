From: Pierre Habouzit <madcoder@debian.org>
Subject: THREADED_DELTA_SEARCH
Date: Thu, 10 Jul 2008 09:53:27 +0200
Message-ID: <20080710075327.GD24819@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="pQhZXvAqiZgbeUkD";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 09:54:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGqyx-0002on-5A
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 09:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYGJHx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 03:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYGJHx3
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 03:53:29 -0400
Received: from pan.madism.org ([88.191.52.104]:36483 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbYGJHx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 03:53:29 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 886153475F
	for <git@vger.kernel.org>; Thu, 10 Jul 2008 09:53:28 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A3D574098; Thu, 10 Jul 2008 09:53:27 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87957>


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


  I'm using it in production for quite a long time now, and I wonder if
there is any specific reason why it's not default. Debian activated it
by default too a couple of weeks ago, which means that it's in
production on quite a large scale, and there are no issues reported
either. Would a patch making it default be accepted ? It's quite handy
given that SMP machines are really pervasive nowadays=E2=80=A6

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkh1v/cACgkQvGr7W6HudhxaAACcDrJ+VjcN2e1NiziAGhvagkau
77cAn3FE6QhK2kBWLLFQBAgtQIGaMzvA
=3dTL
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
