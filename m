Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D34DE1F42E
	for <e@80x24.org>; Mon,  7 May 2018 06:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbeEGGhQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 02:37:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:58352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750732AbeEGGhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 02:37:16 -0400
Received: (qmail 27920 invoked by uid 109); 7 May 2018 06:37:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 May 2018 06:37:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23822 invoked by uid 111); 7 May 2018 06:37:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 May 2018 02:37:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2018 02:37:14 -0400
Date:   Mon, 7 May 2018 02:37:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: main url for linking to git source?
Message-ID: <20180507063713.GA28961@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-scm.com site currently links to https://github.com/git/git for
the (non-tarball) source code. Somebody raised the question[1] of
whether it should point to kernel.org instead. Do people find one
interface more or less pleasing than the other? Do we want to prefer
kernel.org as more "official" or less commercial?

I could see arguments both ways, so I thought I'd take a straw poll of
what people on the list think.

-Peff

[1] https://github.com/git/git-scm.com/pull/1202
