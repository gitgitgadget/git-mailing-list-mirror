From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Migration of builtin-blame to parse-option
Date: Tue, 08 Jul 2008 12:02:34 +0200
Message-ID: <20080708100234.GA19202@artemis.madism.org>
References: <1215510964-16664-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="d6Gm4EdcadzBjdND";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 12:06:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGA2o-0005zH-J9
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 12:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbYGHKCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 06:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbYGHKCh
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 06:02:37 -0400
Received: from pan.madism.org ([88.191.52.104]:50368 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387AbYGHKCg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 06:02:36 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 057B7281B9;
	Tue,  8 Jul 2008 12:02:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id F30192AF9D6; Tue,  8 Jul 2008 12:02:34 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, torvalds@linux-foundation.org,
	gitster@pobox.com, peff@peff.net
Content-Disposition: inline
In-Reply-To: <1215510964-16664-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87740>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  While rebasing this branch on the latest next, I had a conflict for
the patch 1 that I fixed, and I also fixed spacing issues in patches 4
and 6. The fixed series is on my public git repo[0], but it's really
like this one, so I don't see the point in flooding again with it ;)

  [0] git://git.madism.org/~madcoder/git.git#ph/parseopt

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhzOzkACgkQvGr7W6Hudhx+RACcC/shX3QOA4wDzrui28OonBrK
LH0AnRnswPx5Pf0YtOPxTcx53/HtPE/o
=vJrE
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
