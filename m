From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: Host refs to push are chosen (documentation error)?
Date: Thu, 18 Feb 2010 10:19:55 +0300
Message-ID: <201002181019.58736.arvidjaar@mail.ru>
References: <201002171627.57599.arvidjaar@mail.ru> <32541b131002170939l261f396cpbee45f652fd96c77@mail.gmail.com> <20100218011620.GA15870@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1286014.L54DumCyqH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 08:20:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni0gK-00073j-Vm
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 08:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734Ab0BRHUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 02:20:09 -0500
Received: from mx76.mail.ru ([94.100.176.91]:54562 "EHLO mx76.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434Ab0BRHUI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 02:20:08 -0500
Received: from [91.77.254.125] (port=23098 helo=cooker.localnet)
	by mx76.mail.ru with asmtp 
	id 1Ni0gA-000OR2-00; Thu, 18 Feb 2010 10:20:07 +0300
User-Agent: KMail/1.13.0 (Linux/2.6.33-desktop-0.rc8.1mnb; KDE/4.4.0; x86_64; ; )
In-Reply-To: <20100218011620.GA15870@coredump.intra.peff.net>
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140300>

--nextPart1286014.L54DumCyqH
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Thursday 18 of February 2010 04:16:20 Jeff King wrote:
> On Wed, Feb 17, 2010 at 12:39:23PM -0500, Avery Pennarun wrote:
> > On Wed, Feb 17, 2010 at 8:39 AM, Tay Ray Chuan <rctay89@gmail.com>=20
wrote:
> > > On Wed, Feb 17, 2010 at 9:27 PM, Andrey Borzenkov=20
<arvidjaar@mail.ru> wrote:
> > >> {pts/1}% l .git/refs/heads
> > >> local-mdv  local-mdv.stgit
> > >=20
> > > have you tried
> > >=20
> > >  $ cat .git/packed-refs
> > >=20
> > > ?
> >=20
> > The documentation is still lying though :)
>=20
> Agreed. It's a minor point, but one that can mislead users who don't
> know about packed refs. Maybe something like this?
>=20

And I thought it was such a simple question :)

Thank you!

--nextPart1286014.L54DumCyqH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkt86hsACgkQR6LMutpd94xkBQCeNPhig4ABh3z42zjuUQ4tNUuu
4lIAn11NFiwmKPlbTx5VbFNOkI27sciO
=ui2c
-----END PGP SIGNATURE-----

--nextPart1286014.L54DumCyqH--
