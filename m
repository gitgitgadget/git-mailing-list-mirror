Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2EC41FAFC
	for <e@80x24.org>; Tue,  7 Feb 2017 01:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbdBGBWL (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 20:22:11 -0500
Received: from ns1.bonedaddy.net ([70.91.141.202]:39464 "EHLO
        ns1.bonedaddy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdBGBWL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 20:22:11 -0500
Received: from ns1.bonedaddy.net (localhost [127.0.0.1])
        by ns1.bonedaddy.net (8.14.9/8.14.4) with ESMTP id v171M83t028758;
        Mon, 6 Feb 2017 20:22:08 -0500
Received: (from pabs3@localhost)
        by ns1.bonedaddy.net (8.14.9/8.14.9/Submit) id v171M8Yp028754;
        Mon, 6 Feb 2017 20:22:08 -0500
X-Authentication-Warning: ns1.bonedaddy.net: pabs3 set sender to pabs3@bonedaddy.net using -f
Message-ID: <1486430520.16949.47.camel@bonedaddy.net>
Subject: Re: idea: light-weight pull requests
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Date:   Tue, 07 Feb 2017 09:22:00 +0800
In-Reply-To: <20170207005751.cgrpwuvtljfgnntb@LykOS.localdomain>
References: <1486427537.16949.42.camel@bonedaddy.net>
         <20170207005751.cgrpwuvtljfgnntb@LykOS.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-71Zq7HSZEgNihvjsqcLN"
X-Mailer: Evolution 3.22.4-1 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-71Zq7HSZEgNihvjsqcLN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-02-06 at 19:57 -0500, Santiago Torres wrote:

> IMHO, the notion of a PR/MR is more specific to Git repository
> management tools (e.g., GitHub, GitLab). They all have specific
> concepts/ways to manage the way how their hosted repositories behave ---
> and I believe this flexibility is one of the beauties in Git . I could
> see how this could be implemented by tools like this rather easily
> (e.g., using symlinks + inotify or something less hacky).

Right, but I would like to see this everywhere (including kernel.org),
so support in=C2=A0git-daemon and the http/ssh equivalents is needed too.
git already has support for anonymous push but this idea is more complex.

> I'm wondering if standardizing this would be more interesting to those
> communities?

I've pitched this to github.com/contact but couldn't find any feature
request address for GitLab.

> I would like to see what becomes of this.

Likewise :)

--=20
bye,
pabs

http://bonedaddy.net/pabs3/
--=-71Zq7HSZEgNihvjsqcLN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEYQsotVz8/kXqG1Y7MRa6Xp/6aaMFAliZITgACgkQMRa6Xp/6
aaNvyQ//Rel3JDV4HZ/X8RuYmYchnt5gdclb+zeHasNoUrR882nHUtLdf76Ta6B/
2W997n9YhC905Px+A20eSk1+LS/6Nwq/a5FyxyznhprwD5PsP3OOafYD+C7ouguv
JtFHhDiKtgV2WXIdZlNvrASMW+X2LE/Me8PnZZA/pKThkfJh/xfRRJjtuLSHZ+VN
LDdOmfBD0x7B6F40Fmy7HUFv2fE+GyFDJQ54CKSX7qneA5XubuyJ8Kbhs73fhEjh
q+NeuDWGbe+c/JYHfWtx7Tpt0Xpr8CwgqdQp78mfK+8a5FrvHCtPvPFKj+OABR4D
1ioqP9xfcFdCSO8gyqfojhaYwumBjhaCQFz+/1QJBpFCSWmoWdP3Q1nCKnZD2HWH
XzirxzQAxy337toqpPN3mV+kzN9xKA+R6C++gqeXLOMcEisAZBpSkxcfugeGbkQP
5Pzv9cLc5xkDN5ZO4RKYW68KpwQjBlCvnqE4SL0XL1VSEYaWQoO1K2YHVyyXpKCn
5o1H2QUsD7S5YjsNLKM9FAJvDO/fFKA4g1OwNYLQXCHT2ClmSf5xfyr+vyjVdEKH
XK0eKWLKlrd8omp3vSgeaoKBC2MvYUS5paHiHtb8umu15DmJXw1MRwvkl4zNtNwB
orAlWSDNXtdRMbH8WbssrxUy8H+lFbHOqdkcvhAd391jsfubKio=
=StW5
-----END PGP SIGNATURE-----

--=-71Zq7HSZEgNihvjsqcLN--
