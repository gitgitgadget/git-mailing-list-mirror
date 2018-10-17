Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28ABF1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 19:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeJRDW4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 23:22:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:43856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727128AbeJRDW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 23:22:56 -0400
Received: (qmail 10312 invoked by uid 109); 17 Oct 2018 19:25:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 19:25:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23112 invoked by uid 111); 17 Oct 2018 19:24:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 15:24:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 15:25:46 -0400
Date:   Wed, 17 Oct 2018 15:25:46 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Sort output of diff --stat?
Message-ID: <20181017192546.GA31563@sigill.intra.peff.net>
References: <CAHd499BSVRytaFKOUhE=A4Zv+MMx=uKrWKUcT13QwzOCZWhEtg@mail.gmail.com>
 <20181017184720.GF28326@sigill.intra.peff.net>
 <CAHd499Ci-DTtv=zKBY-9N60qS9TxerckHNzkOkeiZmUp4jDq_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499Ci-DTtv=zKBY-9N60qS9TxerckHNzkOkeiZmUp4jDq_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 02:21:57PM -0500, Robert Dailey wrote:

> On Wed, Oct 17, 2018 at 1:47 PM Jeff King <peff@peff.net> wrote:
> > Hmm, I feel like another person asked for this recently, but I can't
> > seem to find the thread.
> 
> Is it this one?
> https://www.mail-archive.com/git@vger.kernel.org/msg159212.html
> 
> That's the only one I was able to find, but no one replied. Thanks for
> your insight. I didn't get my hopes up, but maybe someday it'll be
> added.

Ah, yeah, that's the one. For some reason I thought I had replied, but
obviously I did not. ;)

-Peff
