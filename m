Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CD7C32771
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 08:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AD320673
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 08:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgAIIQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:16:46 -0500
Received: from smtp.bonedaddy.net ([45.33.94.42]:50682 "EHLO
        smtp.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgAIIQq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 03:16:46 -0500
Received: from chianamo (n175-38-4-223.per2.wa.optusnet.com.au [175.38.4.223])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pabs3@bonedaddy.net)
        by smtp.bonedaddy.net (Postfix) with ESMTPSA id D819E180045
        for <git@vger.kernel.org>; Thu,  9 Jan 2020 03:16:46 -0500 (EST)
Message-ID: <18c315dff007dd69050388ae4665c4de50bb394e.camel@bonedaddy.net>
Subject: Re: interoperability between git and other VCS and data
 storage/transfer tools?
From:   Paul Wise <pabs3@bonedaddy.net>
To:     git@vger.kernel.org
In-Reply-To: <20200109075748.GB3978837@coredump.intra.peff.net>
References: <929fe6f7f41a2abca353df4fd7f602a3e22ceb5f.camel@bonedaddy.net>
         <20200109075748.GB3978837@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Rxtrw29yarBsyFuY1XoP"
Date:   Thu, 09 Jan 2020 16:16:41 +0800
MIME-Version: 1.0
User-Agent: Evolution 3.34.1-2+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-Rxtrw29yarBsyFuY1XoP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-01-09 at 02:57 -0500, Jeff King wrote:

> https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#In=
teraction_with_other_Revision_Control_Systems
> I have no idea how up-to-date it is

It seems to miss a number of tools, I've requested an account and will
update it with the tools I know about. Thanks for all the pointers.

--=20
bye,
pabs

https://bonedaddy.net/pabs3/

--=-Rxtrw29yarBsyFuY1XoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAl4W4WYACgkQMRa6Xp/6
aaOC+BAAhUPDS0B4BVP8TxQwKFyfXq1Xh2XT5E6+DHY04Ay0rzip19v7m2Awey1A
0VEm/k/DNSTdcuUQFGp5Bfvu/v9/MLyOkYkLbMh6GPCSRXWMAoljCoiY0K64R5Io
OLZSPrCIXkyR8QZJ1P/Qu5FJaonlQMKuizZLjQ3UgzM/xXG1QCCaq1mA6YaxEGLZ
bfVixrgLQCPw77XQ2ja1jCrCdvpmr+Hup+wSsIs1pHE1HerS0mpf9wphjo7ukCQj
lLwVtqugrmpDwtex6y0XcCz1/Bw2VX0saVTElusVbhfWIiY9k32YILKeV5eTune3
MhKe2Rjqpn6tfa8nrnqo+guRyZOT2vXMO0gIfkU3gsGROOzWW0u4A2Z5HpqRzOam
69kA946WjXITGS1iwUzkIHPvwDeslBccABhHql9qJWK6BEZjOrNBPwblV2ToDmoJ
9oIysLUVB53yaH/Pqg/kOJ+ulXDbSRRn8le5MIs3zMqR/hkCrg7X6BfxNPlg5xXv
vsEmmjN+GvPOmCy6Sumxcn2E5QAmHPSMaWfxPJDVvevz4/E4arCpFnIwJAIS302G
aLMlWWIjhwnjU2yjxwz1Rzv3h3RflQm5esTTbIALRXs93Y8Ou3bFW2B5En3FURzV
Ps2D3zmb9CBsx9m3xl/xoI6Af+x+0I3JjJJU2iIee5OuaxzNKFc=
=C9nm
-----END PGP SIGNATURE-----

--=-Rxtrw29yarBsyFuY1XoP--

