Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C9352082D
	for <e@80x24.org>; Thu,  7 Sep 2017 11:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbdIGLf2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 07:35:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:59576 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754219AbdIGLf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 07:35:27 -0400
Received: (qmail 20598 invoked by uid 109); 7 Sep 2017 11:35:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 11:35:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31117 invoked by uid 111); 7 Sep 2017 11:36:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 07:36:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 07:35:25 -0400
Date:   Thu, 7 Sep 2017 07:35:25 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git in Outreachy round 15?
Message-ID: <20170907113525.py4m4kndslrlyepq@sigill.intra.peff.net>
References: <20170901223059.xsbcpqff45mnblnj@sigill.intra.peff.net>
 <CAP8UFD16Sg9q1TDku7gJZUCYB03GaBx0mNXjvE6A4W6zTxY6Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD16Sg9q1TDku7gJZUCYB03GaBx0mNXjvE6A4W6zTxY6Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 11:06:34PM +0200, Christian Couder wrote:

> On Sat, Sep 2, 2017 at 12:30 AM, Jeff King <peff@peff.net> wrote:
> >
> > The big questions on whether we can make this happen are:
> >
> >   1. Do we have mentor interest?
> >
> >      I'm willing to mentor, but I'd like to hear whether other people
> >      are interested, as well. Either way I can take responsibility for
> >      the administrative bits.
> 
> I am willing to co-mentor, but I prefer not to take care of administrative bits.

Thanks. I've listed you as a mentor on the landing page at:

  https://git.github.io/Outreachy-15/

The instructions for mentors can be found at:

  https://www.outreachy.org/mentor/

I've put a few projects on the landing page, but feel free to modify it
as you see fit.

> Is there something like the GSoC Mentor Summit? I think this is an
> interesting part of the GSoC and it could help motivate mentors if
> there was something like that.

No, I don't think that there is (though I'm pretty sure that there are
some sessions about Outreachy at the Mentor Summit).

-Peff
