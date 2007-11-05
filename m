From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in  git, help users out.
Date: Mon, 05 Nov 2007 20:10:04 +0100
Message-ID: <20071105191004.GH6205@artemis.corp>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <20071105190411.GG6205@artemis.corp> <20071105190556.GG22767@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="wj9ZLJVQDRFjGSdK";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: gitster@pobox.com, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 20:10:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip7L5-0000DW-0Q
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 20:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbXKETKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 14:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbXKETKH
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 14:10:07 -0500
Received: from pan.madism.org ([88.191.52.104]:38074 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690AbXKETKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 14:10:05 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A06FE2894C;
	Mon,  5 Nov 2007 20:10:04 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 51EAE20E809; Mon,  5 Nov 2007 20:10:04 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071105190556.GG22767@fieldses.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63537>


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 07:05:56PM +0000, J. Bruce Fields wrote:
> On Mon, Nov 05, 2007 at 08:04:11PM +0100, Pierre Habouzit wrote:
> > On Mon, Nov 05, 2007 at 07:01:41PM +0000, Pierre Habouzit wrote:
> > > +		if (!lstat(name, &st)) {
> > > +			die("Cannot find commit '%s', did you meant: "
>=20
> s/meant/mean/

Yeah I wrote that out of the iritation of the 192812948th question about
that on #git, I should have read my patch it seems :)

Though, if there will be a new maint release, I do believe that this
patch is maint material.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHL2qMvGr7W6HudhwRAnqIAKCAuvCNZgptLeEAjaM5RLx2dvn5ygCeP0q/
tYp6ub0HUdpyBkwuWyruYQU=
=O07a
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--
