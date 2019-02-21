Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD841F453
	for <e@80x24.org>; Thu, 21 Feb 2019 04:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfBUE7H (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 23:59:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:51884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725837AbfBUE7G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 23:59:06 -0500
Received: (qmail 14912 invoked by uid 109); 21 Feb 2019 04:59:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 04:59:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8258 invoked by uid 111); 21 Feb 2019 04:59:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Feb 2019 23:59:19 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2019 23:59:04 -0500
Date:   Wed, 20 Feb 2019 23:59:04 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@vger.kernel.org
Subject: Re: Git Merge Conference Recordings [was: Re: [ANNOUNCE] Git Merge
 Contributor's Summit Jan 31, 2019, Brussels]
Message-ID: <20190221045904.GA29732@sigill.intra.peff.net>
References: <20181109104202.GA8717@sigill.intra.peff.net>
 <2139295744.18413.1550666884748@ox.hosteurope.de>
 <87ef82628j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ef82628j.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 02:03:40PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I wanted to point a colleague of mine to one of the talks.
> > Unfortunately I could not find the recordings of the talks anywhere.
> >
> > Are these available?
> 
> I have no insider knowledge, but can tell you that in past years it's
> taken GitHub a bit to process these and put them on YouTube[1].
> 
> E.g. last year's conference was in early March, and the videos trickled
> in in late-March to early April, the year before that it was in February
> and the videos were published in May of that year.
> 
> Historically the 3-4 month delay has been more of the norm than 1-2.

I think they're shooting to have them out sometime in March, but I've
asked if they have a more specific ETA.

> So subscribe to their channel on YouTube, it'll be uploaded sometime
> soon-ish.
> 
> 1. https://www.youtube.com/user/github/videos

This advice is pretty good, though. :)

-Peff

PS I have audio and video from the contributor summit. It could use some
   editing to remove muted spots (from breaks where we shut off the mics
   but not the recording). I haven't really considered it a priority,
   but if somebody is anxiously awaiting it, I can try to at least do a
   rough cut.
