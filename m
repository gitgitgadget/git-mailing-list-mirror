From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/2] Use parse-options in builtin-clean
Date: Sun, 04 Nov 2007 22:16:37 +0100
Message-ID: <20071104211637.GB4207@artemis.corp>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com> <11942029442710-git-send-email-shawn.bohrer@gmail.com> <11942029474058-git-send-email-shawn.bohrer@gmail.com> <20071104194129.GA4207@artemis.corp> <Pine.LNX.4.64.0711042023440.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="LyciRD1jyfeSSjG0";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 04 22:17:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iomq8-0002nq-1a
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 22:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbXKDVQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 16:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXKDVQk
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 16:16:40 -0500
Received: from pan.madism.org ([88.191.52.104]:37054 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbXKDVQj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 16:16:39 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 59A7A28471;
	Sun,  4 Nov 2007 22:16:37 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6B98A3F6A1; Sun,  4 Nov 2007 22:16:37 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711042023440.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63442>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2007 at 08:24:31PM +0000, Johannes Schindelin wrote:
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>=20
> 	On Sun, 4 Nov 2007, Pierre Habouzit wrote:
>=20
> 	> On Sun, Nov 04, 2007 at 07:02:21PM +0000, Shawn Bohrer wrote:
> 	>=20
> 	> > +	for (i =3D 1; i < argc; i++) {
> 	> > +		const char *arg =3D argv[i];
> 	> > [...]
> 	>=20
> 	>   Please, parse-options.c is now in next, please use it.
>=20
> 	Something like this?

  something like this works for me :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHLja1vGr7W6HudhwRAuN1AJ9UoAgmklcTN7RJ8lkiM0tpuoyCXACfUgIi
k15D7CY16MP5AJsioxHQ3IU=
=qKU6
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
