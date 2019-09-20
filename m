Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26B01F463
	for <e@80x24.org>; Fri, 20 Sep 2019 02:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405310AbfITCXI (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 22:23:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:55402 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2404323AbfITCXH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 22:23:07 -0400
Received: (qmail 12798 invoked by uid 109); 20 Sep 2019 02:23:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Sep 2019 02:23:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5773 invoked by uid 111); 20 Sep 2019 02:25:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Sep 2019 22:25:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Sep 2019 22:23:06 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20190920022306.GA27520@sigill.intra.peff.net>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <20190919221615.GA25636@sigill.intra.peff.net>
 <d13a8d01-065b-bfff-d279-c57cd0c0f7c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d13a8d01-065b-bfff-d279-c57cd0c0f7c9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 10:17:57PM -0400, Derrick Stolee wrote:

> > I.e., I think we want to grow the community a bit more organically,
> > which should be more sustainable in the long run.>
> > So I think any advertising would be more about making it clear that _if_
> > you have an idea, we're very interested in welcoming newcomers. And that
> > to me falls under a lot of the points already made above: making the
> > process more clear and more inviting to people who are already thinking
> > about contributing.
> 
> I guess I was vague about this. It's not "we need more people to work on
> our (non-existent) backlog" but instead "if you have an interest in
> contributing your (existing) ideas to Git, we welcome you with open arms!"

Yeah, _that_ I'm totally on board with. Thanks again for kicking off
this discussion.

-Peff
