From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: About the .gitmodules file
Date: Wed, 2 Jan 2008 18:13:17 +0100
Message-ID: <20080102171317.GE29972@genesis.frugalware.org>
References: <7bfdc29a0801020239w6f4133d3pc6f1aa325b1067db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Cc: git@vger.kernel.org
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 18:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA7A2-0004Yd-Ek
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 18:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbYABRNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 12:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbYABRNU
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 12:13:20 -0500
Received: from virgo.iok.hu ([193.202.89.103]:39813 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbYABRNT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 12:13:19 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 836261B2584;
	Wed,  2 Jan 2008 18:13:18 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D2DF94465D;
	Wed,  2 Jan 2008 18:11:45 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 232BE176C043; Wed,  2 Jan 2008 18:13:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7bfdc29a0801020239w6f4133d3pc6f1aa325b1067db@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69479>


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2008 at 04:39:24PM +0600, Imran M Yousuf <imyousuf@gmail.co=
m> wrote:
> "git-submodule add". An entry for a submodule in that file looks like:
>=20
>     [submodule "a"]
>             path =3D a
>             url =3D /home/imyousuf/projects/git-projs/smart-sip/submodule=
s/a/.git

that means:  the submodule is under /root_of_the_repo/a/ and the repo
should be cloned from $url (to a/) when one clones the parent repo and
runs git submodule init

- VMiklos

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHe8Yte81tAgORUJYRAlk3AKCagSs3n48Sr3WsLC8Zry0NsV3OvgCfaAF2
JadpWARPjWpkTKCpvesV5JM=
=smyb
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
