Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FC4200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbeEGXyA (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 19:54:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42000 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753545AbeEGXx6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 May 2018 19:53:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EB0F760444;
        Mon,  7 May 2018 23:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525737237;
        bh=qyWeScCVojsXNbQyrolqvgJuxQfRRsjMYget4UDprJ8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=uDRauD9FhYax5J6m8s0/VwEJzZFE30lZZJAR5Qe1fhm+F7A4TMKtOaDODPOyJlCkf
         3BdOxx2diTGhRizF4Am0/vwBnY2yb+3S+MZe+miy6ANyD0eoTkAFiANJOr8wpskMyN
         7YqCYEoK/ILAM0s8iiyMEMBmFp/1WU4xQWd052Lss4roni50KRfp0Ndkg+7KXYJ+l1
         0eqSUWEQo+/XaN3eSMvdKwpvADD1q8iFGcHw4SQsfQdiCLk1AWNa/ML26/6Yq58yTI
         SJtFZ5vveHoEq17IAKglcYapnLN4mtLJY5fTK9MYR/1VXRJZeSsVoN1cuVdws1jKPh
         f1XbcGM4Tz+5d28Y+jGo3nvaph977B+SRK/0vXA/TzjPzjkSrxtoQMsMg+aDOaC1H8
         y8qJwWhhL2eEoX29ju90VSeWrDzB6QOzJa4AJ3UYwAS46xawj4+KblI/0mh7r17/xr
         7TdXfdita9xPBWlEbWMiLdQL8ImjsG0QeuZLhGYQozWWiaulI9i
Date:   Mon, 7 May 2018 23:53:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] mailmap: update brian m. carlson's email address
Message-ID: <20180507235352.GL953644@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <xmqqa7tcqgpq.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZXXiWrGgO-KU+afncfNTZzp=AHHJY5qZqA9qAg5YLuuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gw4vLALk08fVJy3V"
Content-Disposition: inline
In-Reply-To: <CAGZ79kZXXiWrGgO-KU+afncfNTZzp=AHHJY5qZqA9qAg5YLuuQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gw4vLALk08fVJy3V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 12:25:09PM -0700, Stefan Beller wrote:
> brian,
>=20
> sorry to break you there. I was the author of the patch Junio found, orga=
nizing
> the .mailmap file was one of my starter contributions. I recall asking al=
l the
> people if they were ok with it their names combined in different spellings
> 94b410bba86 (.mailmap: Map email addresses to names, 2013-07-12)
> f4f49e2258a (.mailmap: Combine more (email, name) to individual
> persons, 2013-07-14)
> and I vaguley recall asking you about capitalization of your name there
> and you preferred the lower case name, but apparently I never asked you
> about the preferred email address.

Not a problem.  I hadn't until very recently completely understood the
format of the .mailmap file (in that the correct items are always to be
on the left), so I didn't think anything of it when reviewing the
commit.  Perhaps I should come up with a patch to the documentation to
make it easier for past me to understand.

I only recently realized that with my transition to a separate mail
server (in September), the crustytoothpaste.ath.cx address doesn't
actually work, and when perusing the output of git log, realized that it
was the wrong way around.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--gw4vLALk08fVJy3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrw5w8ACgkQv1NdgR9S
9ovu/hAAuiyTTpN9dnlnG7wd+H049WuijnigjAi/BXUtkO40OEsMIrPx3kBBW6cQ
D641HCp1WXSRTQ+pc+ByFVhSoXLCq2YdMfJPZkjW+VCX6IZwk+dzwGY1n/OH2HNY
dLweBHMZeuM/FUTcQgiY2r1QF1V7vfE+V8G37X8q9dNmF7KDFyEWFCkrHwdo1udN
DQDmXVCZ8AeqkaTTU36ABknrk4ZIkXAj5pSgAXG3lRpdYtjrk8ZUW01eRDKDIl58
aCm+ZXcm5R6bsRl0v7GFiZnW/eMWpAOiupu6iiy9vucBu+/bk0Nlh4f8atoinDiF
dDsZ+JykXJvytf0wOWVtd+HfG6P5f8IHBZsq3L9UYjXK03iIFm5jUCJLfewJU2H9
7PIgiliqCPaD6pRrYP8AnS+l0foG6P40Cjd1A0e1a5LjtbbrObaUTM1kfFyCVRkW
VLlQUBOtNdvBUosgPWSS7IW87zykeDjiNCWXIUjjBdOFMNLySguaYlUw6jswmM9c
9xp+w132Fh9c/bQg9NkLcp/wCOILPB9GYaMhNbM9dRRM4w6lbFnqIqmFGidHFDX9
NalbkhV5J5wy7WGdLx8JrTy+Z5A6IWdrh8duwv9vYRSs35zkSheRC6igYL2BJcqV
O9CGcCumbTLAHsKGIaCT9szbWG6aUtQRTCE0nUlUsgNPzDTC5/Q=
=wpjP
-----END PGP SIGNATURE-----

--gw4vLALk08fVJy3V--
