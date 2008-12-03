From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Is there a way to control the number of revisions will be
	saved by git
Date: Wed, 3 Dec 2008 14:40:37 +0100
Message-ID: <20081203134036.GR19355@genesis.frugalware.org>
References: <2f5ea7490812030301p29e944fw5f59943dc352cd09@mail.gmail.com> <49366C03.5080506@viscovery.net> <m3ljuxifer.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="THYEXwetZJOK3OLY"
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Tzury Bar Yochay <tzury.by@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:42:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rzP-0005SM-Dm
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbYLCNkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbYLCNkn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:40:43 -0500
Received: from virgo.iok.hu ([212.40.97.103]:52439 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbYLCNkm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:40:42 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0EB0A580D2;
	Wed,  3 Dec 2008 14:40:38 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 09BC84465E;
	Wed,  3 Dec 2008 14:40:38 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 64AFA11901A1; Wed,  3 Dec 2008 14:40:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3ljuxifer.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102259>


--THYEXwetZJOK3OLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2008 at 04:58:40AM -0800, Jakub Narebski <jnareb@gmail.com>=
 wrote:
> Or just use shallow clone
>=20
>   git clone --depth <depth> <repository>
>=20
> to have new copy (clone) of <repository> to have only <depth> commits
> back.  See man git-commit; but it might be not what you want.

You mean man git-clone?

This trick can be used only once, since you can't clone a shallow clone.

--THYEXwetZJOK3OLY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk2jFQACgkQe81tAgORUJbgIgCgqCwKtKDlQujK7gXznltnX9xk
ggwAn25MnNeOFivTRV2lLrpLkAZrieie
=BPtg
-----END PGP SIGNATURE-----

--THYEXwetZJOK3OLY--
