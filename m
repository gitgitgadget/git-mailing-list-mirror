Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32D520282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbdFNN0G (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:26:06 -0400
Received: from host24.ssl-gesichert.at ([213.145.225.190]:59360 "EHLO
        host24.ssl-gesichert.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbdFNN0E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:26:04 -0400
Received: (qmail 19727 invoked by uid 7799); 14 Jun 2017 15:26:01 +0200
Received: by simscan 1.4.0 ppid: 19570, pid: 19724, t: 0.0223s
         scanners: clamav: 0.99.2/m:/d:23472
Received: from fw-103.apa.at (HELO ?10.210.240.12?) (philipp@gortan.org@194.232.128.103)
  by host24.ssl-gesichert.at with SMTP; 14 Jun 2017 15:26:01 +0200
Subject: Re: git-gui ignores core.hooksPath
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <953845c2-4326-608a-c342-2d2141da561c@gortan.org>
 <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706141457500.171564@virtualbox>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>
From:   Philipp Gortan <philipp@gortan.org>
Message-ID: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org>
Date:   Wed, 14 Jun 2017 15:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1706141457500.171564@virtualbox>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fSalNwNpxNAkJkCgoj7RocW2boSpSwTmq"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fSalNwNpxNAkJkCgoj7RocW2boSpSwTmq
Content-Type: multipart/mixed; boundary="aVVOfhBwvK77PteHePliD0MtpN5mkrtF2";
 protected-headers="v1"
From: Philipp Gortan <philipp@gortan.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Git Mailing List <git@vger.kernel.org>, Philip Oakley <philipoakley@iee.org>
Message-ID: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org>
Subject: Re: git-gui ignores core.hooksPath
References: <953845c2-4326-608a-c342-2d2141da561c@gortan.org>
 <CACBZZX6H4wxQ7hrO1Y1u6Qyr5gpK9GeCxpv-x2q3Eq2WCbkK8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706141457500.171564@virtualbox>
In-Reply-To: <alpine.DEB.2.21.1.1706141457500.171564@virtualbox>

--aVVOfhBwvK77PteHePliD0MtpN5mkrtF2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Johannes,

thanks for following up,

> Indeed. Why don't you give it a try?

Actually, I already did: https://github.com/patthoyts/git-gui/pull/12

You might want to post your analysis and patch there as well...

cu, Philipp



--aVVOfhBwvK77PteHePliD0MtpN5mkrtF2--

--fSalNwNpxNAkJkCgoj7RocW2boSpSwTmq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHEEARECADEWIQT1VoD9JYxWv4mfZ1NmXayc5UDBCwUCWUE5WBMccGhpbGlwcEBn
b3J0YW4ub3JnAAoJEGZdrJzlQMELIYQAn13AROYYLDsdumGHT59evnZElWHKAJ4s
ocq1vlzKbzTyaaXAUehJ7g6t6w==
=I5RA
-----END PGP SIGNATURE-----

--fSalNwNpxNAkJkCgoj7RocW2boSpSwTmq--
