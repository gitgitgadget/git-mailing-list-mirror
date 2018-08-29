Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E7191F404
	for <e@80x24.org>; Wed, 29 Aug 2018 04:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbeH2Iuw (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 04:50:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:60138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725199AbeH2Iuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 04:50:52 -0400
Received: (qmail 14614 invoked by uid 109); 29 Aug 2018 04:55:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 04:55:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10016 invoked by uid 111); 29 Aug 2018 04:55:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 00:55:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 00:55:48 -0400
Date:   Wed, 29 Aug 2018 00:55:48 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Contributor Summit planning
Message-ID: <20180829045548.GB15274@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808271523180.73@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808271523180.73@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 03:34:16PM +0200, Johannes Schindelin wrote:

> >   - format
> > 
> >     For those who haven't attended before, it's basically 25-ish Git
> >     (and associated project) developers sitting in a room for a day
> >     chatting about the project. Topics go on a whiteboard in the
> >     morning, and then we discuss each for 30-60 minutes.
> > 
> >     We could do multiple days (which might give more room for actually
> >     working collaboratively instead of just discussing). We could do
> >     something more formal (like actual talks). We could do something
> >     less formal (like an all-day spaghetti buffet, where conversation
> >     happens only between mouthfuls). The sky is the limit. Some of those
> >     ideas may be better than others.
> 
> I found the unconference-style, one day meeting to be most productive.
> 
> As to more formal? I don't know... talks seem to be fun and all, but they
> require a lot of preparation. Something championed in our standups are
> "chalk talks", i.e. somebody presenting in a bit more detail what they are
> working on, in particular explaining the context (think: Stolee
> enlightening the audience about finer points of computational graph
> theory) *without* preparing for it specifically. That makes for fun
> presentations, if a bit more chaotic than a real "conference talk". This
> format obviously lends itself to Google Hangouts.
> 
> As to multiple days: Of course it would be nice to have a kind of a "hack
> day", but I wonder how productive this would be in the context of Git,
> where interests very so widely.

Thanks for your input. For what it's worth, that largely matches my
opinion, too. Most of the ideas I threw out there were just trying to
stimulate discussion (except for the spaghetti buffet, for which I am
a true believer).

> Rather than have a "hack day", I would actually prefer to work with other
> contributors in a way that we have not done before, but which I had the
> pleasure of "test ballooning" with Pratik: using Visual Studio Code Live
> Share. This allows multiple users to work on the same code base, in the
> same worktree, seeing what each other is doing. It requires a separate
> communication channel to talk; Pratik & I used IRC, but I think Google
> Hangout (or Skype or WhatsApp or <insert-your-favorite-chat-here>) would
> have worked a bit better. It's kind of pair programming, but with some of
> the limitations removed.

OK, I said in my earlier email that I would give any scheme a try, but I
really don't like pair programming. ;)

-Peff
