From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: xmemdup patches
Date: Mon, 17 Sep 2007 19:43:20 +0200
Message-ID: <20070917174320.GA16893@artemis.corp>
References: <20070917161113.GB460@artemis.corp> <Pine.LNX.4.64.0709171739010.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="lrZ03NoBR/3+SXJZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:44:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXKd8-0000sl-7W
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 19:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbXIQRn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 13:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbXIQRn0
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 13:43:26 -0400
Received: from pan.madism.org ([88.191.52.104]:48320 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbXIQRnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 13:43:25 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 0248F2029B;
	Mon, 17 Sep 2007 19:43:20 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3C6224CA53; Mon, 17 Sep 2007 19:43:20 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709171739010.28586@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58466>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2007 at 04:39:23PM +0000, Johannes Schindelin wrote:
> On Mon, 17 Sep 2007, Pierre Habouzit wrote:
> >   I'm not a huge fan of "xmemdup" as I would not have supposed that a
> > function called like that would add the extra NUL, so I'm 100% okay with
> > someone coming up with any better name.
>
> xmemdupz()?

  Why not, it's definitely better than xmemdupasstring ;)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7ry4vGr7W6HudhwRAhY+AJ94X3nXt8yNLXmYWtZ67PhKAe1O3wCfTgFH
JiPbrkABq8rZZ7D3A14IkrY=
=PMGz
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
