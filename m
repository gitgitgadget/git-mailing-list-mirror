Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CFC21F404
	for <e@80x24.org>; Tue, 14 Aug 2018 14:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeHNRQO (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 13:16:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:54534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728978AbeHNRQO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 13:16:14 -0400
Received: (qmail 23628 invoked by uid 109); 14 Aug 2018 14:28:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 14:28:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22600 invoked by uid 111); 14 Aug 2018 14:28:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 10:28:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 10:28:47 -0400
Date:   Tue, 14 Aug 2018 10:28:47 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Elijah Newren' <newren@gmail.com>,
        'Git Mailing List' <git@vger.kernel.org>
Subject: Re: Contributor Summit planning
Message-ID: <20180814142847.GA3324@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <CABPp-BHdoRobhF=avL+12rAJF=Qmp2vNHgwdqJxBPFs=EBm+Tw@mail.gmail.com>
 <000601d433d2$4f9b6600$eed23200$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000601d433d2$4f9b6600$eed23200$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 09:25:41AM -0400, Randall S. Becker wrote:

> Unrelated directly to above, I noticed that I actually showed up on
> the list for 2018 based on git log anyway. Does this mean I'd be
> welcome? Personally, it's actually easier to get approval to travel to
> Brussels now than SFO even though the latter is closer. With that in
> mind, I can do either (or both - depending on scheduling).

You'd definitely be welcome.

The point of having it "only developers" is mostly to keep the numbers
at a point where we can all sit around and have round-table discussions.
I don't think there are so many people at the fringe of "well, I only
have a few commits, is that enough?" for us to need to make any kind of
serious cut-off there.

What I think we want to avoid is random folks in the "I use Git, and it
would be neat to see people talk about it" camp. It would be nice to
accommodate that (and it might even manage to suck somebody into working
on the project). But that opens up a much larger pool of people, and if
(say) a hundred of them want to come, that wrecks the intimate
round-table approach.

That's all just my opinion, of course. I'm open to suggestions.

-Peff
