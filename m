From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Not so happy about build system
Date: Wed, 23 Jul 2008 12:33:12 +0200
Message-ID: <20080723103312.GE32057@genesis.frugalware.org>
References: <alpine.LNX.1.10.0807222036230.23410@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XUd+PsnCfaVdInSg"
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 12:34:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLbfj-0006yS-12
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 12:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbYGWKdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 06:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbYGWKdO
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 06:33:14 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60700 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbYGWKdN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 06:33:13 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 902491B24EF;
	Wed, 23 Jul 2008 12:33:12 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B96E54465E;
	Wed, 23 Jul 2008 11:51:58 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3C36C11901B3; Wed, 23 Jul 2008 12:33:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0807222036230.23410@fbirervta.pbzchgretzou.qr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89625>


--XUd+PsnCfaVdInSg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 11:33:56AM +0200, Jan Engelhardt <jengelh@medozas.d=
e> wrote:
> 	./configure --prefix=3D$HOME/rt --with-openssl=3D/opt/csw=20
> 	--with-curl=3D/opt/csw CFLAGS=3D"-O2 -I/opt/csw/include -L/opt/csw/lib=
=20
> 	-R/opt/csw/lib"

Why do you put -L/opt/csw/lib to CFLAGS instead of LDFLAGS?

--XUd+PsnCfaVdInSg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiHCOgACgkQe81tAgORUJahNQCeLROHjMmjmAVKosVCh7UVkcCf
y9UAnAq+PevFThDvv1ORTofHJw5qjR25
=vZgk
-----END PGP SIGNATURE-----

--XUd+PsnCfaVdInSg--
