From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 20:57:07 +0200
Message-ID: <20070927185707.GC12427@artemis.corp>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/Uq4LBwYP4y1W6pO";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Kelvie Wong <kelvie@ieee.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:57:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IayYT-0005T8-Uh
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 20:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757887AbXI0S5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 14:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754936AbXI0S5M
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 14:57:12 -0400
Received: from pan.madism.org ([88.191.52.104]:57887 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756524AbXI0S5K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 14:57:10 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1FA3622143;
	Thu, 27 Sep 2007 20:57:08 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BE64A9280; Thu, 27 Sep 2007 20:57:07 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Kelvie Wong <kelvie@ieee.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59309>


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2007 at 06:31:19PM +0000, Kelvie Wong wrote:
> At work, I've been using a git-svn import for my daily workflow (still
> somewhat of a git newbie, but now has come to the point where it's
> tough to work without it), and while rebasing from svn (on a rather
> old branch), I found that the mergetool option does not work too well
> for me.

  Which tool are you using ? kdiff3 ? I've noticed that it often fails
miserably, or worse, create bad merges silentely with it.

  And as none of the other merge tool that are supported are able to
either do 3way merges, or have a decent UI (that definitely seems to be
exclusive features) I've given up on git-mergetool (and to be fair, it
sucks, because it could be _sooo_ useful sometimes).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+/0DvGr7W6HudhwRAl2YAJoCEuuCkWOn4giF+H9jD9GAbciJTgCfSNUo
JNMIR9IdczveRbKGLJetbqk=
=qMj/
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
