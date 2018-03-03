Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770771F576
	for <e@80x24.org>; Sat,  3 Mar 2018 10:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeCCKkA (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 05:40:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:45590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751853AbeCCKkA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 05:40:00 -0500
Received: (qmail 25511 invoked by uid 109); 3 Mar 2018 10:40:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 10:40:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4807 invoked by uid 111); 3 Mar 2018 10:40:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 05:40:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 05:39:57 -0500
Date:   Sat, 3 Mar 2018 05:39:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: Contributor Summit planning
Message-ID: <20180303103957.GA24498@sigill.intra.peff.net>
References: <20180303103010.GA21068@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180303103010.GA21068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 03, 2018 at 05:30:10AM -0500, Jeff King wrote:

> As in past years, I plan to run it like an unconference. Attendees are
> expected to bring topics for group discussion. Short presentations are
> also welcome. We'll put the topics on a whiteboard in the morning, and
> pick whichever ones people are interested in.
> 
> Feel free to reply to this thread if you want to make plans or discuss
> any proposed topics before the summit. Input or questions from
> non-attendees is welcome here.

I'll plan to offer two topics:

 - a round-up of the current state and past year's activities of Git as
   a member project of Software Freedom Conservancy

 - some updates on the state of the git-scm.com since my report last
   year

As with last year, I'll try to send a written report to the list for
those who aren't at the summit in person.

-Peff
