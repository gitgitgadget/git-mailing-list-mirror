Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F24B1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 19:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfBGTjS (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 14:39:18 -0500
Received: from mout.gmx.net ([212.227.15.15]:50227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfBGTjS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 14:39:18 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkgAG-1hPnLt00to-00aTHA; Thu, 07
 Feb 2019 20:39:09 +0100
Date:   Thu, 7 Feb 2019 20:39:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
In-Reply-To: <20190206220942.GE6085@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com> <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com> <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jg7Qd6H3YrzFN2UbmI+i7ZVl/m9y4gm3noCJG+aw/huwUvSjP5z
 lQI7A856PLHKQW7MiIY0341oruVluufXVFYepl7p6eJsqr2bsxAPdMHLp6bXnq4shXl7/MI
 GBmmngrmujvcZ7ni3YCOBRXV5u1hSlPz+8sBKHmY1J8bTP1iNmppaL3dPNC0MCF4+kkvuIl
 7KUVSUXcf2RawTZrvezqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cfDCXKaNzSU=:1jPhwTWYi9Ap8sqAQmLVxw
 1/CXgP6z4oFf6eE8cHMa0+O3M6Z1tEycD7Vzelyk97Y+iGMZHcAP+ZTCOyikDJF8HyuLm2ZXw
 iq8vH+iV6X22IO4HYix4cpgYPNlTps84c2/B5TPNOr9wdHepoYazb8RLPmo4KxK9HSQ4udC+f
 BoB8sjJI9gV1bi/aCyLnsdH1aGKmUmrqoKg9oB5bJamigYvoo8KOlhzKJAFSm6Y52Sau8ckHo
 p4elXvsnScfA43Gu1i+VYvO2ul68bKa35TJSyOu+edUj9cr96lzUzoLFoFwdL9OHRf48+Rx9y
 Y57q6idGlVH3kmgoU1w8Sqks569xrsZL1Mh+xHkQGi+r+8qzLNjRTPmqQrI/JWtHxhJgcHhVk
 Dmcop9k/Sm6/XrhKWKFQje7D16NbkbOm1jaHtlBOcBYlo7kU8Ke6V9bhvYe6z3n329CLZAYQv
 JTkdwSrxckpwuleqKzcOV45W0gAPrYCNVqiiggPg626k/VgOy9Ilpta84mW5wk0tueQk0Cw9S
 ECM8Y9wwqM6yeJO3h4FbNY0B6ndmO5KoBQqbT/2cQ2tB4WI26QKzc1gERJUboocB0PRuXazFp
 LrwrMiCL46gKZusVLvzOn+OFjwG3tvt04egYWRX+LbhNf8BEncURK0bAdvfWUTSPgrhhgUYAT
 mqCeLxgcLmVhqRtUDde10J6sUr3POf8RBnaoLDdEOcxJTqVPF/PUl/YY5pLRyVE9QB1Fje5QP
 Do1dBKuD/ixQn8XktTL6qiz/nA2hd7x3kF4mcI9JsMyz7tyHm00/Mz5p+OWgLomVuem2uGNsU
 8gv8tBdrtrK9GA4pARMHueD8v74IUSF4Sh8+ZRRS2Rx4/fbVrZlEpAYnAxwaPHLMzoZNthx1S
 QWW3XAWZrJ7uQiSUP4q2raZbi+vggw5yJb9nTT6aswCeED+TSIdcZxV3dmijKjqXlq2f/z57S
 7DeV8JQgPzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Wed, 6 Feb 2019, Thomas Gummerer wrote:

> I think the idea here could definitely be split into a couple different
> phases, that could be individually useful, and can be merged
> individually, though I don't know if they would necessarily be.

Good idea.

> Of the top of my head:
> 
>  - write test_expect_failure tests for the expected new behaviour
> 
>    This may not be worth including in git.git yet, but it can be a
>    very useful starting point for somebody else continuing the feature
>    if the student finds they don't have time for it.

I like this approach.

>  - implement pushing the index state, without dealing with conflicts
>  - implement poping the index state, without dealing with conflicts
> 
>    This can already be individually useful, and I think this is
>    something people asked for on the mailing list, though I didn't try
>    digging up old threads for now.  After these two steps stashing and
>    restoring a merge conflict would still not work, but we have a good
>    first step that could be merged.

We already have `git stash --keep-index`. Is this what you mean here?

>  - implement pushing/poping conflicted state
> 
>    This would obviously be the end goal.

On second thought, this might actually be super trivial. Right now, we
support two modes (not counting the `--untracked` stuff): --keep-index and
--no-keep-index. In both cases, we seem to create a merge commit whose
tree reflects the working directory and whose first parent is HEAD and
whose second parent is a single commit on top of HEAD (which contains
either no changes in the case of --no-keep-index, or whose tree reflects
the index in case of --keep-index).

To extend that to the conflict case, we could introduce a new flag
--with-conflicts, and have the commit structure

	Worktree
	 |    \
	 |    index stage 0
	 |      /     |     \
	 | stage 1  stage 2  stage 3
	 |    /     /       /
	HEAD ---------------

The only tricky thing I can see is to maintain backwards compatibility if
possible, so that old `git stash` will do something at least semi-sensible
with those commit structures.

It might be too small a project, after all.

Ciao,
Dscho

> > Another potential issue is that a new feature might be prone to naming
> > or user interface discussions which could last for a long time or
> > could not result in clear decisions.
> 
> Yes, this is definitely a potential pitfall.  I haven't thought in
> depth about the interface yet, but I think the discussion around that
> would be something we as mentors could and should guide the student
> through.  We also wouldn't make the feature the default from the
> beginning, but introduce it behind a new flag/maybe a config option,
> to make sure we don't introduce any backwards compatible changes.
> 
> It's probably also something the student should include in their
> proposal, so we can get eyes on it early in the process.
> 
> > So I think we should be very careful if we propose a project that
> > implements a new feature to a student. We should at least consider the
> > above potential issues and see if they can be mitigated before the
> > project starts.
> 
> Thanks for bringing these issues up, they are definitely useful to
> work through.  
> 
> > Thank you anyway for proposing this idea,
> > Christian.
> 
