Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A11C43215
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D002070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK0M7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:59:37 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60840 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0M7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 07:59:37 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8B5471F463;
        Wed, 27 Nov 2019 12:59:36 +0000 (UTC)
Date:   Wed, 27 Nov 2019 12:59:36 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: recommend lore.kernel.org over public-inbox.org
Message-ID: <20191127125936.GA9877@dcvr>
References: <20191127125231.GH22221@sigill.intra.peff.net>
 <20191127125343.GA27983@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127125343.GA27983@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> Since lore.kernel.org now has the same archive as public-inbox.org and
> may have more longevity going forward[1], let's recommend people use it
> for finding or referencing messages.
> 
> [1] https://public-inbox.org/git/20191120195556.GA25189@dcvr/
>       or if you like:
>     https://lore.kernel.org/git/20191120195556.GA25189@dcvr/
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> And it's one character shorter. Think of all of the bytes saved!

:>  URL length has always bothered me.
peff.net/git/$MESSAGE_ID/ would be nice to have, as well :)

Anyways, consider this series:

Acked-by: Eric Wong <e@80x24.org>

(and I doubt I'll keep paying for 80x24.org, either...)
