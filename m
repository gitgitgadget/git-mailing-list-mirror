Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 374DD1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 04:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfKFEGt (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 23:06:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:40114 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727266AbfKFEGt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 23:06:49 -0500
Received: (qmail 17687 invoked by uid 109); 6 Nov 2019 04:06:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Nov 2019 04:06:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19309 invoked by uid 111); 6 Nov 2019 04:10:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Nov 2019 23:10:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Nov 2019 23:06:48 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Other doc fixes
Message-ID: <20191106040648.GC4307@sigill.intra.peff.net>
References: <pull.454.git.1572996692.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.454.git.1572996692.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 05, 2019 at 11:31:29PM +0000, Elijah Newren via GitGitGadget wrote:

> In addition to the pile of spelling fixes in my other pull request, here are
> some simple documentation fixes other than spelling errors (remove repeated
> word, '.' vs '->', missing hyphen).

Thanks, these all look trivially correct to me.

-Peff
