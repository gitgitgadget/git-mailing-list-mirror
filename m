Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7BAC1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbdAYWGq (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:06:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:44893 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbdAYWGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:06:45 -0500
Received: (qmail 6876 invoked by uid 109); 25 Jan 2017 22:06:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 22:06:35 +0000
Received: (qmail 17037 invoked by uid 111); 25 Jan 2017 22:06:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 17:06:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 17:06:33 -0500
Date:   Wed, 25 Jan 2017 17:06:33 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Add more proposals to SoC 2017 ideas page. (lots of
 submodule stuff)
Message-ID: <20170125220632.whjnpvrnhve2h6f6@sigill.intra.peff.net>
References: <20170125215931.26339-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170125215931.26339-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 01:59:31PM -0800, Stefan Beller wrote:

>   This applies to the repo at https://github.com/git/git.github.io

Thanks. I've applied and pushed, though I'll admit I didn't really read
it carefully for content. A few of the ideas look like they would need
to be aggregated to be big enough for a SoC project, but that can be
fleshed out in future patches (i.e., I don't think we care enough about
history to have people polish and re-roll what are essentially wiki
edits).

If you (or anybody interested in working on this) would prefer direct
push access to the git.github.io repo, I'm happy to set that up.

>   If you're looking for a co-admin/mentors, I can help out.

I may take you up on the co-admin thing. I think it's good to have a
backup, just in case.

Anything you put on the Ideas page, you should probably be willing to
mentor. We definitely _don't_ want Ideas that don't have a mentor.
I think in general that each idea should have the possible mentors
listed below it.

-Peff
