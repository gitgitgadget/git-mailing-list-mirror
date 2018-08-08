Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E1E1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbeHHVU5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46833 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730094AbeHHVU5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 17:20:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 41F0421E9E;
        Wed,  8 Aug 2018 14:59:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 Aug 2018 14:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=aBIn0htJ2JZKOdiKSyacCJ8h//CjG
        WZE8EuZtt0Rakg=; b=j8UrSct4If9F7XAFLIRAFg95VPvDVCYRO1DUOND5xgoWA
        JZ9g9UI0HdUJ8IDNH//g8EShAcZqvBuioT+4d92ZFb0oe8lbTVOa940ZY1ve40kI
        SbyTSD7eh67LA7sWiyOl/fA75NjrUJqM+flOSGwqGdeYdkLgcItY9HxMvuB32KgF
        GS0nBBzLaVadlR6U4VZF1V1U2wjh4E0xkDl0YDbp5YaeVdP5sa2/gJ8+HUeg5c4y
        jsD51kir4dss61RinmiLka33TCBU11+5YqKFJnP30mb9Ce31jADpZcfnGm0y+Aic
        OwKNvZ5xj5ZcxUPxNKRe7mYRavJoZmqye25p4CG/Q==
X-ME-Proxy: <xmx:rD1rW7fRfmYlYdSnhA6974U4xbVlSOvE_zaeCd8ZyL80kZ1ntBbFpA>
    <xmx:rD1rW2urfEOf6t9fOv6mdEfO7LBjSbo_hy3Qb3RB-u0cb9CqyLm47Q>
    <xmx:rD1rW3OIPal4Ob1Ax-tYrKusjpcfSdOCCr7PrHv4WCcxTXn9SAp4nA>
    <xmx:rD1rW6Xq_NuXxyagZg4vUR-GQAdAKQWI0SqD6mTgSmN0bvqQwkZyJw>
    <xmx:rD1rWyVcKkh-v00A_f124K19zUOLNxYxjiBd63K3gMvnXnEf3E9I7w>
    <xmx:rD1rW8olXasX_t_laWg2Vg4UnGzLPOBst0C0d2Lff2dw3WIUraF9RQ>
X-ME-Sender: <xms:rD1rW5eIPuximpFnKvfCz2LILM1OwnAPxXuZSEuZ3q47Itpr7T-rhA>
References: <20180808035854.49D69E450E@mailuser.nyi.internal> <20180808151639.GA1607@sigill.intra.peff.net>
From:   Brady Trainor <mail@bradyt.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Page content is wider than view window
In-reply-to: <20180808151639.GA1607@sigill.intra.peff.net>
Date:   Wed, 08 Aug 2018 12:00:03 -0700
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <20180808185955.BE29E1025C@mailuser.nyi.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, there's work happening already for a visual refresh of the site,
> [...]
>
> -Peff

Awesome! Looking forward to it!

-- 
Brady
