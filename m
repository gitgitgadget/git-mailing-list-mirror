Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3AFC0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 19:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEEE20674
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 19:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbgCPTbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:31:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:41214 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732446AbgCPTbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 15:31:46 -0400
Received: (qmail 23617 invoked by uid 109); 16 Mar 2020 19:31:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Mar 2020 19:31:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 671 invoked by uid 111); 16 Mar 2020 19:41:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Mar 2020 15:41:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Mar 2020 15:31:44 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: Notes from Git Contributor Summit, Los Angeles (April 5, 2020)
Message-ID: <20200316193144.GD1073710@coredump.intra.peff.net>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <86pndd794k.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86pndd794k.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 15, 2020 at 07:42:19PM +0100, Jakub Narebski wrote:

> One question to all participating live (in person): how those topics
> were proposed, and how they were voted for?  This was done before remote
> access was turned on, I think.

During breakfast people wrote topics no a whiteboard and people voted on
them by putting a tick-mark on the board. The topics and votes were
transferred to the Google Doc for notes. Next time I think we'll just go
straight to the online doc to save time and make things friendlier for
remote folks (the whiteboard is a holdover from when we didn't have any
remotes). And I'll make it clear that remote people are welcome to add
topics and vote via the doc.

-Peff
