Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CFD71F463
	for <e@80x24.org>; Fri, 13 Sep 2019 20:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbfIMUvu (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:51:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:49800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387636AbfIMUvu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:51:50 -0400
Received: (qmail 5150 invoked by uid 109); 13 Sep 2019 20:51:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Sep 2019 20:51:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20110 invoked by uid 111); 13 Sep 2019 20:53:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Sep 2019 16:53:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Sep 2019 16:51:49 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190913205148.GA8799@sigill.intra.peff.net>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190913200317.68440-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 01:03:17PM -0700, Jonathan Tan wrote:

> > Do we have interested mentors for the next round of Outreachy?
> > 
> > The deadline for Git to apply to the program is September 5th. The
> > deadline for mentors to have submitted project descriptions is September
> > 24th. Intern applications would start on October 1st.
> > 
> > If there are mentors who want to participate, I can handle the project
> > application and can start asking around for funding.
> 
> I probably should have replied earlier, but if Git has applied to the
> program, feel free to include me as a mentor.

Great!  See my followup here:

  https://public-inbox.org/git/20190904194114.GA31398@sigill.intra.peff.net/

Prospective mentors need to sign up on that site, and should propose a
project they'd be willing to mentor.

> There was a discussion about mentors/co-mentors possibly working in a
> part of a codebase that they are not familiar with [1] - firstly, I
> think that's possible and even likely for most of us. :-) If any
> question arises, maybe it would be sufficient for the mentors to just
> help formulate the question (or pose the question themselves) to the
> mailing list. If "[Outreachy]" appears in the subject, I'll make it a
> higher priority for myself to answer those.

I do think it's OK for mentors to not be intimately familiar with the
part of the code that is being touched, as long as the project is simple
enough that they can pick up the technical details easily as-needed. A
lot of what mentors will help mentees with is the overall process (both
Git-specific parts, but also more general development issues). But I
think the proposed projects do need to be feasible.

I'm happy to discuss possible projects if anybody has an idea but isn't
sure how to develop it into a proposal.

-Peff
