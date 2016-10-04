Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2559C20986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbcJDVtS (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:49:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:52448 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751745AbcJDVtR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:49:17 -0400
Received: (qmail 22738 invoked by uid 109); 4 Oct 2016 21:49:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 21:49:17 +0000
Received: (qmail 11111 invoked by uid 111); 4 Oct 2016 21:49:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 17:49:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 17:49:14 -0400
Date:   Tue, 4 Oct 2016 17:49:14 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
Message-ID: <20161004214914.kgkot337awszhojs@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net>
 <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
 <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net>
 <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
 <20161004204933.ygfhoy24g6psyf6h@sigill.intra.peff.net>
 <CA+P7+xo3nxy1EOjDqHvKQuK128c=b73XN=6qqn6g6oRGh2VdFg@mail.gmail.com>
 <20161004205510.6bhisw7ixbgcvvwn@sigill.intra.peff.net>
 <CA+P7+xoDz2sOPrDrJhAhrqDQsRR8NVU-8kh6+G=8FJeXEJ1dtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xoDz2sOPrDrJhAhrqDQsRR8NVU-8kh6+G=8FJeXEJ1dtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 02:43:24PM -0700, Jacob Keller wrote:

> > Hmm. Now I am puzzled, because I _did_ line up them specifically to make
> > this clear. I put the numbers under the ">" of the arrow. Did I screw up
> > the spacing somehow so that isn't how they look to you? Or are you just
> > saying you would prefer them under the "-" of the arrow?
>
> I bet they line up in a monospace font and I just happened to be
> viewing this from GMail which isn't showing it in monospace and so it
> doesn't line up. Ignore me and carry on

Oh, good. I was wondering if I was going crazy. :)

-Peff
