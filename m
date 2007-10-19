From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Subversion developer: svn is for dumb people
Date: Fri, 19 Oct 2007 15:19:34 +0200
Message-ID: <20071019131934.GD4404@artemis.corp>
References: <47176CE0.7030609@midwinter.com> <20071019113447.GC4404@artemis.corp> <Pine.LNX.4.64.0710191514190.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="BRE3mIcgqKzpedwo";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Steven Grimm <koreth@midwinter.com>, 'git' <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 19 15:19:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IirlU-00060x-AM
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 15:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513AbXJSNTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 09:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757264AbXJSNTh
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 09:19:37 -0400
Received: from pan.madism.org ([88.191.52.104]:42372 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756172AbXJSNTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 09:19:36 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2037E25D33;
	Fri, 19 Oct 2007 15:19:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6A0CD3577AD; Fri, 19 Oct 2007 15:19:34 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>, 'git' <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710191514190.16728@wbgn129.biozentrum.uni-wuerzburg.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61704>


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2007 at 01:17:05PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 19 Oct 2007, Pierre Habouzit wrote:
>=20
> > On Thu, Oct 18, 2007 at 02:25:36PM +0000, Steven Grimm wrote:
> > > Thought folks here might get a kick out of this:
> > >=20
> > > http://blog.red-bean.com/sussman/?p=3D79
> > >=20
> > > Okay, my summary is slightly facetious, but that's basically the gist=
=20
> > > of what he's saying: you should choose Subversion rather than a DVCS=
=20
> > > because most of your users won't be smart enough to use the better=20
> > > tool.
> > >=20
> > > I can't say he's completely wrong, especially about the 20/80% idea=
=20
> > > (though I think "20%" is generous), but some of his specific argument=
s=20
> > > about DVCS are on the bogus side. "Centralized systems encourage code=
=20
> > > reviews," for one -- I challenge him to find a project with a more=20
> > > pervasive and effective code-reviewing culture than the git project.
> >=20
> >   Your argument is also bogus.
> >=20
> >   IMNSHO, peer reviewing has nothing to do with git, svn, or $SCM. It's=
=20
> > a social pattern. There are people that do it because they understand=
=20
> > it's a good and necessary sound thing to do, and there are the others.=
=20
> > Guess what, it has a lot to do with the 20%/80% line (that I would have=
=20
> > more described as the 2/98 but well=E2=80=A6).
>=20
> I tend to disagree.  Git at least _enables_ you to have the=20
> one-committer-per-repository scheme, it even _encourages_ it to a certain=
=20
> extent.
>=20
> And once you go that route, it is easy to see that the committer says "I=
=20
> will not let that _crap_ enter my repository."  Bingo, peer review.
>=20
> Compare that to a centralised repository, where more often than not, the=
=20
> administrator is not even part of the developer community!  It is much=20
> easier not to feel too responsible for the code you are committing there.

  I agree, that's why I said that git made it easier. WHat I pretend to
be wrong is to say that a SCM will make people review code or not. Git
merely help people that want to always review code to be completely sure
some review has happened before the code is merged. But nothing in git
forbids you to use the big fat <centralized repo with everyone having
push access to it>-mode.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHGK7mvGr7W6HudhwRAiBcAJwPCinYEb+UYQkySXVZ3wMaFydUsQCgpop2
R21K4xt9+oY6VyGI52M5v2Q=
=4KyL
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
