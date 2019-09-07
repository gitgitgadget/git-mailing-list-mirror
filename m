Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79C51F461
	for <e@80x24.org>; Sat,  7 Sep 2019 06:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406492AbfIGGkA (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 02:40:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:42802 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727670AbfIGGkA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 02:40:00 -0400
Received: (qmail 28393 invoked by uid 109); 7 Sep 2019 06:39:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Sep 2019 06:39:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9870 invoked by uid 111); 7 Sep 2019 06:41:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Sep 2019 02:41:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Sep 2019 02:39:59 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190907063958.GB28860@sigill.intra.peff.net>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190904194114.GA31398@sigill.intra.peff.net>
 <20190905193959.GA17913@google.com>
 <CAPUEspgyLHSwLBn2EkFyfxuU9KTx+CURTvjmenz2edw-htRxBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspgyLHSwLBn2EkFyfxuU9KTx+CURTvjmenz2edw-htRxBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 04:55:46AM -0700, Carlo Arenas wrote:

> I'm interested to mentor/help too, but I am definitely not a (some
> people would even argue against "reliable") contributor but I might be
> better than nothing and could pass my "lessons learned" along, so
> hopefully next contributors are less of a pain to deal with than I am

I just wrote a response to Emily, but I think a lot of it applies to
you, as well.

In particular, I think both of you are a bit newer to the project than
most of the other people who have mentored in the past. In some ways
that may be a good thing, as it likely makes it easier to see things
from the intern's perspective. :) But it may also introduce some
complications if you're working in an area of the code you're not
familiar with. Co-mentoring may help with that.

-Peff
