Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC821F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeHMTOH (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:14:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:52834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728533AbeHMTOH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:14:07 -0400
Received: (qmail 6052 invoked by uid 109); 13 Aug 2018 16:31:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Aug 2018 16:31:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8854 invoked by uid 111); 13 Aug 2018 16:31:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 12:31:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 12:31:09 -0400
Date:   Mon, 13 Aug 2018 12:31:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Contributor Summit planning
Message-ID: <20180813163108.GA6731@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the past several years, we've held a Git Contributor Summit as part
of the Git Merge conference. I'd like to get opinions from the community
to help plan future installments. Any feedback or opinion is welcome,
but some obvious things to think about:

  - where, when, and how often?

    Plans are shaping up to have Git Merge 2019 in Brussels right after
    FOSDEM in February (like it was two years ago), with a contributor
    summit attached.

    Are there people who would be more likely to attend a contributor
    summit if it were held elsewhere (e.g., in North America, probably
    in the Bay Area)? Are people interested in attending a separate
    contributor summit not attached to the larger Git Merge (and if so,
    is there any other event it might be worth connecting it with,
    time-wise)?  Are people interested in going to two summits in a year
    (e.g., Brussels in February, and then maybe some in North America
    later in the year), or is that diminishing returns?

  - format

    For those who haven't attended before, it's basically 25-ish Git
    (and associated project) developers sitting in a room for a day
    chatting about the project. Topics go on a whiteboard in the
    morning, and then we discuss each for 30-60 minutes.

    We could do multiple days (which might give more room for actually
    working collaboratively instead of just discussing). We could do
    something more formal (like actual talks). We could do something
    less formal (like an all-day spaghetti buffet, where conversation
    happens only between mouthfuls). The sky is the limit. Some of those
    ideas may be better than others.

I hope this can stimulate a discussion on the list, but of course if
anybody has private feedback about past events or future planning, feel
free to email me off-list.

-Peff
