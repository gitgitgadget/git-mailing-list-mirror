Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57E51F453
	for <e@80x24.org>; Tue, 16 Oct 2018 12:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeJPUgO (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 16:36:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:57005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPUgO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 16:36:14 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lqm3a-1fhzvL3OU6-00eOQP; Tue, 16
 Oct 2018 14:45:49 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lqm3a-1fhzvL3OU6-00eOQP; Tue, 16
 Oct 2018 14:45:49 +0200
Date:   Tue, 16 Oct 2018 14:45:52 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/13] travis: fix skipping tagged releases
In-Reply-To: <20181016094016.GI19800@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1810161445300.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com> <0a53f371350146ecd01b44f0f42da447d7573689.1539598316.git.gitgitgadget@gmail.com> <20181016094016.GI19800@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-61574318-1539693953=:4546"
X-Provags-ID: V03:K1:ex6QwULzHZiu4QrjgAp3WUsUntvX4klAZRsAR73qcPiUCFryO1C
 WoW/kEQ3txJ4fzJJcX+4ARwM3PS3iBZUgLx4JHu3vYhHT4d+MFn4y3fMIbHkOLplmdrt3qu
 D1itzrN6Mb/ZdYHAbP2R0YJs17ydfWn4+VWGOCdeCsVxoPQK5ds8sT8OSCg76Wln8SaQ9Pd
 pwjfES+FmkO5qSlIVGmwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bbpmzBtkSZA=:6B4ofTkAJw4d6oW+Cx92va
 b3mQOtwtPGYP0TeIfDcHYD0PXELAORyMDrVlfTO8JgWyAs+FF1EXJ99iUiwSbTLZMTWcQK74U
 dgOl/wpP4cRMZUduO3h94rGiDt1xmSOSNTLmxj/xnINjkuiJTn9iDU9FMXBg4ejgX1m1Nr8pq
 3aQ9gSKkRB06IVbium96GL0dR8mVsXBYC6dx+T9pFG+FdLm6wD+BaAxDc4FFjOXhgBHmzis+V
 pxWZig0bkuQP4hU795s/6V/m07iD/67ohhPOhx7GB9iWq/vHm7ae+dBeAI1RGN9fgQEr+T2OJ
 NC6LpvagPO6EMUby43Kj+L2PlioIlHhiU+K+Bfcui/1vYx0UA8i5yXKnV8BM0ygwm9/JLq1wc
 gFRWT9va95Cxh72kAIKboLrdl/AO4cUu4kxaPM6EWuiWiS+pb+bZzZ4EWFlNAeg2De9HBX9hy
 khgMvuGDrUxlCXOIdebVetuI4ZwZkhZTURrIftBC5cAutcgMf9NgmBTFlBC/ISUB2JyEkXPQp
 /vkk53gNmulcds3vFhflr3sXAIkF3z6VxeGp7/E6dR6mtMt81gMG0bfEjuNItnCuEwFOWpBh4
 LhURxQZRGr2FJNk73Uf3Imo1ZrNXgbamjPftw4/htvpLz2mNJ8pINxV2xtnUKPHX6TJ0OATCV
 32GK2uAuUNGh8kum7KwMDNYVBd23ee/aIU8aWO+9mWqfqTptw12JphkC9mWmRlv9vaI3EZQKB
 YJagGsMY4ygji/wxyEo8UT00Pkz0v9hPZITLnIQARYzlzZveg06FKZj6j4xRYn3SndgHfptqx
 MRVhQGAbh1JrqUlqHMmAA9bPpO2HWSeCWi6XOl8u7CMPHZLJ2Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-61574318-1539693953=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Junio,

On Tue, 16 Oct 2018, SZEDER Gábor wrote:

> On Mon, Oct 15, 2018 at 03:12:17AM -0700, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > When building a PR, TRAVIS_BRANCH refers to the *target branch*.
> > Therefore, if a PR targets `master`, and `master` happened to be tagged,
> > we skipped the build by mistake.
> > 
> > Fix this by using TRAVIS_PULL_REQUEST_BRANCH (i.e. the *source branch*)
> > when available, falling back to TRAVIS_BRANCH (i.e. for CI builds, also
> > known as "push builds").
> 
> This all makes sense, but this patch is fixing a long-standing issue
> in our Travis CI build scripts (present since 09f5e9746c (travis-ci:
> skip a branch build if equal tag is present, 2017-09-10)), so it
> should be the first in the series.  So it could be picked up and
> perhaps even graduated faster than the rest of this patch series.

Makes sense.

Thanks,
Dscho

> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/lib.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index 584abcd529..e1858ae609 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -3,7 +3,7 @@
> >  if test true = "$TRAVIS"
> >  then
> >  	# We are running within Travis CI
> > -	CI_BRANCH="$TRAVIS_BRANCH"
> > +	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
> >  	CI_COMMIT="$TRAVIS_COMMIT"
> >  	CI_JOB_ID="$TRAVIS_JOB_ID"
> >  	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
> > -- 
> > gitgitgadget
> 
--8323328-61574318-1539693953=:4546--
