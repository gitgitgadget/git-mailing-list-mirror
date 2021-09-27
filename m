Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF220C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 19:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C1A60F94
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 19:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhI0Tt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 15:49:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:55618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235732AbhI0Tt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 15:49:28 -0400
Received: (qmail 7263 invoked by uid 109); 27 Sep 2021 19:47:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Sep 2021 19:47:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18864 invoked by uid 111); 27 Sep 2021 19:47:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Sep 2021 15:47:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Sep 2021 15:47:48 -0400
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH v2] connect: also update offset for features without
 values
Message-ID: <YVIf5I4BYWrHgzg9@coredump.intra.peff.net>
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
 <pull.1091.v2.git.git.1632671913693.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1091.v2.git.git.1632671913693.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 26, 2021 at 03:58:33PM +0000, Andrzej Hunt via GitGitGadget wrote:

>     connect: also update offset for features without values
>     
>     V2 incorporates Peff's test and test stability improvements, and
>     attempts to improve the commit message.

Thanks, this looks great to me.

-Peff
