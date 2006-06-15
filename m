From: Keith Packard <keithp@keithp.com>
Subject: Re: observations on parsecvs testing
Date: Thu, 15 Jun 2006 15:04:28 -0700
Message-ID: <1150409068.30681.134.camel@neko.keithp.com>
References: <Pine.LNX.4.64.0606151529350.16002@localhost.localdomain>
	 <20060615164742.570e33a0.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-N4HECh9qANQZyJEV5dvH"
Cc: keithp@keithp.com, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 00:04:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqzxP-00048a-1D
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 00:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWFOWEw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 18:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWFOWEw
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 18:04:52 -0400
Received: from home.keithp.com ([63.227.221.253]:60430 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750704AbWFOWEw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 18:04:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 5215513001F;
	Thu, 15 Jun 2006 15:04:51 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30295-06-3; Thu, 15 Jun 2006 15:04:51 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 162E513001E; Thu, 15 Jun 2006 15:04:51 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id DCD1514001;
	Thu, 15 Jun 2006 15:04:50 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 88FA554337; Thu, 15 Jun 2006 15:04:30 -0700 (PDT)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <20060615164742.570e33a0.seanlkml@sympatico.ca>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21917>


--=-N4HECh9qANQZyJEV5dvH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-06-15 at 16:47 -0400, Sean wrote:
> las,
>=20
> That was a planned optimization which I did mention to Keith previously.
> Was kinda waiting to hear back how it was working for him, and if there
> was an interest to put more work into it to include in his mainline.

The rcs2git code is working great and is on 'master' at this point;
optimizations to generate all of the revisions in one pass would be
greatly appreciated.

--=20
keith.packard@intel.com

--=-N4HECh9qANQZyJEV5dvH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEkdlsQp8BWwlsTdMRAqlqAJ4h8r5UeYuMFzCPArq0WIBFA2+HXgCeKf/L
gTrrL7MFFs2zjIOUXB6emWk=
=SYg9
-----END PGP SIGNATURE-----

--=-N4HECh9qANQZyJEV5dvH--
