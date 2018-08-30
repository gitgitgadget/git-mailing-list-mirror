Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936151F404
	for <e@80x24.org>; Thu, 30 Aug 2018 03:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeH3HUH (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 03:20:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:33422 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727305AbeH3HUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 03:20:07 -0400
Received: (qmail 2130 invoked by uid 109); 30 Aug 2018 03:20:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 03:20:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22070 invoked by uid 111); 30 Aug 2018 03:20:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 23:20:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 23:20:06 -0400
Date:   Wed, 29 Aug 2018 23:20:06 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Contributor Summit planning
Message-ID: <20180830032006.GC665@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808271523180.73@tvgsbejvaqbjf.bet>
 <20180829045548.GB15274@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808291644430.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808291644430.71@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 04:46:29PM +0200, Johannes Schindelin wrote:

> On Wed, 29 Aug 2018, Jeff King wrote:
> 
> > On Mon, Aug 27, 2018 at 03:34:16PM +0200, Johannes Schindelin wrote:
> > 
> > > Rather than have a "hack day", I would actually prefer to work with
> > > other contributors in a way that we have not done before, but which I
> > > had the pleasure of "test ballooning" with Pratik: using Visual Studio
> > > Code Live Share. This allows multiple users to work on the same code
> > > base, in the same worktree, seeing what each other is doing. It
> > > requires a separate communication channel to talk; Pratik & I used
> > > IRC, but I think Google Hangout (or Skype or WhatsApp or
> > > <insert-your-favorite-chat-here>) would have worked a bit better. It's
> > > kind of pair programming, but with some of the limitations removed.
> > 
> > OK, I said in my earlier email that I would give any scheme a try, but I
> > really don't like pair programming. ;)
> 
> Tastes do differ, and that's okay.
> 
> I found it pretty invaluable a tool for intense 1:1 mentoring. It
> definitely helps a lot with getting over the initial hurdles.

Actually, I would agree that mentoring is probably one of the best uses
for pairing like that. In retrospect, I think we should have done more
real-time collaboration during Outreachy last winter.  It's still not my
taste, but I think we could have accomplished more overall.

Not that I need to convince you, but just seconding your advice for the
benefit of people who are thinking about mentoring in the future.

-Peff
