Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389431F404
	for <e@80x24.org>; Thu,  6 Sep 2018 19:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbeIGALa (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 20:11:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:41690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728712AbeIGALa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 20:11:30 -0400
Received: (qmail 27201 invoked by uid 109); 6 Sep 2018 19:34:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 19:34:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7177 invoked by uid 111); 6 Sep 2018 19:34:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 15:34:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 15:34:32 -0400
Date:   Thu, 6 Sep 2018 15:34:32 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git in Outreachy Dec-Mar?
Message-ID: <20180906193431.GB28588@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
 <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net>
 <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
 <CAP8UFD3DrhA9C0=k-ie_fnpKwmbezQ9ufp1RPHrZ7A-VUjhz0g@mail.gmail.com>
 <20180906011428.GA5024@sigill.intra.peff.net>
 <CAP8UFD3-djatPqoVGNGWNQkuJ84BboFMYrGSAEOQDygjJVcqeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3-djatPqoVGNGWNQkuJ84BboFMYrGSAEOQDygjJVcqeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 11:58:16AM +0200, Christian Couder wrote:

> On Thu, Sep 6, 2018 at 3:14 AM, Jeff King <peff@peff.net> wrote:
> > On Wed, Sep 05, 2018 at 09:20:23AM +0200, Christian Couder wrote:
> >
> >> >> Thanks. I think sooner is better for this (for you or anybody else who's
> >> >> interested in mentoring). The application period opens on September
> >> >> 10th, but I think the (still growing) list of projects is already being
> >> >> looked at by potential candidates.
> >>
> >> Do you know where is this list? On
> >> https://www.outreachy.org/apply/project-selection/ they say
> >> "Information about projects are unavailable until applications open".
> >
> > This was the list I was looking at (scroll down below the timeline):
> >
> >   https://www.outreachy.org/communities/cfp/
> 
> Ok, so it's the list of "communities" not "projects" in Outreachy terms.

Yeah, sorry, when I said "projects" originally I meant what they call
"communities". But it seems that yes, the communities information is
being made public now, but the list of mentors/projects is not yet.

By the way, I've got funding from GitHub lined up, so we are good on
that front.

-Peff
