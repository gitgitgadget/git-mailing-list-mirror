From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs and unnamed branches
Date: Sat, 17 Jun 2006 10:13:16 -0700
Message-ID: <1150564396.6983.73.camel@neko.keithp.com>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
	 <1150496362.6983.34.camel@neko.keithp.com>
	 <9e4733910606162002x508ec6ccjbc36e4220ca44fd6@mail.gmail.com>
	 <1150513943.29738.15.camel@dv>
	 <9e4733910606162031o69df27fdje50c88949ed990b5@mail.gmail.com>
	 <1150517336.9144.8.camel@dv>
	 <9e4733910606162115g2165212bgf32a2e328cce751a@mail.gmail.com>
	 <1150522246.6983.52.camel@neko.keithp.com>
	 <9e4733910606162251i65021336m4388d4da715befc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RfDrkfPB5MwM2nnYzNDc"
Cc: keithp@keithp.com, Pavel Roskin <proski@gnu.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 19:13:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FreMh-0006h2-EX
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 19:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWFQRNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 13:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWFQRNk
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 13:13:40 -0400
Received: from home.keithp.com ([63.227.221.253]:18190 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750727AbWFQRNk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 13:13:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 16D91130021;
	Sat, 17 Jun 2006 10:13:39 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 16348-01; Sat, 17 Jun 2006 10:13:38 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 57B1713001F; Sat, 17 Jun 2006 10:13:37 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 12CED14001;
	Sat, 17 Jun 2006 10:13:37 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id A64A3542B2; Sat, 17 Jun 2006 10:13:16 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606162251i65021336m4388d4da715befc9@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22023>


--=-RfDrkfPB5MwM2nnYzNDc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-06-17 at 01:51 -0400, Jon Smirl wrote:

> Have you checked parsecvs on the 38 test repositories in the cvs2svn sour=
ce?

Those all run to completion without significant error (there are a
couple of tests with invalid symbol names that currently elicit errors).

I haven't validated that the imports are correct though; spot checks
seem to indicate that the problems encountered during the cvs2svn
development aren't the same as the problems we're finding.

--=20
keith.packard@intel.com

--=-RfDrkfPB5MwM2nnYzNDc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBElDgsQp8BWwlsTdMRAud3AKCxoKDqCTrU+sS6YhZNJZAf2j84JgCghkM9
rO2uozL6AJFXRcdCHRayGrI=
=SBVF
-----END PGP SIGNATURE-----

--=-RfDrkfPB5MwM2nnYzNDc--
