From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [ALTERNATE PATCH] Add a simple option parser.
Date: Sun, 07 Oct 2007 19:01:54 +0200
Message-ID: <20071007170154.GG10024@artemis.corp>
References: <1191447902-27326-1-git-send-email-krh@redhat.com> <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="XRI2XbIfl/05pQwm";
	protocol="application/pgp-signature"; micalg=SHA1
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 19:02:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeZW2-0000mY-FW
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 19:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbXJGRB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 13:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbXJGRB5
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 13:01:57 -0400
Received: from pan.madism.org ([88.191.52.104]:38846 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbXJGRB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 13:01:56 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 39CFC23CF7;
	Sun,  7 Oct 2007 19:01:55 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D4EA73CE4; Sun,  7 Oct 2007 19:01:54 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071005142507.GL19879@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60202>


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  FWIW this patch has some issues with long options parsing, I have a
fix, but am trying to migrate more builtins to this parser to see how
well it behaves.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHCRECvGr7W6HudhwRAo66AJ9YMLvd/c4Yz3/hTeZzWw7dzIkaTwCgnOO2
EBMtT8Jm89b+szI97cLqzGU=
=0kcc
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--
