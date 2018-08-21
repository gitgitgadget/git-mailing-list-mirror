Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25CC21F954
	for <e@80x24.org>; Tue, 21 Aug 2018 02:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeHUF0y (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 01:26:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:50006 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725731AbeHUF0y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 01:26:54 -0400
Received: (qmail 32299 invoked by uid 109); 21 Aug 2018 02:08:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 02:08:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12747 invoked by uid 111); 21 Aug 2018 02:08:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 Aug 2018 22:08:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2018 22:08:49 -0400
Date:   Mon, 20 Aug 2018 22:08:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Git Project Leadership Committee
Message-ID: <20180821020849.GA2527@sigill.intra.peff.net>
References: <20180816224138.GA15490@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816224138.GA15490@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 06:41:38PM -0400, Jeff King wrote:

>  - we should avoid anyone who is affiliated with a company that already
>    has a member on the committee. So nobody from Google and nobody from
>    GitHub. I would extend that to Microsoft, too, given a certain
>    impending acquisition. I'd expect anybody who is affiliated with a
>    company to recuse themselves from decisions that directly affect that
>    company (which is what we've done so far).
> 
>  - I think ideally the candidate would be somebody who represents the
>    long tail of volunteer community members who don't work on Git as
>    part of their day-job. The current members have a fairly skewed view
>    in that respect. At the same time, we can't really represent the
>    _really_ long tail of infrequent contributors, by the "stick around"
>    criterion above.

Thanks both Christian and Ævar for giving more details on your
situations elsewhere in the thread. I do think neither of you is quite
in the "I just do this in my spare time" situation. But I also think
that situation is going to be inversely correlated with being active in
the project and wanting to spend time on governance stuff. So IMHO some
compromise there is necessary. And I feel like both of you can represent
those interests, even if they're not exactly the situation you're in.

So what next?

There was a little bit of off-list discussion (mostly nominations to
avoid putting the candidate on the spot), but no new public candidates.
I'm happy to entertain more discussion here, but it seems like everybody
is reasonably happy with these two names.

So either Junio and I can pick one, or possibly we could have both (that
gives us a 4-person committee, but again, tied votes haven't been an
issue so far).

Any final thoughts are welcome.

Also, on a more meta-level, I'm happy to hear any thoughts about this
process that we might want to enshrine for later iterations. This is
obviously not nearly as formal as something like Debian elections. But I
don't think we're a big enough community to need that. So my attempt is
to just keep things informal, but try to give as many opportunities as
possible for people to speak up.

-Peff
