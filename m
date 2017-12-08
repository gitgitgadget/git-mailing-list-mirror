Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B460220C32
	for <e@80x24.org>; Fri,  8 Dec 2017 11:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbdLHLif (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 06:38:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:58345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751641AbdLHLie (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 06:38:34 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6730-1fFlRm2D74-00y709; Fri, 08
 Dec 2017 12:38:28 +0100
Date:   Fri, 8 Dec 2017 12:38:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #02; Thu, 7)
In-Reply-To: <20171208054934.GA17893@tor.lan>
Message-ID: <alpine.DEB.2.21.1.1712081227080.4318@virtualbox>
References: <xmqqfu8me7ot.fsf@gitster.mtv.corp.google.com> <20171208054934.GA17893@tor.lan>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-171833994-1512733108=:4318"
X-Provags-ID: V03:K0:1rFGTAB9IzIXKi+PQlf7uQc4Q7CsBLXAiygO3GrTqUFb16kVz4K
 oJ57sLE/EGE7uqlzngOp3LlbTWv70XAJpUbl3fJgiUoh02CzyjSyauDC5bppuyyeoc1dYPS
 QND9kG51yjj70+AnzooOBvTaJ96K8qRXrJUjhY8B9l6qfUwk45SBxC1J6JNWyQIGVLrJDKO
 PnO+mPa8nI3BELXJ9FMCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gell+K/qOhc=:gYfbW5r+ZulHphzTkd6H1y
 4Pig/8t0slCBhYgLc7jTOaJuPeN+THl/6d/UghOAwZjb5rrWpLnKU07AelXQNOnWf6x3MQdQ+
 BX7A+KuBfG5o0iR1qZEeBJxua0REqlSPUk+VmWKPqn+bT5wA6Vr7X4JL99tfZXCZv5PQsnoe8
 +agLAt2VCaV+nbORrc5k8di78gcCLdzXsfjp1kHGZ/mrGiCdQuISefWu8NCIfeHYj1CrK+q4T
 NAdTFqHPfCzxQXSNagqW1A7n+MvQ9DXuzfBYEb6m8hy0pj6f4gUPs0HbJJ2W98fXx0W9yPmoI
 Vd98T8Voyhbdz+nYJK2MJpEDDjkH4mwMymEzJqSgGbwvMTq2cmlCBfNVZXwn4qXqEEmLQBRd1
 onUVEFUpaaPmmGmlrcCkMSsdZRAmfFTfC5OnD/BCEt7di5TmPkZttx29Sf64PEthWsZXQashv
 RMH7nKwrATofTm+6x90ODULYcX9V+GwJKeXz9C//SSkbA/SvlJcMVT5n+bN2ZkWIZGDqCWtZm
 ZJ8dg/3vUfnbMVz60ns3r/WmzBB4i3y5B0uxXtSIVIKSq6bSzLW4eeFi+Bn3HAyin3wGhWdrM
 41dDKcaMyrPxSyW8zEK52I+Bhl/zRraQkuIalP9SIdKzPLf5n+NX5d9LlhXxD2fKkI8Jj2Cw2
 LVSYgCeAEp0bVoXKNWOjp2pTm3iThB4wjDbsOssewkT8FoDRVthEWdrEYJREyDD1mZyq+5apg
 NrdZp8sldsSFdZNAKScUZ6opnue6FMbJWzUYfIJjC7V/MqeoNWLlrgBmk2uw5TMMlI8bmkU1s
 MEb8caEJhuCQIarIokJYDWJ8/Uy+iDrwdCT0nKwbe5gaxt9/mI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-171833994-1512733108=:4318
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 8 Dec 2017, Torsten B=C3=B6gershausen wrote:

> > * tb/check-crlf-for-safe-crlf (2017-11-27) 1 commit
> >   (merged to 'next' on 2017-12-05 at 7adaa1fe01)
> >  + convert: tighten the safe autocrlf handling
> >=20
> >  The "safe crlf" check incorrectly triggered for contents that does
> >  not use CRLF as line endings, which has been corrected.
> >=20
> >  Broken on Windows???
> >  cf. <DA960DCE-0635-47CF-B3C4-8133021799F1@gmail.com>
>=20
> Yes, broken on Windows. A fix is coming the next days.

We might want to consider using a saner Continuous Testing workflow, to
avoid re-testing (and re-finding) breakages in individual patch series
just because completely unrelated patch got updated.

I mean, yes, it seemed like a good idea a long time ago to have One Branch
that contains All The Patch Series Currently Cooking, back when our most
reliable (because only) test facilities were poor humans.

But we see how many more subtle bugs are spotted nowadays where Git's
source code is tested automatically on a growing number of Operating
System/CPU architecture "coordinates", and it is probably time to save
some human resources.

How about testing the individual branches instead?

This would save me a ton of time, as bisecting is just too expensive given
the scattered base commits of the branches smooshed into `pu`. (There is a
new Git/Error.pm breakage in pu for about a week that I simply have not
gotten around to, or better put: that I did not want to tackle given the
time committment).)

Ciao,
Dscho
--8323329-171833994-1512733108=:4318--
