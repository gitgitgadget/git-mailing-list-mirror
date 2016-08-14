Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA3CE1FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 13:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbcHNNBQ (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 09:01:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:55025 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752112AbcHNNBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 09:01:15 -0400
Received: (qmail 30794 invoked by uid 109); 14 Aug 2016 13:01:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Aug 2016 13:01:14 +0000
Received: (qmail 8231 invoked by uid 111); 14 Aug 2016 13:01:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 Aug 2016 09:01:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Aug 2016 09:01:12 -0400
Date:	Sun, 14 Aug 2016 09:01:12 -0400
From:	Jeff King <peff@peff.net>
To:	Jonas Fonseca <jonas.fonseca@gmail.com>
Cc:	Git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] tig-2.2
Message-ID: <20160814130112.bgoetwhxyb5w3dl3@sigill.intra.peff.net>
References: <CAFuPQ1+i6BFRH=6HUWzDgM7J+hL_3hUNv5-4mjjGm=h-YWVuzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFuPQ1+i6BFRH=6HUWzDgM7J+hL_3hUNv5-4mjjGm=h-YWVuzg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 11:23:56PM -0400, Jonas Fonseca wrote:

> It's crazy to think that Tig has happily browsed Git repos for more than 10
> years! Thanks to everybody who contributed and made that possible. Looking
> forward to the next 10 years ...

Thanks for all your work on tig. I have tried quite a few git-related
tools over the past 10 years, and tig is the only one outside of git.git
that I still use.

If anybody has not tried tig's blame view, and especially "re-blame from
parent" (bound to "," by default), they are missing out. I use it all
the time for digging up the rationale of confusing code.

-Peff
