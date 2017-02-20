Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A2A1201A8
	for <e@80x24.org>; Mon, 20 Feb 2017 00:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbdBTArY (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 19:47:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:58539 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752009AbdBTArX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 19:47:23 -0500
Received: (qmail 9011 invoked by uid 109); 20 Feb 2017 00:47:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 00:47:20 +0000
Received: (qmail 26254 invoked by uid 111); 20 Feb 2017 00:47:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Feb 2017 19:47:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Feb 2017 19:47:17 -0500
Date:   Sun, 19 Feb 2017 19:47:17 -0500
From:   Jeff King <peff@peff.net>
To:     Damien Regad <dregad@mantisbt.org>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] git-check-ref-format: clarify man for --normalize
Message-ID: <20170220004717.7nqwk62vnuqv2rbb@sigill.intra.peff.net>
References: <44113ef6-5669-5e02-f848-27c17fac55e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44113ef6-5669-5e02-f848-27c17fac55e5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 19, 2017 at 11:32:32PM +0100, Damien Regad wrote:

> Use of 'iff' may be confusing to people not familiar with this term.
> 
> Improving the --normalize option's documentation to remove the use of
> 'iff', and clearly describe what happens when the condition is not met.

Looks good to me. Thanks for following up.

-Peff
