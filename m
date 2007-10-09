From: Pierre Habouzit <madcoder@debian.org>
Subject: public repository
Date: Tue, 09 Oct 2007 15:04:00 +0200
Message-ID: <20071009130400.GA27301@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="PNTmBPCT7hxwcZjr";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:05:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfElU-0006SG-Bq
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbXJINEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752978AbXJINEJ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:04:09 -0400
Received: from pan.madism.org ([88.191.52.104]:38518 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939AbXJINEH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:04:07 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 817F424258
	for <git@vger.kernel.org>; Tue,  9 Oct 2007 15:04:06 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 9249F543; Tue,  9 Oct 2007 15:04:00 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60403>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Under popular demand^W^W^Wbecause Jonas asked for my parse_options
work, I've put my git topic branches on a public repository on
git://git.madism.org/git.git.

  master/next are my known positions of master and next at the time I
pushed last. ph/* are topic branches I work on, they should be either
bsaed on master or next (hence are rebased until merged into git.git or
dropped).

  Right now, there is ph/strbuf with the 1+2 series that generated this
heated discussion before. There is also ph/parseopt: a 10+ series
featuring krh parse_options, with some rework on my end to support more
features, and I migrate a dozen of builtins to use them (in this topic
branch, `git rm -rf ...` works !)

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHC3xAvGr7W6HudhwRAoPbAJ4nhpvMVLVPfWhaD70/WBgZFFyvOQCaAhOQ
LmmwEaHaDdIIXricMCAc6K0=
=fODC
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
