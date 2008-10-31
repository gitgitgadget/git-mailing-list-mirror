From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 22:51:55 +0100
Message-ID: <20081031215155.GC21799@artemis.corp>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <alpine.DEB.1.10.0810311325490.5851@asgard.lang.hm> <alpine.LFD.2.00.0810311651451.13034@xanadu.home> <20081031214356.GX14786@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="V88s5gaDVPzZ0KCq";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Nicolas Pitre <nico@cam.org>, david@lang.hm, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 22:53:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw1vk-0004Rl-Bq
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 22:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbYJaVwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 17:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbYJaVwA
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 17:52:00 -0400
Received: from pan.madism.org ([88.191.52.104]:40100 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbYJaVv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:51:59 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 3E9B03B71E;
	Fri, 31 Oct 2008 22:51:57 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 987845EE242; Fri, 31 Oct 2008 22:51:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081031214356.GX14786@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99653>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 09:43:56PM +0000, Shawn O. Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > On Fri, 31 Oct 2008, david@lang.hm wrote:
> > > at the very least you should go from GPLv2 to LGPLv2 for the library.
> >=20
> > Sure.
>=20
> Well, we cannot do a GPL->LGPL switch on code without author
> permission for that sort of re-licensing.
>=20
> That said, I think many authors of git.git code would be more
> comfortable with a GPL->LGPL change, where they wouldn't be OK with
> a GPL->BSD/MIT change.  There may be some folks though who still
> wouldn't accept a GPL->LGPL move.

FWIW, I dislike the LGPL for many reasons, and I prefer 100x times a GPL
with GCC kind of exceptions. But if other people hate it, I wont be
be a problem and refuse it.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLffoACgkQvGr7W6HudhwGlQCfST6TE322s2AgT3saThPA9hsV
nTQAoJ44vdVNBfOp9jmpsG/lRqiWumgC
=rYeI
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
