Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB7931F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 22:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbdIAWbC (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 18:31:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:55398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752515AbdIAWbB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 18:31:01 -0400
Received: (qmail 20020 invoked by uid 109); 1 Sep 2017 22:31:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Sep 2017 22:31:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6623 invoked by uid 111); 1 Sep 2017 22:31:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Sep 2017 18:31:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Sep 2017 18:30:59 -0400
Date:   Fri, 1 Sep 2017 18:30:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Git in Outreachy round 15?
Message-ID: <20170901223059.xsbcpqff45mnblnj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I know we're just finishing up GSoC, but I want to get opinions on Git
participating in the next round of Outreachy, which will be accepting
interns over the next month or two.

Details and timelines are here:

  https://www.outreachy.org/

  https://www.outreachy.org/mentor/

For those not familiar with Outreachy, it's an internship program
focused on providing mentorship and stipends to groups that are
under-represented in Tech. The internship term is 3 months. Unlike other
programs like GSoC, individual projects (rather than the program) cover
the stipend, which is $6500 this round.

The big questions on whether we can make this happen are:

  1. Do we have mentor interest?

     I'm willing to mentor, but I'd like to hear whether other people
     are interested, as well. Either way I can take responsibility for
     the administrative bits.

     We could probably use some effort brushing up our project-ideas
     page. I've also considered whether it would make sense to do a
     "mixed bag" project where somebody works on multiple smaller
     projects, and we try to get them more involved in day-to-day
     project activities (after all, very few of us started working on
     Git with a dedicated 3-month project; people typically ease into it
     by fixing small problems, reviewing code, etc).

  2. Do we have the money (and want to spend it on this)?

     The Git project does have money to cover at least one intern.

     I'm looking into securing outside funding, so that we don't have to
     use project funds. If for whatever reason that doesn't happen, is
     this something we want to spend project money on?

     (My opinion is yes, but I'd like to hear what others in the
     community think).

-Peff
