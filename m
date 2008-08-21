From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Git-aware Issue Tracking?
Date: Thu, 21 Aug 2008 10:30:42 +0200
Message-ID: <20080821083042.GA6517@artemis.corp>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <20080819175931.GH20947@spearce.org> <200808192121.30372.robin.rosenberg.lists@dewire.com> <48AB84A2.7010905@gmail.com> <20080820141326.GA3483@spearce.org> <20080820152305.GJ10544@machine.or.cz> <m3fxozsepa.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="G4iJoqBmSsgzjUCe";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 10:32:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW5aL-0004Vy-As
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 10:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbYHUIau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 04:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbYHUIat
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 04:30:49 -0400
Received: from pan.madism.org ([88.191.52.104]:60798 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbYHUIaq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 04:30:46 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 3864132284;
	Thu, 21 Aug 2008 10:30:43 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D28EB68FB; Thu, 21 Aug 2008 10:30:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3fxozsepa.fsf@localhost.localdomain>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93119>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2008 at 06:52:24PM +0000, Jakub Narebski wrote:
> Petr Baudis <pasky@suse.cz> writes:
>=20
> > On Wed, Aug 20, 2008 at 07:13:26AM -0700, Shawn O. Pearce wrote:
> > > I've thought about starting a code.google.com project just to use
> > > the issue tracking system there.  I'm using an internal tool to
> > > keep of issues for myself, but that's not fair to the end-users or
> > > other contributors...
> >=20
> > I have been thinking about issue tracking for some of my projects too,
> > but I'm wondering, does anyone have a comprehensive picture of the state
> > of the Git-supporting issue tracking tools, especially those that keep
> > the tracked issues in a Git repository as well?
> >=20
> > 	http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-73b23f376ebd=
0222d1e4b08f09158172aa34c24f
> >=20
> > has three, but two of them are in Ruby, which is rather discouraging.
> > But Cil (in Perl) is already "self-hosting", so it might be well usable?
>=20
> There is also Bugs Everywhere, written in Python, which supposedly has
> (some form of) Git support:
>   http://git.or.cz/gitwiki/InterfacesFrontendsAndToolsWishlist#be
>=20
> There was also 'grit' by Pierre Habouzit, also in Python, which got
> abandoned and removed (also from wiki):
> http://git.or.cz/gitwiki/InterfacesFrontendsAndTools?action=3Ddiff&rev2=
=3D203&rev1=3D202
> If I remember correcly Pierre promised to write down what he learned
> about distributed bug tracking from his work on grit[*1*], when he had
> a bit of free time, but I don't remember him doing it...

  Actually there is a list, bugs-dist@kitenet.net or sth similar where I
did it. One should look at the archives of that list. Though it's
somehow dead again.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkitJ7EACgkQvGr7W6Hudhyf0wCgimVQ1/rChq/MUECX8PDCys8d
p5sAn19R5LJm6mtkY/NVstlY8laba3RR
=9hdA
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
