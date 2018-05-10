Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11EBE1F406
	for <e@80x24.org>; Thu, 10 May 2018 23:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeEJXNO (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 19:13:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43890 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750798AbeEJXNN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 May 2018 19:13:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4A6FE6046C;
        Thu, 10 May 2018 23:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525993990;
        bh=ESgfpYSiK5t82rDg1Sr0ilnVYiCg2D5y6XciPSnJ3tc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=M612sTjCmvFRDQfVf614gjvwxIiu7pVMbK1EAWEOclciCLTkzmQcOShGDv+GaD/kw
         t+ig0YUW5GXU/nyOl3DvHJI7S4CgTBwAffICQ7FssgfjBIgwK0IP87HTpWpQTUKzg1
         c3Rp73lR/7Wfo2x6AP6WVb9x1w9L++6z7277AEwNtiwEoPqwAexArfd5ItzOXVhJ9i
         Div4wnZA9d9xrwTdyjqyx6V3zvXHhAyh0L5F1ocMm0KOJvCHDZ7dNWRUoWH+tKx3Nn
         A6lgtLjhZnVKYmOkApmaUkqV4W9fvxmg2+j5F4XCz/bHl62avS3q1apxjPnCG98eDV
         PrRaI8d3Fbz3JpXsNm23EuynrFJaXKf4eYW8+283Zs8g7/ha3gYGx0FGqU5lk2KaJV
         sDdrVz+iEaFIxHKnedww/d4SCddAg7Pb/rwHn2qcGVaVUs/slNgksZf1MaQ19Mf5L5
         5Ua9tNByoI9Dg5z4cdRWn4LmYZvxLF1xl+Zk2PrbqvIp8Zfoik6
Date:   Thu, 10 May 2018 23:13:04 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] mailmap: update brian m. carlson's email address
Message-ID: <20180510231304.GG275488@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
 <184451b4-1b34-c1f7-f9b1-0dfa63ab9506@gmail.com>
 <20180509001957.GE275488@genre.crustytoothpaste.net>
 <4587b2e7-6cc8-c8fe-0b2b-7ce4202197d1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Content-Disposition: inline
In-Reply-To: <4587b2e7-6cc8-c8fe-0b2b-7ce4202197d1@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 12:33:59PM +0530, Kaartic Sivaraam wrote:
> On Wednesday 09 May 2018 05:49 AM, brian m. carlson wrote:
> > Correct, it doesn't.  In my case, I was using --pretty=3D'%aN <%aE>',
> > which is how I noticed it in the first place.
>=20
> So, how about updating the commit message to avoid confusions to the
> incidental future reader? (Or is it just not worth it? ;-])

I don't think it's worth it.  It does apply to git log, just not unless
you enable the mailmap, which I supposed was implicit.  I can do a v3 if
someone feels strongly, but otherwise I think it's fine as it is.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlr00gAACgkQv1NdgR9S
9osSoxAAlGs9JoTmjn/1oH25LaHxTGx4V3BiRHivdyVoEvpAIAMsN4S770lpfxta
b6INr98CAUgiYuqOayB4kSjmwTOPWLv00bNvl6WHncZJaCYYbkKrfLNCm4LUGDaO
1jcx6mO/jqYo55ynEjK6cv5eYSteLT0SXotKAOfxMoQbgb6IlyFN9jWjbwqCmiCY
pwAtUljNkM7SJHb2ubeDTeGmSvB7JKBHKMhQxfnPe/B7KC8dvnt6yeODfQGVyGwL
LK7RFPPGPsVxqFLfzq+wBoZnhG7i3pjeDn4im9xkpOAOfRBeGUVgFjsitVvA1GfQ
DmFCQQ0YrvgX0FGClzdkTIiWc7MQl0ON2o01qwunieAO3lFTOH8vCrKft0J19oWA
PE7f8+1dr78uD6q4P1lWx5r1L38G3261bjacrOweTlQ8uEpISrwOit+Z4HqDNiM0
l6Nm8ANlhDjjTL59jQhE102hWOn9Kn6Dqdltah3xpkR1Zpd2uhjwqn8pQruvK7R+
tMlYyn5lcq2y7umTpqRTKbPBmPvyDB6+wYVPepV8J9q5JHDCISp9Ivhi7ssmtM8i
uQhc0qsLQ8Fg73qnDFl8Zg30k8N3oG1zG59hJ1fhaWe3drcwTix2TPzM0B2nYlNS
lGi+deIn8k7dyde3UesFjblIxQhvqx3xq+GJRGuCFjb8mtZkIps=
=3Z3j
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--
