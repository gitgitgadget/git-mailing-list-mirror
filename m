Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9E31F4DD
	for <e@80x24.org>; Tue,  5 Sep 2017 11:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbdIELkv (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 07:40:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:57090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751305AbdIELkv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 07:40:51 -0400
Received: (qmail 29060 invoked by uid 109); 5 Sep 2017 11:40:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 11:40:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11973 invoked by uid 111); 5 Sep 2017 11:41:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 07:41:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 07:40:43 -0400
Date:   Tue, 5 Sep 2017 07:40:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Git in Outreachy round 15?
Message-ID: <20170905114043.dkjczpioxvu7biw6@sigill.intra.peff.net>
References: <20170901223059.xsbcpqff45mnblnj@sigill.intra.peff.net>
 <xmqqk21ddgz7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk21ddgz7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 11:19:56AM +0900, Junio C Hamano wrote:

> $6,500 is a bargain if we could guide an intern and help set the
> course to become a competent open source person.  It would be nice
> if the intern stays in our community, but I do not even mind if the
> investment follows the intern elsewhere and enrich other open source
> projects.

Agreed on all counts. I am still dotting i's and crossing t's, but I am
pretty sure I have outside funding lined up anyway, though.

> It is a different matter if our mentor pool is rich enough to give
> sufficient support and training to the intern, but if you are
> volunteering to mentor, I wouldn't have any worries.  I do agree
> with you that it would be a good idea to polish the project-ideas
> page.

We actually need to put together a "landing page". The guidelines are
at:

  https://www.outreachy.org/mentor/landing-page-requirements/

Timing-wise, the application period opens this Thursday. So I'll plan to
work on it over the next day or two, but I'd appreciate any help that
others can provide (even if I end up as the only available mentor).

-Peff
