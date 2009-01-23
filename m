From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 17:55:49 +0100
Message-ID: <20090123165549.GI21473@genesis.frugalware.org>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com> <7vwscm4xx0.fsf@gitster.siamese.dyndns.org> <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com> <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de> <bd6139dc0901221847u6b8aeadcl580a091751de3d26@mail.gmail.com> <alpine.DEB.1.00.0901230419080.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sh7h4lnU5nPTsIof"
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 17:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQPLI-0001Kn-IX
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 17:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654AbZAWQzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 11:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284AbZAWQzw
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 11:55:52 -0500
Received: from virgo.iok.hu ([212.40.97.103]:34030 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbZAWQzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 11:55:51 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A171458097;
	Fri, 23 Jan 2009 17:55:51 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D1D044465E;
	Fri, 23 Jan 2009 17:55:49 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BAE3A11B87A9; Fri, 23 Jan 2009 17:55:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901230419080.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106887>


--Sh7h4lnU5nPTsIof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2009 at 04:20:34AM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> But then, scripts have no business cloning repositories (fetching, yes. =
=20
> But cloning?)

I think portals like repo.or.cz may do it.

Isn't setting errno (or similar variable) in the HTTP code an option?
Then we could see why the transport failed and make a difference between
"network error" and "no refs found".

--Sh7h4lnU5nPTsIof
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl59pUACgkQe81tAgORUJaazACcCCCdvJZKa6BZTYMboPorw4Ca
P/4An1dSDOyV1lTpCDi1OsuLCFXGt08x
=XHyz
-----END PGP SIGNATURE-----

--Sh7h4lnU5nPTsIof--
