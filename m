From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git push refspec problem
Date: Wed, 07 Nov 2007 16:38:52 +0100
Message-ID: <20071107153852.GM18057@artemis.corp>
References: <7B37E361-9606-447C-B853-001182688AFA@nc.rr.com> <Pine.LNX.4.64.0711071510480.4362@racer.site> <20071107152003.GL18057@artemis.corp> <EA230407-45F1-4F7E-8415-A43ECF940856@nc.rr.com> <4731D918.6040106@hackvalue.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="VB1oQhYtJt8uuzk+";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: James <jtp@nc.rr.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipmzl-0006mS-3v
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbXKGPiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbXKGPiy
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:38:54 -0500
Received: from pan.madism.org ([88.191.52.104]:34479 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbXKGPix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:38:53 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 127CF28F23;
	Wed,  7 Nov 2007 16:38:53 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id AF96F1AB42; Wed,  7 Nov 2007 16:38:52 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Gilger <heipei@hackvalue.de>, James <jtp@nc.rr.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4731D918.6040106@hackvalue.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63828>


--VB1oQhYtJt8uuzk+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2007 at 03:26:16PM +0000, Johannes Gilger wrote:
> James wrote:
> > There has to be *some* way of pulling through git and pushing through
> > ssh with a simple "git push".  :-P  I'm doing it manually, after all.  I
> > could have sworn I've read how to do its somewhere but have since
> > forgotten.
>=20
> Would two remotes do the trick? One remote only has a fetch entry
> while the other one has a push entry.

  Yes you can do that, but that means you have to spell out the remote
name either for fetching or pushing which somehow sucks :)


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--VB1oQhYtJt8uuzk+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMdwMvGr7W6HudhwRAsL9AJ97Ek+bmdFwPIGMftZsYcMfPiPctACfZFx3
c61v4h6oYPptyKzIUXUTnqo=
=8aCz
-----END PGP SIGNATURE-----

--VB1oQhYtJt8uuzk+--
