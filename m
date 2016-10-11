Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1895B20989
	for <e@80x24.org>; Tue, 11 Oct 2016 04:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbcJKEpV (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 00:45:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:55582 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750764AbcJKEpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 00:45:20 -0400
Received: (qmail 13366 invoked by uid 109); 11 Oct 2016 04:45:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 04:45:20 +0000
Received: (qmail 5188 invoked by uid 111); 11 Oct 2016 04:45:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 00:45:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2016 00:45:18 -0400
Date:   Tue, 11 Oct 2016 00:45:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Tom Hale <tom@hale.ee>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] pretty: fix document link for color specification
Message-ID: <20161011044518.6s2mtd6pvoiwgz37@sigill.intra.peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
 <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
 <6689ae49-6095-7bb4-ea06-1aaded174811@web.de>
 <20161010205521.vxpwjrlelig3ilpe@sigill.intra.peff.net>
 <e0d64654-1562-2e71-8d42-3fc549a98d12@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0d64654-1562-2e71-8d42-3fc549a98d12@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 05:41:14AM +0200, René Scharfe wrote:

> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Removed confusing and unnecessary reference to the "colors" paragraph.

This looks good to me.

-Peff
