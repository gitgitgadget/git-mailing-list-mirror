From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: Even more support for PATH_INFO based URLs
Date: Wed, 20 Sep 2006 23:04:11 +0200
Message-ID: <20060920210411.GF31940@admingilde.org>
References: <200609200049.52036.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Cc: git@vger.kernel.org, Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Sep 20 23:04:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9Eu-0001mN-JK
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWITVEO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWITVEN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:04:13 -0400
Received: from agent.admingilde.org ([213.95.21.5]:8417 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932080AbWITVEM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 17:04:12 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GQ9Ep-0003kN-H0; Wed, 20 Sep 2006 23:04:11 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200609200049.52036.jnareb@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27400>


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Sep 20, 2006 at 12:49:51AM +0200, Jakub Narebski wrote:
> Now the following types of path based URLs are supported:
>=20
> * project              overview (summary) page of project
> * project/branch       shortlog of branch
> * project/branch:file  file in branch, blob_plain view
> * project/branch:dir/  directory listing of dir in branch, tree view
>=20
> The following shortcuts works (see explanation below):
>=20
> * project/branch:      directory listing of branch, main tree view
> * project/:file        file in HEAD (raw)
> * project/:dir/        directory listing of dir in HEAD
> * project/:            directory listing of project's HEAD

very nice! thanks a lot!

--=20
Martin Waitz

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFEazLj/Eaxd/oD7IRAnRiAJ4o1SvVI3uUF8HDnYwLTuyrpgS4AQCdGvGD
WG0lo4Jr5uepZ5hPHr+bWEs=
=P4Xk
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
