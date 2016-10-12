Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304FB207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 16:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754955AbcJLQj3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 12:39:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:56539 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754925AbcJLQj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 12:39:28 -0400
Received: (qmail 13488 invoked by uid 109); 12 Oct 2016 16:32:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 16:32:47 +0000
Received: (qmail 22226 invoked by uid 111); 12 Oct 2016 16:33:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 12:33:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2016 12:32:45 -0400
Date:   Wed, 12 Oct 2016 12:32:45 -0400
From:   Jeff King <peff@peff.net>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t1512: become resilient to GETTEXT_POISON build
Message-ID: <20161012163245.plr7soltuephf7ul@sigill.intra.peff.net>
References: <20161012122533.32223-1-vascomalmeida@sapo.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161012122533.32223-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 12:25:33PM +0000, Vasco Almeida wrote:

> The concerned message was marked for translation by 0c99171
> ("get_short_sha1: mark ambiguity error for translation", 2016-09-26).

Thanks, this looks obviously correct.

-Peff
