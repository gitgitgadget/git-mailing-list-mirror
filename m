Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA55A1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeBIUUx (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:20:53 -0500
Received: from kitenet.net ([66.228.36.95]:44810 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbeBIUUx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:20:53 -0500
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1518207644; bh=s9UMgLu/VPU+Nhz/j3Ku2KckCe7Gzsqg1N0P0U02uto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LoR6TPEiBTb7FByMOMGtUdXovNe/FeBH9RSnMD3ExH2xJXlIO3cdtcGVhK7Abrrmg
         /ldP7ApsK6l/elfFK0f8drVdjWB0JakAca9zEW9IlK7p75WOCrksaAAlbv6gn8l8dF
         +aAC8PE67SiHJGAyD2tFjCXdr9MZ5nntpa2Q2l00=
Date:   Fri, 9 Feb 2018 16:20:44 -0400
From:   Joey Hess <id@joeyh.name>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Fetch-hooks
Message-ID: <20180209202044.GA6783@kitenet.net>
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <3a5a2827-0f69-3a11-2664-51a60eefebf1@gaspard.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <3a5a2827-0f69-3a11-2664-51a60eefebf1@gaspard.io>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Leo Gaspard wrote:
> I just wanted to check, you did not put the Signed-off-by line in
> patches in https://marc.info/?l=3Dgit&m=3D132491485901482&w=3D2
>=20
> Could you confirm that the patches you sent are =E2=80=9Ccovered under an
> appropriate open source license and I have the right under that license
> to submit that work with modifications, whether created in whole or in
> part by me, under the same open source license (unless I am permitted to
> submit under a different license), as indicated in the file=E2=80=9D, so =
that I
> could send the patch I wrote based on yours with a Signed-off-by line of
> my own without breaking the DCO?

Yes; my patches are under the same GPL-2 as the rest of git.

--=20
see shy jo

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAlp+ApkACgkQ2xLbD/Bf
jzgKhg//cWPhtSUOaLCeTUeX4YqWcZQSdW5UJZaA3Y/BKJwoP+Dk+EGwjrq5jQJh
ce4uWK837d6jcS4MiA3Amh+POIo0v9GKPAfcWW05/igVhwy3TRvwpopPbon7x+vb
hCUAZDrTu56/g98bTJWlMqwHZxV9GNwH5tc9c5lAfxzcUCOc+aG7poDJxi5qIPvh
Fh2hYl+PkwOaPmbGQuMwj4y5CLYMwXvvMv8JsZXO+jZ5J2NOEZT6FTJLqITbUgLD
t2siZxtkDWEqkFvcWjwyixlvgCHCyA1AgHO82ZkhMsRIMcrCyHCBi5YmiH6YJVlJ
yLNfbq4WnHJ8Oa/Z1MbkbZ8O4qpONJSdHml5w7fql8YmyNHj50vfhq+g1E/gDmWc
7VVB01j2i1DUI8E1yeNMPsfxqzj0i0z8c8tsogmO6xoZWeJNc25Rm2v4bvEf4mBB
T/3tIY1CoxJ3dZlk6lZRZN0Yebnc5xWHyefhMvvxAVQcFkR2SzAg12aHPFFov0/9
b/xy2cimOfjbLMNzwM2PccPMplS53/0YYXm79bOPgAa309Zd3TSUS/oVyhp91s7S
4U2Q9gIkViCsSwM0rIRccJK+NjFaZyrNM6kCfUeeTSNpXrlWM6Kbm5brX0qV9vWr
zSIuRZnSSen4Q3dvg0h2LXrHIXc2Cf5LZ2cs/rDC3zM/IXDyUi0=
=CgjN
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
