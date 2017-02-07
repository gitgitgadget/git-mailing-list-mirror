Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C5461FCC7
	for <e@80x24.org>; Tue,  7 Feb 2017 03:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdBGD3O (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 22:29:14 -0500
Received: from ns1.bonedaddy.net ([70.91.141.202]:40244 "EHLO
        ns1.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbdBGD3N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 22:29:13 -0500
Received: from ns1.bonedaddy.net (localhost [127.0.0.1])
        by ns1.bonedaddy.net (8.14.9/8.14.4) with ESMTP id v173TAdq032648;
        Mon, 6 Feb 2017 22:29:10 -0500
Received: (from pabs3@localhost)
        by ns1.bonedaddy.net (8.14.9/8.14.9/Submit) id v173T9rB032645;
        Mon, 6 Feb 2017 22:29:09 -0500
X-Authentication-Warning: ns1.bonedaddy.net: pabs3 set sender to pabs3@bonedaddy.net using -f
Message-ID: <1486438136.16949.52.camel@bonedaddy.net>
Subject: Re: idea: light-weight pull requests
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Date:   Tue, 07 Feb 2017 11:28:56 +0800
In-Reply-To: <20170207031127.GA29468@dcvr>
References: <1486427537.16949.42.camel@bonedaddy.net>
         <20170207031127.GA29468@dcvr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LFzAPrMhETZAQdC1fy0k"
X-Mailer: Evolution 3.22.4-1 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-LFzAPrMhETZAQdC1fy0k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-02-07 at 03:11 +0000, Eric Wong wrote:

> How would discussion and review happen?=C2=A0=C2=A0People seem to use
> either mail, or centralized messaging (and the latter often
> involves non-Free systems like GitHub or Slack).

It would depend on the setup for the particular repo. Information about
where that happens could be part of the output of the git push.

> This is a big one.=C2=A0=C2=A0Maybe CRM114 or another generic/trainable
> option can be made usable; but I think there'll always be cases
> where hardcoded rules need to be written (for SpamAssassin,
> at least) and real-time blacklists need to be checked.

TBH, I doubt spam would become a problem at all.

> Anyways, I ultimately decided it would be better to continue
> supporting and improving email (which is at least entrenched in
> a few communities, like this one), rather than trying to get
> people to adopt something new.

Email is great for people used to the old ways but it is gradually
being replaced by APIs and web interfaces :(

--=20
bye,
pabs

http://bonedaddy.net/pabs3/
--=-LFzAPrMhETZAQdC1fy0k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAliZPvgACgkQMRa6Xp/6
aaNEdA//clSuyRxVdElxXGpfevPsIC7pT965eixt2cPxt62aQ+W/fx5A2agMaTWr
+m/I/VecjnVH/+gTnUjm8MFW4culrRPfsdYEI8orW5IqoRbEtx8y/aLzdyqVwocH
fU1ft37+T7GrdAEdOWxdQzXOJVden2guljBQJXJyG999mmyZF4+Zxs83GBNRQdVW
6N9+qj3brA7DlrrsBHgogzntbGnaZ0+/7NrL9fJZzsW6cEg8POu3rraEV4CkHQcz
32112vedOA5VV9Vu++ExwIp9frvAy3OZF9GhNt233axZIpIEZ/nhRVpmG7rPLdRA
JJRyJ/qJGGAhkacI3X7gQdF6Og7gYITfWqIy4SrA2b9BfcfICrYNFBzACP8Xq2Ig
ctFyvRunU/M4pzqYWyJWaGmwSyUEGNqzT/xQKblCDlhFK/2Szf2dOo+8glbK9gYU
EviaLZX5WT9TVUGAbA8tY8ShTOo9+ZSZf8xA6j9yj5Tspy2krde/mlgmqohACVg2
hmjiodzFL3AYY8zaAN7ZBaMODV07pu4E/G7dJmkrdzmPjv1CMxbiPu/f+l5nR2IN
1r/I/aoPa1uwqcDdOx1a1GwUdkTeY+KdnSdR3qGo2qbYiETQMUaHwIPET3eVvhd8
+Ki2BzL5UhXg3RTWa8Airof5+hQcT7DKw8VynmNzQdFGTflNlVc=
=mw8k
-----END PGP SIGNATURE-----

--=-LFzAPrMhETZAQdC1fy0k--
