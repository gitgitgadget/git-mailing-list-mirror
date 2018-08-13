Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8C21F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbeHMT6n (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:58:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:52992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729070AbeHMT6n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:58:43 -0400
Received: (qmail 7712 invoked by uid 109); 13 Aug 2018 17:15:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Aug 2018 17:15:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9863 invoked by uid 111); 13 Aug 2018 17:15:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 13:15:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 13:15:36 -0400
Date:   Mon, 13 Aug 2018 13:15:36 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Contributor Summit planning
Message-ID: <20180813171535.GA8476@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <d5d3fe71-d52b-ac9b-d48d-d288b6569e5a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5d3fe71-d52b-ac9b-d48d-d288b6569e5a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 12:58:54PM -0400, Derrick Stolee wrote:

> I would be up for two meetings a year. I would expect that the variety of
> locations would allow a larger set of contributors to make at least one
> meeting a year. This may come at a cost of a smaller group in each summit.

Yeah, I do worry about it splitting the attendance. It could also be a
thing we do _this_ year (if we care about having something in North
America), and then try to make different plans in a future year.

> The one thing I found missing that could be good is to have a remote option.
> Not everyone can travel or can afford to do so. I wonder if a simple Google
> Hangout could allow more participation from the community, even in a passive
> sense (those still at their day jobs listening in). It could even facilitate
> remote presenters, if applicable.

One year we had Dscho remote on a laptop sitting on a stool. I'm not
sure how great that was for him. ;)

I agree it would be nice to include remote people, but I think it would
be very important to have a good A/V setup. Passive involvement is not
too hard, but I would love a setup where they could actually participate
in discussions. I've seen that work in 5-10 people conferences, but I'm
not sure how well even good A/V scales to 20-30.

One other thought on remote folks: IMHO one of the most valuable things
about these kinds of events (especially the first ones I attended) is
the informal interactions. The hallway talks and meals provide a venue
for spontaneous conversation, but they also just help us understand in a
visceral way that the people on the other end of our emails are actual
humans. Which I think can help smooth subsequent online interactions.
I'm not sure how much of that can be gained remotely.

(I don't think that's an argument against remote inclusion, just an
opinion that we should continue to encourage in-person interaction).

-Peff
