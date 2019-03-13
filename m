Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9BE20248
	for <e@80x24.org>; Wed, 13 Mar 2019 19:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfCMTkz (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 15:40:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:49434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726396AbfCMTkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 15:40:55 -0400
Received: (qmail 21184 invoked by uid 109); 13 Mar 2019 19:40:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Mar 2019 19:40:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15184 invoked by uid 111); 13 Mar 2019 19:39:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 15:39:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 15:39:38 -0400
Date:   Wed, 13 Mar 2019 15:39:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
Message-ID: <20190313193937.GC3400@sigill.intra.peff.net>
References: <20190312213246.GA6252@sigill.intra.peff.net>
 <xmqqef7bfrxv.fsf@gitster-ct.c.googlers.com>
 <xmqq1s3bfrf2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1s3bfrf2.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 11:18:25AM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> -Nevertheless, you can use [submitGit](http://submitgit.herokuapp.com/) to
> >> +Nevertheless, you can use [Git Git Gadget](https://gitgitgadget.github.io/) to
> >
> > The pointed-at page calls the tool a single word with three capital
> > Gs without SP in it.  We should match it here and in the other
> > document.
> 
> For now, here is what I have locally.  Again, thanks all.

Yep, that makes sense. What you have queued looks good to me.

-Peff
