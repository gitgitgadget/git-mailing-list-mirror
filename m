From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: use out-of-line GIT logo.
Date: Mon, 31 Jul 2006 09:02:37 +0200
Message-ID: <20060731070237.GC16364@admingilde.org>
References: <20060730223839.GB16364@admingilde.org> <20060731035904.53458.qmail@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 09:02:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7RnV-0006hy-Mz
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 09:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWGaHCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 03:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWGaHCj
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 03:02:39 -0400
Received: from admingilde.org ([213.95.32.146]:46303 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932484AbWGaHCi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 03:02:38 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G7RnR-0001KR-KE; Mon, 31 Jul 2006 09:02:37 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060731035904.53458.qmail@web31813.mail.mud.yahoo.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24496>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Jul 30, 2006 at 08:59:04PM -0700, Luben Tuikov wrote:
> --- Martin Waitz <tali@admingilde.org> wrote:
>=20
> > Use the normal web server instead of the CGI to provide the git logo,
> > just like the gitweb.css.
>=20
> NACK.  I'd really rather keep the logo (which is essential) in the
> file itself.  This would mean one less file to worry about.

we could default to use git-logo.png from kernel.org if you care about
easy home installations.

For each serious gitweb site it should not be a problem to put the logo
into their image folder.

And I really think that the .css is much more essential then the logo
;-).  So perhaps use kernel.org for the .css by default, too?

--=20
Martin Waitz

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEzasNj/Eaxd/oD7IRAiMkAJoCsEvyeWSPtmblSxm/jb/76IcLkQCdGThy
Erpa4YuxU4gW2+yCtN8Zm8s=
=5bWv
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
