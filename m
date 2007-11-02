From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Bring parse_options to the shell
Date: Fri, 02 Nov 2007 16:14:53 +0100
Message-ID: <20071102151453.GB27505@artemis.corp>
References: <1194016162-23599-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="yNb1oOkm5a9FJOVX";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: gitster@pobox.com, torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Fri Nov 02 16:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InyFE-00066Q-Ep
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbXKBPOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 11:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754458AbXKBPOz
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:14:55 -0400
Received: from pan.madism.org ([88.191.52.104]:52138 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753911AbXKBPOy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:14:54 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6AA052814B;
	Fri,  2 Nov 2007 16:14:53 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0E5872892; Fri,  2 Nov 2007 16:14:53 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	torvalds@linux-foundation.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1194016162-23599-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63129>


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2007 at 03:09:18PM +0000, Pierre Habouzit wrote:
> This is also something that itches me, so here is a proposal for a
> git-parseopt helper that can be used in shell scripts as an option
> normalizer like getopt(1) does.
>=20
> I migrated the discussed git-clean.sh to use it as a proof of concept.

  Needless to say, this is fetchable from
git://git.madism.org/git.git#ph/parseopt

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHKz7tvGr7W6HudhwRAvbBAJ4zEfYTGM1zgZy+sEcCXrN1iCvUTACfQlEc
LyddBL4tA9EeRfACPzSpc7E=
=giwm
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
