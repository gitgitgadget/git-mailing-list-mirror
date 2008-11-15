From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 23:12:12 +0100
Message-ID: <20081115221212.GC11895@artemis.corp>
References: <491DE6CC.6060201@op5.se> <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org> <20081114234658.GA2932@spearce.org> <20081115123916.GN24201@genesis.frugalware.org> <7vk5b55ekb.fsf@gitster.siamese.dyndns.org> <20081115193327.GS24201@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="s9fJI615cBHmzTOP";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 23:13:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1TOW-0008UZ-Kq
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 23:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbYKOWMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 17:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbYKOWMR
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 17:12:17 -0500
Received: from pan.madism.org ([88.191.52.104]:47590 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbYKOWMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 17:12:16 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 3AC513062D;
	Sat, 15 Nov 2008 23:12:14 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7E17A2A346; Sat, 15 Nov 2008 23:12:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081115193327.GS24201@genesis.frugalware.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101092>


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2008 at 07:33:27PM +0000, Miklos Vajna wrote:
> On Sat, Nov 15, 2008 at 05:00:52AM -0800, Junio C Hamano <gitster@pobox.c=
om> wrote:
> > Under LGPL, you must provide linkable object files to your (possibly
> > closed source) program, so that people who made changes to (or obtained=
 an
> > updated version of) a LGPL'ed library can re-link your program and use =
the
> > updated library.  The above does not ask you to do so.
> >=20
> > The way I read LGPL is that "We deeply care about our LGPL library and =
any
> > improvements to it.  Although we do not care at all about how your crap=
py
> > closed source program is written, we want to make sure that the users c=
an
> > keep using your program after improvements are made to our library.".  I
> > do not think it makes a practical difference when your program uses the
> > LGPL library as a shard library from that point of view.
>=20
> Ah, I see - so this is a "Lesser LGPL". :)

LGPL also has a clause that allow the user to make it become GPLv2 or
later, even if you chose LGPL v2.1 *only* (as in not LGPL v2.1 or later).

Seeing how the FSF has just decided to use those upgrade clauses with
the GFDL, I'm not really likely to fancy the use of any license that
forces me to accept an "or later" clause. I would be _really_ against
the LGPL FWIW.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkfSTwACgkQvGr7W6Hudhy+LgCfe6teNcEbDAaAQA2XZBlGJrGc
gW0AniXVecZWVH7MVnfpXtM1pMRSyOl2
=nLbc
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
