Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	TVD_SPACE_RATIO shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F7FF2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 23:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdFBXWF (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 19:22:05 -0400
Received: from host24.ssl-gesichert.at ([213.145.225.190]:59956 "EHLO
        host24.ssl-gesichert.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBXWE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 19:22:04 -0400
Received: (qmail 7614 invoked by uid 7799); 3 Jun 2017 01:22:02 +0200
Received: by simscan 1.4.0 ppid: 7510, pid: 7605, t: 0.5587s
         scanners: clamav: 0.99.2/m:57/d:23441
Received: from 80-109-4-187.cable.dynamic.surfer.at (HELO archie.gortan.local) (philipp@gortan.org@80.109.4.187)
  by host24.ssl-gesichert.at with SMTP; 3 Jun 2017 01:22:02 +0200
Subject: Re: git-gui ignores core.hooksPath
To:     Philip Oakley <philipoakley@iee.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
References: <953845c2-4326-608a-c342-2d2141da561c@gortan.org>
 <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
 <7B6DC5C9C2354BD9BB08DD84FF6628D1@PhilipOakley>
From:   Philipp Gortan <philipp@gortan.org>
Message-ID: <a651b597-60a4-0fcf-6912-c0f103ae2d0b@gortan.org>
Date:   Sat, 3 Jun 2017 01:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <7B6DC5C9C2354BD9BB08DD84FF6628D1@PhilipOakley>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DqGh3IB7qb6flvSxpKdcwDvWKkPVfLs3M"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DqGh3IB7qb6flvSxpKdcwDvWKkPVfLs3M
Content-Type: multipart/mixed; boundary="i1dH1WJ65jOaI7Xh4ncEUmcwb8iAS35dx";
 protected-headers="v1"
From: Philipp Gortan <philipp@gortan.org>
To: Philip Oakley <philipoakley@iee.org>
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Git Mailing List <git@vger.kernel.org>,
 Pat Thoyts <patthoyts@users.sourceforge.net>
Message-ID: <a651b597-60a4-0fcf-6912-c0f103ae2d0b@gortan.org>
Subject: Re: git-gui ignores core.hooksPath
References: <953845c2-4326-608a-c342-2d2141da561c@gortan.org>
 <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
 <7B6DC5C9C2354BD9BB08DD84FF6628D1@PhilipOakley>
In-Reply-To: <7B6DC5C9C2354BD9BB08DD84FF6628D1@PhilipOakley>

--i1dH1WJ65jOaI7Xh4ncEUmcwb8iAS35dx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Thanks Philip,

I've created a pull request there -
https://github.com/patthoyts/git-gui/pull/12


--i1dH1WJ65jOaI7Xh4ncEUmcwb8iAS35dx--

--DqGh3IB7qb6flvSxpKdcwDvWKkPVfLs3M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQT1VoD9JYxWv4mfZ1NmXayc5UDBCwUCWTHzFwAKCRBmXayc5UDB
C230AJ9vgInqcipdeeQ6VXTcJvO5/d+ILQCgknrYoEjBCfGEtn4Dg8543lIAU6I=
=LjNy
-----END PGP SIGNATURE-----

--DqGh3IB7qb6flvSxpKdcwDvWKkPVfLs3M--
