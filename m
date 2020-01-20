Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF398C33CAA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C297422314
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATRz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:55:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:40462 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726642AbgATRz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 12:55:28 -0500
Received: (qmail 1725 invoked by uid 109); 20 Jan 2020 17:55:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Jan 2020 17:55:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4769 invoked by uid 111); 20 Jan 2020 18:02:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Jan 2020 13:02:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Jan 2020 12:55:27 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v4 0/6] Documentation for common user misconceptions
Message-ID: <20200120175527.GC3989@coredump.intra.peff.net>
References: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 20, 2020 at 05:33:38PM +0000, brian m. carlson wrote:

> This is v4 of a series improving the documentation to cover common user
> misconceptions.

With the exception of the minor issue I pointed out in patch 1, these
all look good to me.

-Peff
