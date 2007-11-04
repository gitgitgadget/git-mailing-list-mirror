From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/5] Update git-sh-setup(1) to allow transparent use of git-rev-parse --parseopt
Date: Sun, 04 Nov 2007 10:15:29 +0100
Message-ID: <20071104091529.GD26269@artemis.corp>
References: <1194043193-29601-1-git-send-email-madcoder@debian.org> <1194043193-29601-2-git-send-email-madcoder@debian.org> <1194043193-29601-3-git-send-email-madcoder@debian.org> <7vd4uqtpza.fsf@gitster.siamese.dyndns.org> <20071104091449.GC26269@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="2iBwrppp/7QCDedR";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, torvalds@linux-foundation.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 10:15:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioba7-0003D3-MP
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 10:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbXKDJPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 04:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbXKDJPd
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 04:15:33 -0500
Received: from pan.madism.org ([88.191.52.104]:34068 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568AbXKDJPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 04:15:32 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 89D8125ACB;
	Sun,  4 Nov 2007 10:15:31 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 231F63C887; Sun,  4 Nov 2007 10:15:29 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, torvalds@linux-foundation.org,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071104091449.GC26269@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63366>


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On dim, nov 04, 2007 at 09:14:49 +0000, Pierre Habouzit wrote:
> On Sun, Nov 04, 2007 at 07:43:53AM +0000, Junio C Hamano wrote:
> > Trust me that this kind of backdoor, especially when the
> > intended uses of the backdoor is not documented well, will be
> > abused by (perhaps clueless, perhaps curious, perhaps fearless)
> > users and you will get blamed.
>=20
>   That has been fixed, and documented in git-sh-setup. I renumbered my 3
> patches incorrectly though. Those are supposed to supersede patches 2, 4,=
 and 9.

  And I'm stupid this obviously doesnt work doh..... sorry, I'll
rethought this.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLY2xvGr7W6HudhwRAjU/AJ9mI0hPB/HvqY30xzVleF739oIFkgCeNzG4
2FqjeRF0OzwBq4k/pyeOULE=
=+8Ys
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
