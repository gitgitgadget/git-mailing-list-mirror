Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA0F21F404
	for <e@80x24.org>; Thu, 30 Aug 2018 19:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeH3X2g (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 19:28:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:34466 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727086AbeH3X2g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 19:28:36 -0400
Received: (qmail 7345 invoked by uid 109); 30 Aug 2018 19:24:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 19:24:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30638 invoked by uid 111); 30 Aug 2018 19:25:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 15:25:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 15:24:53 -0400
Date:   Thu, 30 Aug 2018 15:24:53 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
Message-ID: <20180830192453.GC19685@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
 <8736uxe2pm.fsf@evledraar.gmail.com>
 <20180830031607.GB665@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808301340280.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808301340280.71@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 01:46:00PM +0200, Johannes Schindelin wrote:

> On Wed, 29 Aug 2018, Jeff King wrote:
> 
> >   - it naturally limits the candidate pool to under-represented groups
> >     (which is the whole point of the program, but if you don't
> >     actually care about that, then it's just a complication)
> > 
> > So IMHO it's easily worth the trouble.
> 
> I am willing to mentor, and the only reason that kept me from already
> stepping forward and trying to brush up the landing page is this concern:
> traditionally, we (as in: the core Git contributors) have been less than
> successful in attracting and retaining contributors from under-represented
> groups. I don't think any regular reader of this mailing list can deny
> that.
> 
> And while I find it very important to reach out (there are just *so* many
> benefits to having a more diverse team), I have to ask *why* we are so
> unsuccessful. As long as we do not even know the answer to that, is it
> even worth pursuing Outreachy?
> 
> I mean, if we make serious mistakes here, without even realizing, that
> directly lead to being stuck in our old bubble, then we are prone to
> simply repeat those mistakes over and over and over again. And that would
> just be a waste of our time, *and* a big de-motivator for the Outreachy
> students.
> 
> What's your take on this?

My feeling is that our lack of diversity has less to do with driving out
diverse candidates, and more that they do not join in the first place.
Which isn't to say we _wouldn't_ drive out diversity, but that I'm not
sure we have very good data on what happens in that second stage. If we
can use the program to overcome "step 1", that helps us get that data
(and hopefully react to it in time to be useful, and not just use the
candidate as a guinea pig; I agree there is the possibility of doing
more harm than good to a student who becomes de-motivated).

That leaves aside the question of whether things we are doing prevent
people from participating in the first place. I'm certainly open to that
idea, but I think it's a separate discussion.

-Peff
