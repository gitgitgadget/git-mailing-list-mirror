Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09AA1F51C
	for <e@80x24.org>; Tue, 22 May 2018 22:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753033AbeEVWmW (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 18:42:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52382 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752779AbeEVWmW (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 22 May 2018 18:42:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:fc4d:8d90:22bd:91d8])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C11C360444;
        Tue, 22 May 2018 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1527028941;
        bh=6+/ojN8F7L/v+GjvLakh2jQ1wuE2kQ2DggwUE9oa/Rg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vKKMFiTMupZotL6BQ8LgeXeOeJh6j5FFl9irOyaiCqkcmfHQzonQEeihH8Z0e3YZG
         YLBoi4lRB5UWPRz2Q7FVltzG9HPeyJdoJeYcI3Q625NKBNUI3ygwRwf/xZs5PZC1bS
         wABOui6Cv9U0nW2CMdf/pQzMsBvnXseaq6N2vURBG6Nf0GedC951iQj8p//3tJKjO1
         3EdEkE/wCJYy+UjOO4pPfD+vH5DF1DGU7C4wpwUJj43+/qpI+asYhUIeUQUgfw2SoO
         tSuhW8ajL9XAlTbzpqwfunrlgoAvzXoNQ3xFVRFEeuLRoKYiVgRX2hdKJp+X3Fub1g
         LscH7di3GwIHHH/z3lN2LfulU5ToNom25JSwGLh6nlITmZX26PWgDZTFLZ+nsee2Rz
         6F9+76DPaO2AbyX5b9YDaHjzCijYnDf6tVzJ1U0TyyvH9btLrYyZSRd2RrdcoV7hgD
         FB4a0YvqcpV22dwfNYGYxpeDA1saI1JHvFIbeGpBdGRP2yVVfwT
Date:   Tue, 22 May 2018 22:42:15 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] mailmap: update brian m. carlson's email address
Message-ID: <20180522224215.GI652292@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
 <20180522220826.GP10623@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4Djgzn3z2HSNnx0"
Content-Disposition: inline
In-Reply-To: <20180522220826.GP10623@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--T4Djgzn3z2HSNnx0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 03:08:26PM -0700, Jonathan Nieder wrote:
> These commits use author Brian M. Carlson <sandals@crustytoothpaste.net>.
> Previously they matched
>=20
> 	brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothp=
aste.net>
>=20
> but now they don't match any line in the .mailmap file.
>=20
> Should we add a line
>=20
> 	brian m. carlson <sandals@crustytoothpaste.net>
>=20
> to handle these commits?

Ah, good point.  Probably so.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--T4Djgzn3z2HSNnx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsEnMcACgkQv1NdgR9S
9osighAArKBREBRDGcr6xUV6Y2pI1vvEzB9oQEOaigdrAyCagRYApE3QqnWALJmP
DPYzPP1iPJQepSH6mH6YZkhVF36od836v3E5d778trS3k9Zq4tLYY1H2vPbldvf5
ggqPKNcpnFS3JbphA7NRgx8nJ0Dio8fbmDeRKqqqE4VpibONGF8tOiu92W+SDT9r
9DPlEaCcvp1oOidgGs3DpywBiG8FQzr+fuGIpGiDWfgezqcnD8YzMR1Gg3rzJzRv
b3ewlZzJbyrF8p/THQ59z5MPkrf4XL+97AbYIMMq1fd0Pp52ih40k0fYvnHh/MeK
2Z4z0Szkze1TKDQ983MBiKQKvDV2laCz69XQqKVyfxX5KWOUX0AyXVIHY3yNk1yk
HRe7SJi2kebopEM/N20VSx5f3IYu0QH2nlZPdxwYPaTq2vlBSJ3pbX7etKDlTOLj
+zL5dRftYBRAHezOrbPEmgw46KUoxHdf6AvIt9hWYxrkwpVvY6yIFVglXT+HfO3X
Mfy8rAE0TGpkcloJxIU4OjFOXgCrJ1N+BQ7A1j3VTdyIXFNd8c6C9BNsbrMVnkOz
P1FloBwm8lz9R7L7BHJKwjqXMzXxEIQywqvPLlq0vD5s/QQcXVq5A7LjGUdldKiu
takC1UxUrbhZ8YpmLuEvw+7j2FCVdW58MxkdgS9d9fv14fBM5lc=
=/mtx
-----END PGP SIGNATURE-----

--T4Djgzn3z2HSNnx0--
