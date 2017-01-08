Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62D220756
	for <e@80x24.org>; Sun,  8 Jan 2017 03:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934270AbdAHD1O (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 22:27:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:36557 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932382AbdAHD1M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 22:27:12 -0500
Received: (qmail 29219 invoked by uid 109); 8 Jan 2017 03:27:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 08 Jan 2017 03:27:12 +0000
Received: (qmail 28392 invoked by uid 111); 8 Jan 2017 03:28:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 22:28:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Jan 2017 22:27:09 -0500
Date:   Sat, 7 Jan 2017 22:27:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by
 `asciidoctor`
Message-ID: <20170108032709.k43zmej5lxmcoj4o@sigill.intra.peff.net>
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
 <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
 <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
 <xmqqbmvi34ul.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmvi34ul.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 07, 2017 at 02:03:30PM -0800, Junio C Hamano wrote:

> Is that a longer way to say that the claim "... is designed as a
> book" is false?
> 
> > So I dunno. I really do think "article" is conceptually the most
> > appropriate style, but I agree that there are some book-like things
> > (like appendices).
> 
> ... Yeah, I should have read forward first before starting to insert
> my comments.

To be honest, I'm not sure whether "book" versus "article" was really
considered in the original writing. I think we can call it whichever
produces the output we find most pleasing. I was mostly just pointing at
there are some tradeoffs in the end result in flipping the type.

-Peff
