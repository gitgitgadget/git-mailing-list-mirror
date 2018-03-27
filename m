Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59881F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeC0QBT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:01:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:39313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751486AbeC0QBS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:01:18 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQdAP-1f8iqm1YvV-00U4xu; Tue, 27
 Mar 2018 18:01:09 +0200
Date:   Tue, 27 Mar 2018 18:01:07 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Windows build on Travis CI (was: Re: [PATCH v2 01/36] t/helper:
 add an empty test-tool program)
In-Reply-To: <CAM0VKjmRiOjb6Jsx1XCfGWe_9+AqJGeBvAWt2sM1_rJArdEVQA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803271758490.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAM0VKjmRiOjb6Jsx1XCfGWe_9+AqJGeBvAWt2sM1_rJArdEVQA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-571997179-1522166469=:77"
X-Provags-ID: V03:K0:hfS92AByGY+BWptJ8M0QA4xE3cU6ZcV9CXglSG4JEyGimceujUg
 tjjkfA2/FnfLVXsoUTI+kzKyQlyAbQwOgfQGdvcojBE4e3A3iEYk65Sd5dkSvKxxWmrtcYf
 m/uST8Eo4FMFWNqXtwJjXtHzfel6nsfmljZHIUP4mzOqYhV6XURwvtA+QpRfpfRlEWjMILi
 +z+5Frn7aH8sJ1LSUOung==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HV01auJzCv8=:WLrF/8VbWloxkQPT0ULnBV
 Er1PJlMqXJDs9xoE5106JcuA6a374/vBq0K4FkhAAUxc5LIMZOaoXdT1CvoEeyG4S/TCLUrvl
 GyIqnFNugK2VySLeOc17imulty40iKMCqLPsP6n2Fiq+B/VbECWkKzKRJAejhjQAvTl/bPykX
 lpYJmSowbFKxk0QfLYXSVrWT6nYbq4HS6UyYk121DvTxj+Oouvs80oqGXoZOiQKwl0L+peGh4
 MTzLWNKDueh7y9z/2uxwlesUdumlyz6uR8JSLcBwi9Ocb8kf+dAKMjmvJEhMGl3/Oskj2Lt4A
 rxtVI5JA1hhhU/z7Psv8gz4SL+uQQ5x4I8N97x+Ri8OiJAYOMBtFY3ccoUa4EqSepBirPhfHp
 BZ8Wwce+HIJCLQmQgwsxyB68mJJbhG81GN828CEsyian75if7mloXd5SK8hWYgc+kQE8g4oZi
 bzBgH0kx6Pi0rx2UiXDgIyouxye5IiAulI4zuJc/FkqE9hUVAnaBpWvkUu6ZP/gQgHpzGXEPP
 eAqswafobuKPEveetLx6zG0cdnZp8qSbX/o6+25E2ALEWAV0oyzN4Re10KwYj/n0Bi+iR5RXr
 i/x6ekf/Hxzv0DRlVEvfZUHI4jE72etjLGWxYH+MVcspgkFie51bM5XmWrXTOPGdIqjI22oL/
 lE/bXxq+ShYeCLQsX3wKGe+4RQTZtoFGEnGXk9ryJXfuVzfQdJfGLtdeixFX99qgAALeVy+ZP
 R9uNHh0eoVrQigYD4OUr0rlfDvTHopSBuoLJw//hjH9qjo6BDYL7BSZJNBtmHOvVN/fs9XCbI
 uA3SHId1mkmgwQCgWY+97IGRtQexRrFexbkZOslTG6Ddc4VwSQbDBQVwfP34Z3GkjsZqfmK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-571997179-1522166469=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Tue, 27 Mar 2018, SZEDER G=C3=A1bor wrote:

> On Tue, Mar 27, 2018 at 3:57 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 27 Mar 2018, SZEDER G=C3=A1bor wrote:
> >
> >> On Tue, Mar 27, 2018 at 12:14 AM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >> > However, it seems that something is off, as
> >> > ba5bec9589e9eefe2446044657963e25b7c8d88e is reported as fine on Wind=
ows:
> >> > https://travis-ci.org/git/git/jobs/358260023 (while there is clearly=
 a red
> >> > X next to that commit in
> >> > https://github.com/git/git/commits/ba5bec9589e9eefe2446044657963e25b=
7c8d88e,
> >> > that X is due to a hiccup on macOS).
> >> >
> >> > It seems that the good-trees feature for Travis does not quite work =
as
> >> > intended. G=C3=A1bor?
> >>
> >> AFAICT it works as expected.
> >>
> >> When a build job encounters a commit with a tree that has previously
> >> been built and tested successfully, then first it says so, like this:
> >>
> >>   https://travis-ci.org/szeder/git/jobs/347295038#L635
> >
> > But what if it has not been built successfully (as was the case here)?
> > This very commit that is "succeeding" on Travis fails to compile on
> > Windows.
>=20
> Then why has the GfW web app reported success?
>=20
>   https://travis-ci.org/git/git/jobs/358260023#L512

Oy. There was a shift in build steps, so that shows the wrong output. The
correct build step ends thusly:

-- snip --
[...]
2018-03-26T06:50:55.0000371Z Checking out files:  97% (3136/3232)  =20
2018-03-26T06:50:55.0106984Z Checking out files:  98% (3168/3232)  =20
2018-03-26T06:50:55.0223806Z Checking out files:  99% (3200/3232)  =20
2018-03-26T06:50:55.0227819Z Checking out files: 100% (3232/3232)  =20
2018-03-26T06:50:55.0228191Z Checking out files: 100% (3232/3232), done.
2018-03-26T06:50:55.0343621Z HEAD is now at 90bbd502d Sync with Git 2.16.3
2018-03-26T06:50:55.0759061Z Updating upstream
2018-03-26T06:50:56.3001946Z From https://github.com/git/git
2018-03-26T06:50:56.3002737Z  * [new branch]          maint      -> upstrea=
m/maint
2018-03-26T06:50:56.3003056Z  * [new branch]          master     -> upstrea=
m/master
2018-03-26T06:50:56.3003832Z  * [new branch]          next       -> upstrea=
m/next
2018-03-26T06:50:56.3354328Z  * [new branch]          pu         -> upstrea=
m/pu
2018-03-26T06:50:56.3354880Z  * [new branch]          todo       -> upstrea=
m/todo
2018-03-26T06:50:56.8219992Z fatal: Not a valid commit name 7a6a7fb7d0ab105=
2db113318478f9e40e66e59dc
2018-03-26T06:50:56.8236547Z Commit 7a6a7fb7d0ab1052db113318478f9e40e66e59d=
c is not on branch upstream/master; skipping
```

So as you see, by the time we fetched `pu`, it was no longer reachable
(otherwise we would have been able to fetch it).

That's a bummer.

Ciao,
Dscho
--8323329-571997179-1522166469=:77--
