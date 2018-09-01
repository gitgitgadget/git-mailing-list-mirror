Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 954D81F404
	for <e@80x24.org>; Sat,  1 Sep 2018 08:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeIAMyi (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 08:54:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:36190 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725964AbeIAMyi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 08:54:38 -0400
Received: (qmail 26688 invoked by uid 109); 1 Sep 2018 08:43:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Sep 2018 08:43:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11728 invoked by uid 111); 1 Sep 2018 08:43:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 01 Sep 2018 04:43:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2018 04:43:22 -0400
Date:   Sat, 1 Sep 2018 04:43:22 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git in Outreachy Dec-Mar?
Message-ID: <20180901084321.GC25852@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
 <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 10:16:49AM +0200, Christian Couder wrote:

> >   2. To get our landing page and list of projects in order (and also
> >      micro-projects for applicants). This can probably build on the
> >      previous round at:
> >
> >        https://git.github.io/Outreachy-15/
> >
> >      and on the project/microprojects lists for GSoC (which will need
> >      some updating and culling).
> 
> Ok to take a look at that.

Thanks. I think sooner is better for this (for you or anybody else who's
interested in mentoring). The application period opens on September
10th, but I think the (still growing) list of projects is already being
looked at by potential candidates.

> >   3. To figure out funding (unlike GSoC, the intern stipend comes from
> >      the projects). I can look into getting outside funds (which is what
> >      we did last year). Worst case, we do have enough project money to
> >      cover an intern. Last year[1] opinions were that this was a
> >      reasonable use of project money, but of course new opinions are
> >      welcome.
> 
> I can also look at getting outside funds.
> 
> My opinion though is that it is probably better if the Git project can
> use its own fund for this, as it makes it easier for possible mentors
> if they don't need to look at getting outside funds.

I disagree. An internship costs more than we generally take in over the
course of a year. So we would eventually run out of money doing this.

I also think it doesn't need to be the mentor's responsibility to find
the funding. That can be up to an "org admin", and I don't think it
should be too big a deal (I had no trouble getting funding from GitHub
last year, and I don't expect any this year; I just didn't want to start
that process until I knew we were serious about participating).

So if you (or anybody else) wants to mentor, please focus on the project
list and application materials.

-Peff
