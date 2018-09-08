Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E044B1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 15:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeIHU1H (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 16:27:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:43696 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726877AbeIHU1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 16:27:07 -0400
Received: (qmail 8946 invoked by uid 109); 8 Sep 2018 15:40:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 08 Sep 2018 15:40:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28284 invoked by uid 111); 8 Sep 2018 15:41:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Sep 2018 11:41:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Sep 2018 11:40:53 -0400
Date:   Sat, 8 Sep 2018 11:40:53 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: Git in Outreachy Dec-Mar?
Message-ID: <20180908154053.GA32647@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
 <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net>
 <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
 <20180906012143.GA7477@sigill.intra.peff.net>
 <CAP8UFD1nbv6=6JLnOCkmCcZjNOcDfOm4oH7pxHsYcddUYUxBPw@mail.gmail.com>
 <20180906193130.GA28588@sigill.intra.peff.net>
 <CAP8UFD3y=p_w5scnB0dggqK7jb5x-2x=d4LUCXLVVGkRcAOcJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3y=p_w5scnB0dggqK7jb5x-2x=d4LUCXLVVGkRcAOcJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 08, 2018 at 10:57:46AM +0200, Christian Couder wrote:

> On Thu, Sep 6, 2018 at 9:31 PM, Jeff King <peff@peff.net> wrote:
> > On Thu, Sep 06, 2018 at 11:51:49AM +0200, Christian Couder wrote:
> >
> >> Yeah, I think the https://git.github.io/Outreachy-17/ is not actually necessary.
> >
> > I think it still may be helpful for explaining in further detail things
> > like #leftoverbits (though I see you put some of that in your project
> > description).
> 
> You mean in https://git.github.io/Outreachy-17/ or somewhere else?
> 
> It is already described in https://git.github.io/SoC-2018-Microprojects/.

Yeah, I meant it may still be useful to have an Outreachy page for our
community explaining community-specific procedures. I agree it's mostly
redundant with what's on the GSoC page, but it might be easier on
applicants to have a page tailored directly towards Outreachy. But I
haven't gone over the material as recently as you, so I'd leave that
decision to you.

-Peff
