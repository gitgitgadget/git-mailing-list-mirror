Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85A0F1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 01:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeIFFrS (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 01:47:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:40714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725978AbeIFFrR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 01:47:17 -0400
Received: (qmail 8205 invoked by uid 109); 6 Sep 2018 01:14:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 01:14:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25846 invoked by uid 111); 6 Sep 2018 01:14:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Sep 2018 21:14:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Sep 2018 21:14:28 -0400
Date:   Wed, 5 Sep 2018 21:14:28 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git in Outreachy Dec-Mar?
Message-ID: <20180906011428.GA5024@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
 <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net>
 <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
 <CAP8UFD3DrhA9C0=k-ie_fnpKwmbezQ9ufp1RPHrZ7A-VUjhz0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3DrhA9C0=k-ie_fnpKwmbezQ9ufp1RPHrZ7A-VUjhz0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 05, 2018 at 09:20:23AM +0200, Christian Couder wrote:

> >> Thanks. I think sooner is better for this (for you or anybody else who's
> >> interested in mentoring). The application period opens on September
> >> 10th, but I think the (still growing) list of projects is already being
> >> looked at by potential candidates.
> 
> Do you know where is this list? On
> https://www.outreachy.org/apply/project-selection/ they say
> "Information about projects are unavailable until applications open".

This was the list I was looking at (scroll down below the timeline):

  https://www.outreachy.org/communities/cfp/

But yeah, most of the "current projects" lists just say "not available
yet", so I think we're actually OK until the 10th.

> > So here is a landing page for the next Outreachy round:
> >
> > https://git.github.io/Outreachy-17/
> >
> > about the microprojects I am not sure which page I should create or improve.
> 
> Any idea about this? Also any idea about new microprojects would be nice.

I think #leftoverbits is your best bet for micro-projects. Last year I
think we had interns actually hunt for them via the list archive. That's
a little unfriendly for total newcomers, I think, but it also does give
a chance to demonstrate some skills. Perhaps it would be help to create
a curated list of such bits.

-Peff
