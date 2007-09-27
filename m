From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Fri, 28 Sep 2007 00:28:25 +0200
Message-ID: <20070927222825.GG12427@artemis.corp>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com> <20070927185707.GC12427@artemis.corp> <46FBFDD7.1080300@gmail.com> <20070927191125.GD12427@artemis.corp> <20070927222326.GB8688@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="RDS4xtyBfx+7DiaI";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Russ Brown <pickscrape@gmail.com>, Kelvie Wong <kelvie@ieee.org>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:29:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib1qv-0005nv-T6
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 00:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758845AbXI0W23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 18:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758900AbXI0W23
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 18:28:29 -0400
Received: from pan.madism.org ([88.191.52.104]:45845 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757106AbXI0W22 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 18:28:28 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BF634221C7;
	Fri, 28 Sep 2007 00:28:26 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id AA865941F; Fri, 28 Sep 2007 00:28:25 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Theodore Tso <tytso@mit.edu>, Russ Brown <pickscrape@gmail.com>,
	Kelvie Wong <kelvie@ieee.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070927222326.GB8688@thunk.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59345>


--RDS4xtyBfx+7DiaI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2007 at 10:23:26PM +0000, Theodore Tso wrote:
> On Thu, Sep 27, 2007 at 09:11:25PM +0200, Pierre Habouzit wrote:
> > > >   And as none of the other merge tool that are supported are able to
> > > > either do 3way merges, or have a decent UI (that definitely seems t=
o be
> > > > exclusive features) I've given up on git-mergetool (and to be fair,=
 it
> > > > sucks, because it could be _sooo_ useful sometimes).
> > > >=20
> > >=20
> > > What about meld? That does 3-way merge, and the UI is fine.
> >=20
> >   Indeed, it seems that since the last time I tested it, it now does
> > diff3 merging. I should reevaluate it :)
>=20
> Pierre,
>=20
> FYI, kdiff3, meld, xxdiff, opendiff (on MacOSX), and emerge all
> support 3-way merge.

  I know, but:
  * kdiff3 often take decisions behind your back, and results in broken
    merges, so it's a no-go ;
  * xxdiff has (IMHO) a very bad and non-intuitive UI, I never get to
    make it work ;
  * I don't use macos (opendiff) ;
  * emerge is emacs right ? :)

  Though I gave meld another chance, and it works really better than it
used to, so I may give it a try :) Let's hope I won't be disappointed by
meld :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--RDS4xtyBfx+7DiaI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/C6JvGr7W6HudhwRAmZIAJ44OXOJYpB1KnGPUbw5W9JkUm3NsgCgguDC
V6X91XNjhEkkaaQM1V5cepI=
=oEfb
-----END PGP SIGNATURE-----

--RDS4xtyBfx+7DiaI--
