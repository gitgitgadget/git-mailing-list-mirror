From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 22:21:17 +0200
Message-ID: <20070603202117.GG30347@artemis>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org> <20070603133109.GD14336@artemis> <200706031548.30111.johan@herland.net> <20070603151921.GB30347@artemis> <20070603200431.GF6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="64j1qyTOoGvYcHb1";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 22:21:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuwZp-000509-U6
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 22:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbXFCUVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 16:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbXFCUVT
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 16:21:19 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:37834 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbXFCUVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 16:21:18 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 6279E18DE0;
	Sun,  3 Jun 2007 22:21:17 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3D9AF4BB67; Sun,  3 Jun 2007 22:21:17 +0200 (CEST)
Mail-Followup-To: Yann Dirson <ydirson@altern.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20070603200431.GF6992@nan92-1-81-57-214-146.fbx.proxad.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49031>


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2007 at 10:04:31PM +0200, Yann Dirson wrote:
> One thing that I just thought about is how such a system would play
> with eg. StGIT.

  I read the rest of the mail, but I don't know stgit at all, so I'm not
really able to tell how well it would integrate, especially since well,
it's still early.

  But for sure, I'm launching that brainstorming thread because I want
as much input as possible to know what are people needs, and add the one
that make sense to the todo list, the one that would be good to the
wishlist. FWIW playing well with usual git tools (like stgit, guilt, and
whatever other evolved "thing" in the git nebula) is definitely in the
TODO list.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGYyK9vGr7W6HudhwRAhT1AKCIRQ4HKifpg0IPMshBuxjlCfe0/gCgic0U
lUM/cyDFGpVshOAKtRR8QFI=
=pYEK
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
