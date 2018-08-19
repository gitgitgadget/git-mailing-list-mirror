Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2031F954
	for <e@80x24.org>; Sun, 19 Aug 2018 04:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbeHSHZQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 03:25:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:60182 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725919AbeHSHZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 03:25:16 -0400
Received: (qmail 10136 invoked by uid 109); 19 Aug 2018 04:08:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 19 Aug 2018 04:08:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4722 invoked by uid 111); 19 Aug 2018 04:08:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 19 Aug 2018 00:08:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Aug 2018 00:08:27 -0400
Date:   Sun, 19 Aug 2018 00:08:27 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Subject: Re: Git Project Leadership Committee
Message-ID: <20180819040827.GA31797@sigill.intra.peff.net>
References: <20180816224138.GA15490@sigill.intra.peff.net>
 <CABPp-BGq7rw6YfyxGJbhcGeeVONTSkAzE7h8CiVNx_AA-veUgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGq7rw6YfyxGJbhcGeeVONTSkAzE7h8CiVNx_AA-veUgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 18, 2018 at 07:32:38PM -0700, Elijah Newren wrote:

> On Thu, Aug 16, 2018 at 3:43 PM Jeff King <peff@peff.net> wrote:
> >  - we should avoid anyone who is affiliated with a company that already
> >    has a member on the committee. So nobody from Google and nobody from
> >    GitHub. I would extend that to Microsoft, too, given a certain
> >    impending acquisition. I'd expect anybody who is affiliated with a
> >    company to recuse themselves from decisions that directly affect that
> >    company (which is what we've done so far).
> 
> That might make it hard for some of us to nominate others, since as
> far as I can tell (e.g. looking at shortlog -sne output) few git
> contributors use work email addresses to do so and we don't
> necessarily know employers of other contributors.

I would say to err on the side of nominating, and the candidate can
provide the information.

-Peff
