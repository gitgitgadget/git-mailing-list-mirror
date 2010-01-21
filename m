From: Joey Hess <joey@kitenet.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 23:05:34 -0500
Message-ID: <20100121040533.GA13597@gnu.kitenet.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <201001210305.05309.johan@herland.net>
 <alpine.DEB.1.00.1001210457380.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 05:05:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXoIi-0000Z4-MF
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 05:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab0AUEFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 23:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582Ab0AUEFk
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 23:05:40 -0500
Received: from wren.kitenet.net ([80.68.85.49]:55704 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523Ab0AUEFj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 23:05:39 -0500
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id BAB9711827D
	for <git@vger.kernel.org>; Wed, 20 Jan 2010 23:05:35 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 5D457A8478; Wed, 20 Jan 2010 23:05:34 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1001210457380.4985@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137626>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> I do not really care as long as there is a nice way to edit the complete=
=20
> note interactively.
>=20
> Of course, I _do_ expect people to get confused just like they do with th=
e=20
> current inconsistencies: "git commit -m" does not really append, but set=
=20
> the commit message, even if you amend a commit.
>=20
> So maybe you want to use a different command line option for that.

Maybe: git notes add [-m|-F]

--=20
see shy jo

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBS1fSiskQ2SIlEuPHAQiilw/7BIZhIrirlFFRBpCAQPOogeI846ocmpbK
FpYR0InHPRD0sQ4f0SOCgDZ5OstdUxDFe6EQmsR++nZCqekqsk4kJ7bp/p0CEBgQ
eU0UclPvjwG7NLLtSH6CV0NcJI03pn26aGwwv3+3Zdg8HMC1YLYQvkLxAqyF4j9J
SsvWtyMarmgb22Cy3tgzvduVY6jABAFbDP7xX99B4GKV98QxBY8BQrmmyRDUrmfM
3+T3E3wC6qJb4O09wNuLZlmQmgVmo+DfBNLFmdFuzfh5yWEbYs9tGAcuzBJJyVpa
2MyDs/P//aAfXkxQPfR06ZRTGgkpc4FXtbFVxjHFDU6RSZj9B+GHc0aaZu8FxRyc
BQ4t2UB/aj63Zxeh6bM0WQZ0bF8xkFPqaZMv/cfSH5RizdUBCyOeoL2dCYz3Nr3i
N5dbrphbrMMFlh5ueUxSiosPDBPsWe4mTiFMrA1m/oH/FZNh3xRfIrEbYn33iTqb
Pn69tqcicKbAhpidWnqhVU4SDkSWQ+9G4dMohukRzvpni3++8osqx08BI9hmEoLZ
S9BagnokIQUkTk5S7DPqPVclUjkd1znUwlEx+JAO7SVzVqhYxZIcVXmP0Ao0TxZh
s0ClEJISLYxqMDmd3vvGH4m4ZUQsuFTLfoiepsBKkJIx1Xp0T/moAjNmf0SdXaOC
LgMoKyTVHhw=
=/Jhc
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
