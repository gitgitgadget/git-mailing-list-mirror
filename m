Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A73120248
	for <e@80x24.org>; Fri, 15 Mar 2019 03:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCODjC (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 23:39:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:51900 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726708AbfCODjB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 23:39:01 -0400
Received: (qmail 14755 invoked by uid 109); 15 Mar 2019 03:39:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 03:39:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28708 invoked by uid 111); 15 Mar 2019 03:38:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Mar 2019 23:38:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2019 23:38:14 -0400
Date:   Thu, 14 Mar 2019 23:38:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: straw poll: git merge conference location
Message-ID: <20190315033814.GF28943@sigill.intra.peff.net>
References: <20190313205539.GA30425@sigill.intra.peff.net>
 <87bm2db3ku.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bm2db3ku.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 09:31:29PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > There's also been discussion about doing something (possibly in North
> > America) in the summer or fall of this year, but as far as I know there
> > hasn't been any planning so far.
> 
> This is going off-topic, but I'd be curious if splitting it up from Git
> Merge in general is an option. Presumably the hypothetical event this
> summer could be an experiment for that.

Yeah, it could be, if somebody wants to organize it. There was some
discussion on the list, I think, and a little bit in Brussels this year,
but I don't know of any concrete plans so far.

I had some vague discussion with GitHub events folks about it, and I
think Terry from Google showed some interest in possibly hosting.  I
think anything like that would probably be in the Bay Area, since it
would be easy for either entity to provide meeting space they already
own.

And that sort of gets to the crux of why it's attached to Git Merge. We
are piggy-backing on all of the work that goes into handling the venue,
etc, for that conference. I think it's really not much work on top of
the conference, but doing it standalone in a random city would actually
involve somebody doing some logistics legwork.

That said, I don't know that we need much. A big-ish conference room in
a hotel would be enough (though we were pushing 40 people this time!).
We don't really need a registration system, since we're small enough
that everybody knows everyone (or will know them by the end of the day).

> We'd just need something close to an international airport with
> acceptable accommodation space for max 30-40 people. This'll also help
> people who need to fly into NA stay under their respective travel
> budgets, hotels in NYC or SF are going to cost a lot more than in some
> small town outside a big airport. Something with more nature than
> concrete would be nice.

It's very scenic in my part of Virginia in the fall. :)

> But really, is Git Merge going to change its location on our whims? I
> didn't realize we were that important :)

Well, no. But it's one of many inputs to the process.

> Maybe we can compromise on this whole ongoing NA v.s. Europe debate and
> meet in Iceland :)

Iceland Air is always trying to sell me that "Reykjavik stopover"...

> In Brussels I suggested in jest that we hold it in Junio's back
> yard. The part that I'm serious about is that to the extent I have a
> location preference it's that we warp it towards core contributors who
> haven't been coming to these things, but otherwise would if the location
> was different (no idea if that's the case in Junio's case...).

It's possible that one of my ulterior motives was trying to get Junio
to speak up. :)

-Peff
