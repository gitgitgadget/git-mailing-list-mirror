Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC391F461
	for <e@80x24.org>; Sat,  7 Sep 2019 06:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406491AbfIGGgS (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 02:36:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:42786 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1733303AbfIGGgS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 02:36:18 -0400
Received: (qmail 28209 invoked by uid 109); 7 Sep 2019 06:36:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Sep 2019 06:36:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9846 invoked by uid 111); 7 Sep 2019 06:38:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Sep 2019 02:38:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Sep 2019 02:36:16 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190907063616.GA28860@sigill.intra.peff.net>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190904194114.GA31398@sigill.intra.peff.net>
 <20190905193959.GA17913@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905193959.GA17913@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 12:39:59PM -0700, Emily Shaffer wrote:

> > Funding is still up in the air, but in the meantime I've tentatively
> > signed us up (we have until the 24th to have the funding committed).
> > Next we need mentors to submit projects, as well as first-time
> > contribution micro-projects.
> 
> I'm interested to mentor too, but I haven't done anything like this -
> official mentoring, intern hosting, anything - so I will need to learn
> :)

Great! I think a big challenge is coming up with an appropriately scoped
project for the intern. You can take a look at previous Outreachy and
GSoC proposals[1] to get the general idea, and then think about some
area you feel comfortable working in. You're welcome to send ideas or
drafts to the list to get feedback.

If you're feeling overwhelmed (or even if you're not), it might make
sense to try to partner with somebody else as a co-mentor, especially if
they've participated in the past. (It might also be that you can offer
to co-mentor with somebody else's project proposal).

-Peff

[1] Older materials can be found at https://git.github.io/, though
    these days the proposed projects go directly into the Outreachy
    system.
