From: Nico -telmich- Schottelius <nico-git-20080415@schottelius.org>
Subject: Re: [new tool] git-project-version.sh
Date: Tue, 15 Apr 2008 14:02:12 +0200
Message-ID: <20080415120212.GB17459@denkbrett.schottelius.org>
References: <20080415113629.GA17459@denkbrett.schottelius.org> <20080415115529.GA3595@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Cc: Nico -telmich- Schottelius <nico-git-20080415@schottelius.org>,
	git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 15 14:01:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jljqg-0004FR-3d
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 14:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764777AbYDOMAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 08:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758696AbYDOMAc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 08:00:32 -0400
Received: from [62.65.138.77] ([62.65.138.77]:38646 "EHLO mx2.schottelius.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1764774AbYDOMAa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 08:00:30 -0400
Received: from denkbrett.schottelius.org (natgw.netstream.ch [62.65.128.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.schottelius.org (Postfix) with ESMTPSA id CCAE534D205;
	Tue, 15 Apr 2008 14:00:25 +0200 (CEST)
Received: by denkbrett.schottelius.org (Postfix, from userid 1000)
	id BC4871D0F1; Tue, 15 Apr 2008 14:02:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080415115529.GA3595@atjola.homenet>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.24.3-denkbrett on x86_64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79592>


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Bj=F6rn Steinbrink [Tue, Apr 15, 2008 at 01:55:29PM +0200]:
> > [...git-project-version.sh...]
> >=20
>=20
> Hm, except for the three trailing dots that you get with
> --abbrev-commit, you can get the same results with rev-parse
>=20
> $ git rev-parse  HEAD
> 8a18e8fe4e0e64222de6b063a976d0fe24955ddb
>=20
> $ git rev-parse --short HEAD
> 8a18e8f

Should have known that before... thank you for the hint!

So just forget my previous post :-)

Nico

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIBJlEuL75KpiFGIwRAvpdAKCemm09KNGHSNQuaCsFYupy1UplawCfRNz6
pEVMk00C2ep4f45yGC6AFM4=
=0hB+
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
