From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 21:16:14 +0200
Message-ID: <20070927191614.GE12427@artemis.corp>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com> <20070927185707.GC12427@artemis.corp> <20070927191201.GA31807@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Oiv9uiLrevHtW1RS";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Kelvie Wong <kelvie@ieee.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:16:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IayqW-00042m-BR
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbXI0TQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbXI0TQR
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:16:17 -0400
Received: from pan.madism.org ([88.191.52.104]:39874 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541AbXI0TQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:16:16 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3379D2214D;
	Thu, 27 Sep 2007 21:16:15 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D1AB232FD8A; Thu, 27 Sep 2007 21:16:14 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, Kelvie Wong <kelvie@ieee.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070927191201.GA31807@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59316>


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2007 at 07:12:01PM +0000, Jeff King wrote:
> On Thu, Sep 27, 2007 at 08:57:07PM +0200, Pierre Habouzit wrote:
>=20
> >   Which tool are you using ? kdiff3 ? I've noticed that it often fails
> > miserably, or worse, create bad merges silentely with it.
> >=20
> >   And as none of the other merge tool that are supported are able to
> > either do 3way merges, or have a decent UI (that definitely seems to be
> > exclusive features) I've given up on git-mergetool (and to be fair, it
> > sucks, because it could be _sooo_ useful sometimes).
>=20
> Huh? I use xxdiff all the time, and it works fine.

  I'm sorry but I find that the UI is terrible.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/AF+vGr7W6HudhwRAqL8AJ9X28/2ra3uV2keoKp0ju4Phj5+kACeIm+W
JhWhlRlMf5VgtdM6mNMY6lU=
=lfYF
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
