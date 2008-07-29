From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 15:19:08 +0200
Message-ID: <20080729131908.GG32312@artemis.madism.org>
References: <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com> <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com> <20080729082135.GB32312@artemis.madism.org> <20080729083755.GC32312@artemis.madism.org> <20080729085125.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807291413460.4631@eeepc-johanness> <20080729130713.GF32312@artemis.madism.org> <alpine.DEB.1.00.0807291511400.4631@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="V32M1hWVjliPHW+c";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Petr Baudis <pasky@suse.cz>, Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:20:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNp7d-0000i6-1v
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 15:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbYG2NTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 09:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYG2NTM
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 09:19:12 -0400
Received: from pan.madism.org ([88.191.52.104]:35078 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbYG2NTL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 09:19:11 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 11A393BC07;
	Tue, 29 Jul 2008 15:19:09 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 30EFDAB9A; Tue, 29 Jul 2008 15:19:08 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, Benjamin Collins <aggieben@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807291511400.4631@eeepc-johanness>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90638>


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2008 at 01:15:10PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 29 Jul 2008, Pierre Habouzit wrote:
>=20
> > On Tue, Jul 29, 2008 at 12:15:05PM +0000, Johannes Schindelin wrote:
> > > On Tue, 29 Jul 2008, Petr Baudis wrote:
> > > > On Tue, Jul 29, 2008 at 10:37:55AM +0200, Pierre Habouzit wrote:
> > > >=20
> > > > > 	path =3D "$path"
> > > > > 	url =3D git://somewhere/
> > > > > 	tracks =3D master
> > [...]
> > > But then, how does the relation to the currently _committed_ state ge=
t=20
> > > displayed?

> > Or you need the submodule to be aware he's one, and then one would have=
=20
> > some kind of "magic" word to name this sha1. And tools would find out i=
n=20
> > the supermodule what it translates into.
>=20
> You lost me there.

  Then I didn't understand your question.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiPGMwACgkQvGr7W6HudhwnbgCeOPvrukDadLcOmct9D/WXLJbe
LokAn1lZmod1HJ5NYqjDRHfMINDeF17T
=WJKt
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
