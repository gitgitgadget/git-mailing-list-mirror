Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D88D1F428
	for <e@80x24.org>; Sun,  2 Sep 2018 08:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeIBM6C (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 08:58:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:36640 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725834AbeIBM6C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 08:58:02 -0400
Received: (qmail 15114 invoked by uid 109); 2 Sep 2018 08:43:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 02 Sep 2018 08:43:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16967 invoked by uid 111); 2 Sep 2018 08:43:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 02 Sep 2018 04:43:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Sep 2018 04:43:01 -0400
Date:   Sun, 2 Sep 2018 04:43:01 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git in Outreachy Dec-Mar?
Message-ID: <20180902084301.GA21979@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
 <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net>
 <CAP8UFD1yZzbfuss8PyrXQ9SS+rKuS2vey4Mn9xtxWL4rJy2q_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1yZzbfuss8PyrXQ9SS+rKuS2vey4Mn9xtxWL4rJy2q_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 02, 2018 at 09:37:59AM +0200, Christian Couder wrote:

> > I also think it doesn't need to be the mentor's responsibility to find
> > the funding. That can be up to an "org admin", and I don't think it
> > should be too big a deal (I had no trouble getting funding from GitHub
> > last year, and I don't expect any this year; I just didn't want to start
> > that process until I knew we were serious about participating).
> 
> My experience so far with org admins who don't mentor is that they are
> likely to loose interest in the program over time and stop doing much
> (which is natural, I don't blame anyone). This is what happened with
> GSoC org admins (who don't mentor), so most of the admin work now
> falls back on mentors (org admins that mentor).
> 
> That's why I fear that in a few years the burden of finding funds for
> Outreachy might fall back on the mentors too.

Yeah, I agree that might eventually happen. I think if there are admins
willing to look for funds, though, we are better off saving our project
money for now.

-Peff
