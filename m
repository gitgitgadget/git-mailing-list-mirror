Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5CBC1F464
	for <e@80x24.org>; Mon, 16 Sep 2019 21:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391838AbfIPVdD (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 17:33:03 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42000 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391828AbfIPVdC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 17:33:02 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1ED291F463;
        Mon, 16 Sep 2019 21:33:02 +0000 (UTC)
Date:   Mon, 16 Sep 2019 21:33:01 +0000
From:   Eric Wong <e@80x24.org>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190916213301.mybxocvdhdhd7xlg@whir>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916184208.GB17913@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> wrote:
> Jonathan Tan, Jonathan Nieder, Josh Steadmon and I met on Friday to talk
> about projects and we came up with a trimmed list; not sure what more
> needs to be done to make them into fully-fledged proposals.

<snip>

> For the longer projects, we came up with a few more:

<snip>

>  - add a TUI to deal more easily with the mailing list. Jonathan Tan has
>    a strong idea of what this TUI would do... This one would also end up
>    external but adjacent to the Git codebase.

AFAIK, Konstantin is/was interested in exploring some of these
ideas with Linux Foundation, too (but he's on vacation atm)

<snip>

> It might make sense to only focus on scoping the ones we feel most
> interested in. We came up with a pretty big list because we had some
> other programs in mind, so I suppose it's not necessary to develop all
> of them for this program.
