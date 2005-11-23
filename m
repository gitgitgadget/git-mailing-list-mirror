From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Wed, 23 Nov 2005 08:27:40 +0100
Message-ID: <20051123072738.GI20960@kiste.smurf.noris.de>
References: <20051117230723.GD26122@nowhere.earth> <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de> <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth> <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de> <20051119170929.GF3393@nowhere.earth> <pan.2005.11.19.17.23.17.920228@smurf.noris.de> <Pine.LNX.4.63.0511200217200.11653@wbgn013.biozentrum.uni-wuerzburg.de> <20051120073244.GA7902@kiste.smurf.noris.de> <17283.57854.256145.253465@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FLPM4o+7JoHGki3m"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 08:31:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eep4V-0002Bn-C2
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 08:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbVKWH3g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 02:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbVKWH3g
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 02:29:36 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:37805 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S1030345AbVKWH3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 02:29:35 -0500
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1Eep2b-0006Mh-5c; Wed, 23 Nov 2005 08:28:42 +0100
Received: (nullmailer pid 6546 invoked by uid 501);
	Wed, 23 Nov 2005 07:27:40 -0000
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17283.57854.256145.253465@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12609>


--FLPM4o+7JoHGki3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Paul Mackerras:
> However, I was unable to get current gitk to exhibit the problem, even
> with Thomas Gleixner's enormous history.git repository.  Do you have a
> specific example (repository and commit ID) where you see the problem
> occur?
>=20
I've seen it in the past ... hmmm ... testing ... and it seems to
majickally have fixed itself.

Oh well...

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
The Tenth Commandment of Frisbee: The single most difficult move with a disc
is to put it down. (Just one more.)
					-- Dan Roddick

--FLPM4o+7JoHGki3m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDhBnq8+hUANcKr/kRAkmGAJ9DMTaTjbeG1OHCojou4UJu4P+trgCggyyl
6j4ZrcZY6o9vC71gTdnGyL0=
=OH3b
-----END PGP SIGNATURE-----

--FLPM4o+7JoHGki3m--
