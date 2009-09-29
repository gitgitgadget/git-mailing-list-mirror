From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-diff/git-diff-files: Turn off copy-detection?
Date: Tue, 29 Sep 2009 17:05:26 +0200
Message-ID: <20090929150526.GM32702@genesis.frugalware.org>
References: <4AC20286.6020108@gmail.com>
 <4AC20E37.3090204@viscovery.net>
 <4AC218BB.4080807@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KasUm1oH6X2AfSvU"
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 17:05:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MseGk-0007uQ-HU
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 17:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbZI2PFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 11:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbZI2PFY
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 11:05:24 -0400
Received: from virgo.iok.hu ([212.40.97.103]:42194 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbZI2PFY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 11:05:24 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2BFB45808B;
	Tue, 29 Sep 2009 17:05:27 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id F04C74490F;
	Tue, 29 Sep 2009 17:05:26 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DCA4311F0028; Tue, 29 Sep 2009 17:05:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4AC218BB.4080807@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129308>


--KasUm1oH6X2AfSvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2009 at 04:24:59PM +0200, Marius Storm-Olsen <marius@storm-=
olsen.com> wrote:
> $ git config diff.renames
> copies
>=20
> That's it, thanks! Strange that nothing in the git-diff documentation=20
> pointed me in this direction? Obviously I didn't connect the dots=20
> between 'copy' and 'renames' either..

See man git-config. :)

--KasUm1oH6X2AfSvU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrCIjYACgkQe81tAgORUJY4uQCcCcbSnIj7Z8sdHEuMlpdWii0A
oCMAn0oQbQ0qKm4PwM45QD5MbW4OF1bm
=wB2S
-----END PGP SIGNATURE-----

--KasUm1oH6X2AfSvU--
