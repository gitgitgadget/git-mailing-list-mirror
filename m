From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 04 Nov 2007 12:38:52 +0100
Message-ID: <20071104113852.GE26269@artemis.corp>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="lteA1dqeVaWQ9QQl";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 12:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iodor-0007Le-2G
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349AbXKDLiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753411AbXKDLiz
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:38:55 -0500
Received: from pan.madism.org ([88.191.52.104]:56106 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753355AbXKDLiy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 06:38:54 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7287328642;
	Sun,  4 Nov 2007 12:38:52 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 795353F28A; Sun,  4 Nov 2007 12:38:52 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63385>


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2007 at 04:14:19AM +0000, Junio C Hamano wrote:
> * ph/parseopt-sh (Fri Nov 2 23:39:52 2007 +0100) 5 commits
>  - Migrate git-am.sh to use git-rev-parse --parseopt
>  - Migrate git-clone to use git-rev-parse --parseopt
>  - Migrate git-clean.sh to use git-rev-parse --parseopt.
>  - Update git-sh-setup(1) to allow transparent use of git-rev-parse -
>    -parseopt
>  - Add a parseopt mode to git-rev-parse to bring parse-options to
>    shell scripts.
>=20
> Together with today's batch which is missing from the above
> list, hopefully merge to 'next' over the weekend.

  Please note that the last resend has the issues you raised fixed and
that it modifies git-clone and git-sh-setup commits from above.

  Someone proposed many fixes in the documentation too, I wont do it
because (again) I'm not a native speaker so I let that ungrateful job to
someone actually able to do it.

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLa9MvGr7W6HudhwRAmrGAJ9mrZokTEix/qlrQwe0nCegtoB7qQCbB2R6
Z7gynrXa+YO1gZ0+rhTtSqY=
=vdDo
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
