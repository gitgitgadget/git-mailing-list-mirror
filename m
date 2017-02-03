Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29A931F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 12:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdBCMIo (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 07:08:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:48773 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbdBCMIn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 07:08:43 -0500
Received: (qmail 21399 invoked by uid 109); 3 Feb 2017 12:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Feb 2017 12:08:42 +0000
Received: (qmail 26337 invoked by uid 111); 3 Feb 2017 12:08:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Feb 2017 07:08:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2017 13:08:38 +0100
Date:   Fri, 3 Feb 2017 13:08:38 +0100
From:   Jeff King <peff@peff.net>
To:     pedro rijo <pedrorijo91@gmail.com>
Cc:     sxlijin@gmail.com, e@80x24.org, git@vger.kernel.org
Subject: Re: git-scm.com status report
Message-ID: <20170203120838.ohxq5ac7dadlvy4s@sigill.intra.peff.net>
References: <16F9F83D-5A7F-4059-9A27-DB25A8FB1E99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16F9F83D-5A7F-4059-9A27-DB25A8FB1E99@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 02, 2017 at 10:01:45PM +0000, pedro rijo wrote:

> While I’m not experienced with Rails apps, I would like to give my
> contribution to the Git project. I could help doing some kind of
> triage, removing abusing PRs/issues (like
> https://github.com/git/git-scm.com/pull/557
> <https://github.com/git/git-scm.com/pull/557>), looking for typos and
> other tasks that wouldn’t require a lot of RoR knowledge to get start.
> Also, completely free and available to start digging into the RoR
> stuff of course!

Thanks! I think a good first step is just to start watching the
repository and jump in on issues where you think you can contribute.

Clicking "close" or "merge" on an issue is something only I can do for
now, but having a group of people reviewing and responding to issues and
PRs is a big help (so I _can_ just click those buttons). And then
over time hopefully we can grow a stable of reviewers, and hand out
repo privileges to the active ones.

-Peff
