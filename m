From: Martin Uecker <muecker@gmx.de>
Subject: Re: [PATCH] multi item packed files
Date: Fri, 22 Apr 2005 20:12:28 +0200
Message-ID: <20050422181228.GA4656@macavity>
References: <200504211113.13630.mason@suse.com> <Pine.LNX.4.58.0504210832490.2344@ppc970.osdl.org> <m3u0m0q69a.fsf@defiant.localdomain> <Pine.LNX.4.58.0504211301240.2344@ppc970.osdl.org> <m3vf6frvxu.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
X-From: git-owner@vger.kernel.org Fri Apr 22 20:10:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP2ao-00039b-Fo
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 20:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVDVSOB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 14:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVDVSOB
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 14:14:01 -0400
Received: from dialin-145-254-147-111.arcor-ip.net ([145.254.147.111]:2688
	"EHLO macavity") by vger.kernel.org with ESMTP id S261381AbVDVSN4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 14:13:56 -0400
Received: from martin by macavity with local (Exim 4.34)
	id 1DP2dg-0001Fn-M2
	for git@vger.kernel.org; Fri, 22 Apr 2005 20:12:28 +0200
To: git@vger.kernel.org
Mail-Followup-To: Martin Uecker <muecker@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m3vf6frvxu.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2005 at 11:40:29AM +0200, Krzysztof Halasa wrote:

=20
> > This is why I absolutely do not believe in arguments like "if your
> > filesystem doesn't do tail packing, you shouldn't use it" or "if your
> > don't have name hashing enabled in your filesystem it's broken".
>=20
> Of course. But one may consider using a filesystem with, say, different
> settings. Or a special filesystem for this task, such as CNFS used by
> news servers (it seems news servers do quite the same what git does,
> except they also purge old contents, i.e., container files don't grow up).

and nttp would give a nice transfer method for git objects...

Martin

--=20
One night, when little Giana from Milano was fast asleep,
she had a strange dream.


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCaT6MYDJInvULMKYRAiUlAJ0RM+JHlVx1pkesGgBUz4KhLTCQEQCeO0v8
5IEX094eywQWdgsj7MTiI7Q=
=TO0I
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
