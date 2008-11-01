From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 19:48:50 +0100
Message-ID: <20081101184850.GH26229@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org> <20081101173042.GE26229@artemis.corp> <490CA37C.1070107@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="82evfD9Ogz2JrdWZ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 01 19:50:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwLYQ-0003qu-7f
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 19:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbYKASsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 14:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753834AbYKASsz
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 14:48:55 -0400
Received: from pan.madism.org ([88.191.52.104]:44083 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753828AbYKASsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 14:48:54 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id C8B153B82C;
	Sat,  1 Nov 2008 19:48:51 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 660CC5EE245; Sat,  1 Nov 2008 19:48:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <490CA37C.1070107@op5.se>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99760>


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 06:44:12PM +0000, Andreas Ericsson wrote:
> Pierre Habouzit wrote:

> >For types that _will_ be in the tight loops, we must make the types
> >explicit or it'll bite us hard performance-wise. I'm thinking what is
> >"struct object" or "struct commit" in git.git. It's likely that we will
> >loose a *lot* of those types are opaque.
>=20
> The last sentence doesn't parse. I assume you mean "if those types=20
> are..",

This was a typo, indeed s/of/if/

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkMpJIACgkQvGr7W6HudhwFuwCfUtsQuZle+PFnSJ52PVz6QIaN
DnwAnRo9zN5xuijdjGUYJabbJMc4xIE0
=YuFF
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
