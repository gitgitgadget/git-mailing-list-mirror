Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD0B1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 04:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeH2Irl (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 04:47:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:60126 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727098AbeH2Irk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 04:47:40 -0400
Received: (qmail 14463 invoked by uid 109); 29 Aug 2018 04:52:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 04:52:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9998 invoked by uid 111); 29 Aug 2018 04:52:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 00:52:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 00:52:37 -0400
Date:   Wed, 29 Aug 2018 00:52:37 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: Contributor Summit planning
Message-ID: <20180829045237.GA15274@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <d5d3fe71-d52b-ac9b-d48d-d288b6569e5a@gmail.com>
 <20180813171535.GA8476@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808271458450.73@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808271458450.73@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 03:22:39PM +0200, Johannes Schindelin wrote:

> Having said that, I believe that we core contributors can learn to have a
> fruitful online meeting. With 30+ participants, too.
> 
> Learning from my past life in academia (it is hard for me to imagine a
> less disciplined crowd than a bunch of white, male, old scientists), we
> would need a moderator, and some forum that allows to "give somebody the
> mic". That software/platform should exist somewhere.

Yes, I agree that software tools could help a lot with a crowd that
size. I have used various "virtual classroom" tools before, and I think
the core of the idea is there, but I was often unimpressed by the
execution (and expense). So if you know of a good tool, it might be
worth trying.

> I would love to have the best of both worlds. For example, it is an annual
> annoyance that we are discussion all kinds of things regarding Git, trying
> to steer the direction, to form collaborations on certain features, and
> the person at the helm is not even there.
> 
> Maybe *two* meetings per year, one attached to GitMerge, and one purely
> online, would help.

I'm somewhat skeptical of the utility of an online meeting. That said,
I'm willing give it a try (or any other scheme people want to come up
with, for that matter).

> Point in favor of the pure-online meeting: the informal standup on IRC
> every second Friday. I really try to attend it (it is a bit awkward
> because it is on a Friday evening in my timezone, right at the time when I
> want to unwind from the work week), as it does have a similar effect to
> in-person standups: surprising collaborations spring up, unexpected help,
> and a general sense of belonging.

Yes, I've been meaning to make it to another one (I popped in for one a
month or two ago, and it didn't seem like much of anything was
happening).

What time is it, again?

> Such an online summit as I suggested above would really only work if
> enough frequent contributors would attend. If enough people like you,
> Junio, and the standup regulars would say: yep, we're willing to plan and
> attend an online summit, where we try to have a timezone-friendly
> "unconference"-style meeting on one day (on which we would of course try
> to free ourselves from our regular work obligations).
> 
> I guess I am asking for a "raise your hands", with mine high up in the
> air.

I'll come if you want to organize it.

-Peff
