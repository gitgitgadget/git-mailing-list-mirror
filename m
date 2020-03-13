Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE64C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 21:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0252074A
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 21:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCMVZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:25:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41256 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgCMVZb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 17:25:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 68B0D1F619;
        Fri, 13 Mar 2020 21:25:31 +0000 (UTC)
Date:   Fri, 13 Mar 2020 21:25:31 +0000
From:   Eric Wong <e@yhbt.net>
To:     James Ramsay <james@jramsay.com.au>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [TOPIC 16/17] =?utf-8?B?4oCcSSB3YW50?=
 =?utf-8?Q?_a_reviewer=E2=80=9D?=
Message-ID: <20200313212531.GA22502@dcvr>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <6DAC1E49-9CA0-4074-867E-F22CD26C9FEB@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6DAC1E49-9CA0-4074-867E-F22CD26C9FEB@jramsay.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

James Ramsay <james@jramsay.com.au> wrote:

James: first off, thank you for these accessible summaries for
non-JS users and those who could not attend for various reasons(*)

<snip>

> 6. Peff: this is all possible on the mailing list. I see things that look
> interesting, and have a to do folder. If someone replies, I’ll take it off
> the list. Once a week go through all the items. I like the book club idea,
> instead of it being ad hoc, or by me, a group of a few people review the
> list in the queue. You might want to use a separate tool, like IRC, but it
> would be good to have it bring it back to the mailing list as a summary.
> Public inbox could be better, but someone needs to write it. Maybe nerd
> snipe Eric?

What now? :o

There's a lot of things it could be better at, but a more
concrete idea of what you want would help.

Right now I only have enough resources to do bugfixes along with scalability
and performance improvements so more people can run it and keep
it 100% reproducible and centralization resistant.

I'm also planning on some local tooling along the lines of
notmuch/mairix which is NNTP/HTTPS-aware but not sure when I'll
be able to do that...


(*) I stopped attending events over a decade ago for privacy reasons
    (facial recognition, invasive airport searches, etc.)
