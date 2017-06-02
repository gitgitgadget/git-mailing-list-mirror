Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723A92027C
	for <e@80x24.org>; Fri,  2 Jun 2017 20:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdFBUjS (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 16:39:18 -0400
Received: from host24.ssl-gesichert.at ([213.145.225.190]:47608 "EHLO
        host24.ssl-gesichert.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdFBUjS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 16:39:18 -0400
Received: (qmail 2324 invoked by uid 7799); 2 Jun 2017 22:39:16 +0200
Received: by simscan 1.4.0 ppid: 2218, pid: 2316, t: 0.0646s
         scanners: clamav: 0.99.2/m:57/d:23441
Received: from 80-109-4-187.cable.dynamic.surfer.at (HELO archie.gortan.local) (philipp@gortan.org@80.109.4.187)
  by host24.ssl-gesichert.at with SMTP; 2 Jun 2017 22:39:16 +0200
Subject: Re: [PATCH] respect core.hooksPath, falling back to .git/hooks
To:     philipoakley@iee.org
Cc:     avarab@gmail.com, git@vger.kernel.org,
        matthias.serfling@googlemail.com
References: <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
 <20170602202301.6413-1-philipp@gortan.org>
From:   Philipp Gortan <philipp@gortan.org>
Message-ID: <4d3ff7fd-06c1-b609-e872-c1145589e180@gortan.org>
Date:   Fri, 2 Jun 2017 22:39:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170602202301.6413-1-philipp@gortan.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ftxqOudNla6K8N1hn5QvlsDJQM8DCpFPg"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ftxqOudNla6K8N1hn5QvlsDJQM8DCpFPg
Content-Type: multipart/mixed; boundary="aO8GwsUQO3vL5jSe689191UUb6n3XIh0q";
 protected-headers="v1"
From: Philipp Gortan <philipp@gortan.org>
To: philipoakley@iee.org
Cc: avarab@gmail.com, git@vger.kernel.org, matthias.serfling@googlemail.com
Message-ID: <4d3ff7fd-06c1-b609-e872-c1145589e180@gortan.org>
Subject: Re: [PATCH] respect core.hooksPath, falling back to .git/hooks
References: <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
 <20170602202301.6413-1-philipp@gortan.org>
In-Reply-To: <20170602202301.6413-1-philipp@gortan.org>

--aO8GwsUQO3vL5jSe689191UUb6n3XIh0q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Philip,

the previous mail contains a patch against the master of
http://repo.or.cz/git-gui.git

Could you please review it? I am not a TCL developer, so please take
extra care!

Thanks,
Philipp


--aO8GwsUQO3vL5jSe689191UUb6n3XIh0q--

--ftxqOudNla6K8N1hn5QvlsDJQM8DCpFPg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQT1VoD9JYxWv4mfZ1NmXayc5UDBCwUCWTHM8QAKCRBmXayc5UDB
Cyg3AJwKFiYWUupEdJEvR0eFqSlZ0ZBMbQCcChdycIMkTqhOZasLd2XK74sagGE=
=peC/
-----END PGP SIGNATURE-----

--ftxqOudNla6K8N1hn5QvlsDJQM8DCpFPg--
