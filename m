Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4F01FBB0
	for <e@80x24.org>; Fri,  2 Dec 2016 00:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757434AbcLBAS6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 19:18:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:50429 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757399AbcLBASz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 19:18:55 -0500
Received: (qmail 28827 invoked by uid 109); 2 Dec 2016 00:18:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Dec 2016 00:18:55 +0000
Received: (qmail 6942 invoked by uid 111); 2 Dec 2016 00:19:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 19:19:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 19:18:52 -0500
Date:   Thu, 1 Dec 2016 19:18:52 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/6] http: always update the base URL for redirects
Message-ID: <20161202001852.arasy44d6iczeeez@sigill.intra.peff.net>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
 <20161201090414.zgz7pimgpctghbwu@sigill.intra.peff.net>
 <331124b5-aa2b-773c-23ac-975ad3f50dbf@ramsayjones.plus.com>
 <20161201225331.GH54082@google.com>
 <2297C36B9A1441748D7E68363A05F8C5@PhilipOakley>
 <xmqq8trz6wrq.fsf@gitster.mtv.corp.google.com>
 <7cd35131-2e0c-0dff-8864-c099e313251d@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cd35131-2e0c-0dff-8864-c099e313251d@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 12:07:50AM +0000, Ramsay Jones wrote:

> >> In a British context "Mallory and Irvine" were two (male) climbers who
> >> died on Everest in 1924 (tales of daring...), so it's easy to expect
> >> (from this side of the pond) that 'Mallory' would be male. However he
> >> was really George Mallory.
> >>
> >> Meanwhile that search engine's images shows far more female Mallorys,
> >> so I've learnt something.
> > 
> > "baby name Mallory" in search engine gave me several sites, most of
> > them telling me that is a girl's name except for one.
> > 
> > Didn't think of doing image search, but that's a good way ;-)
> 
> Heh, I didn't think about any of this. I was remembering the
> description of 'Man-in-the-middle Attack' from Applied Cryptography
> (Bruce Schneier) which implies that Mallory is male.

I admit that I always assumed Applied Cryptography (and other papers)
were always talking about a female. But that's probably because I
started with an assumption about the name in the first place. That
probably came from watching the Family Ties sitcom as a kid; the older
daughter is named Mallory (and if you google it, you can see some
amazing 80's haircuts and clothes).

We can call her Marsha if you want, instead evoking Brady Bunch memories
of 60's clothing and haircuts.

-Peff
