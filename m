Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED641F463
	for <e@80x24.org>; Fri, 27 Sep 2019 04:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfI0EnG (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 00:43:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:33640 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725996AbfI0EnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 00:43:06 -0400
Received: (qmail 25233 invoked by uid 109); 27 Sep 2019 04:43:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Sep 2019 04:43:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6298 invoked by uid 111); 27 Sep 2019 04:45:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Sep 2019 00:45:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Sep 2019 00:43:04 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Number of Outreachy interns and co-mentors
Message-ID: <20190927044304.GA24011@sigill.intra.peff.net>
References: <CAP8UFD0gQU4JKneKc6HLxT6NutzZrxDVqWKDSeOx1ZYDfMkWRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0gQU4JKneKc6HLxT6NutzZrxDVqWKDSeOx1ZYDfMkWRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 03:12:15PM +0200, Christian Couder wrote:

> On https://www.outreachy.org/apply/project-selection/#git it looks
> like we will only have 1 intern as the title of our section is "Git -
> 1 intern". I wonder if it's because only funding for 1 intern has been
> secured or if there is another reason.

Right, it's because of the funding promise.

> Also I am not sure how people can register that they are ok to
> co-mentor one of the project, but it looks like the person who
> registered a project can invite co-mentors. So I think it would be
> nice if people, who would be ok to co-mentor, could tell which
> projects they would be ok to co-mentor, so that we all know and that
> they can be invited to co-mentor on the site.
> 
> It would be great if we could have 2 (co-)mentors per project and it
> would likely help getting funding for all the interns.

Yeah, I agree it would be nice to have that in the system if there's
going to be co-mentoring. I don't know how the interface for it works,
though (and I think the mentors see different screens than I do).

-Peff
