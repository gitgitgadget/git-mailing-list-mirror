From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG] cherry-pick ignores some arguments
Date: Fri, 15 Jun 2012 16:39:18 +0200
Message-ID: <1339771158.4625.59.camel@beez.lab.cmartin.tk>
References: <20120614114415.39cbb64c@chalon.bertin.fr>
	 <1339691389.4625.9.camel@beez.lab.cmartin.tk>
	 <20120615091425.20e40af9@chalon.bertin.fr>
	 <1339765943.4625.57.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-BUvc2lTdtiPmZgJBGis0"
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Fri Jun 15 16:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfXgq-0008Ao-Ir
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 16:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756978Ab2FOOjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 10:39:21 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:45592 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab2FOOjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 10:39:20 -0400
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id A47DC46057;
	Fri, 15 Jun 2012 16:39:13 +0200 (CEST)
In-Reply-To: <1339765943.4625.57.camel@beez.lab.cmartin.tk>
X-Mailer: Evolution 3.2.2-1+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200056>


--=-BUvc2lTdtiPmZgJBGis0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-06-15 at 15:12 +0200, Carlos Mart=C3=ADn Nieto wrote:
> The typical cherry-pick usage is for a few select commits out of a
> different branch. The manpage itself only started explaining the ranges
> in 2010 and they may be more of a side-effect than a conscious design
> decision. But that's neither here nor there.

Disregard this part. I just found the patches. For some reason I thought
that the capability was there much earlier.

   cmn


--=-BUvc2lTdtiPmZgJBGis0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJP20kWAAoJEHKRP1jG7ZzTaNAH/j95wz7wBMffV7W+5BcC9oKj
6DMuUVjkh/itIOiKlWosPJnD3betnmxbgxnKN5KCVxEOnNIDL8qQLQ+IO6/rs2EP
E64RwhLJe5QqXB2tYugCORd7tlrUAnE1L0oV5uyiRWDDAx/h9H0SiiOEib9hxdJK
mvuYSahlDfBUO7ccenc0trNZ9t24W/yFvAhtrMWBx7Il8+WvMoUiAjaDOXhxtC0h
p7taOJjak/gENtqSoPNpRlADAi7xaBx4ctD+hN1CSCYO96MqRA7HgGKLdoXoEtdF
0drR4cXnPwo34dYVEHWfw68ed5Cnm4a03v2DIWt++6EK6vbK8jbf2yu3xeIhGpk=
=X/qM
-----END PGP SIGNATURE-----

--=-BUvc2lTdtiPmZgJBGis0--
