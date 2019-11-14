Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E324D1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 06:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfKNGGw (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 01:06:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:47108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725807AbfKNGGw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 01:06:52 -0500
Received: (qmail 22245 invoked by uid 109); 14 Nov 2019 06:06:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Nov 2019 06:06:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1045 invoked by uid 111); 14 Nov 2019 06:10:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 01:10:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 01:06:50 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Garima Singh <garimasigit@gmail.com>
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20191114060650.GC10643@sigill.intra.peff.net>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
 <20191112184547.GA38770@google.com>
 <nycvar.QRO.7.76.6.1911122100220.46@tvgsbejvaqbjf.bet>
 <CAP8UFD2qjUa=y81YPVSMcuEcDkrkrV=j912qySmG83pig=dFDg@mail.gmail.com>
 <20191113150624.GC3047@cat>
 <20191114023100.GD22855@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114023100.GD22855@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 13, 2019 at 06:31:00PM -0800, Emily Shaffer wrote:

> Christian's suggestion of a Google Group list was good enough for me.
> For now, the permission settings are as follows:
> 
>  - Group visibility: Anyone. (So it can be easier to discover and
>    advertise.)
>  - View topics: Group members only. (Maybe we want to open this up so
>    it's easier for non-member Git contributors to take a look at what's
>    going on.... but maybe if they're interested they can just join the
>    group :) )

I think it makes sense to stay closed for now. One of the reasons to
have a separate group is to make it less daunting to post to. Having a
public archive may work against that.

>  - Post: Group members only. (My thinking is that once you're asking for
>    someone's time and effort to help mentor you, you can volunteer the
>    time and effort needed to push the join button and optionally filter
>    your inbox ;) )

It also cuts down on spam (I moderate the git-security google group, and
the spam-blocking is far from perfect).

It is annoying if things get cross-posted to git@vger (whoever replies
with the cc intact will get an annoying "you can't post here" bounce).
But I'd try it this way for a while and see.

>  - Join group: Anyone. (Let's make the barrier to entry low.)

Makes sense. I just joined.

-Peff
