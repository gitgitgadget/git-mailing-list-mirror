Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C69D1F859
	for <e@80x24.org>; Tue, 23 Aug 2016 04:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbcHWEM5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 00:12:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:59435 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751401AbcHWEM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 00:12:56 -0400
Received: (qmail 19642 invoked by uid 109); 23 Aug 2016 04:12:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Aug 2016 04:12:56 +0000
Received: (qmail 20909 invoked by uid 111); 23 Aug 2016 04:12:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Aug 2016 00:12:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Aug 2016 00:12:52 -0400
Date:   Tue, 23 Aug 2016 00:12:52 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH] diff-highlight: add some tests.
Message-ID: <20160823041252.53ldwacgdey2euxt@sigill.intra.peff.net>
References: <xmqqeg5kz8zq.fsf@gitster.mtv.corp.google.com>
 <20160822155539.25350-1-henderson.bj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822155539.25350-1-henderson.bj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 08:55:39AM -0700, Brian Henderson wrote:

> Jeff, I love your idea. how's this looking?

Much more readable, IMHO.

-Peff
