Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DF5C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 12:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59CA206CD
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 12:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgIAMwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:52:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:46236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgIAMv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 08:51:27 -0400
Received: (qmail 26975 invoked by uid 109); 1 Sep 2020 12:51:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2020 12:51:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26921 invoked by uid 111); 1 Sep 2020 12:51:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2020 08:51:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Sep 2020 08:51:19 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git in Outreachy?
Message-ID: <20200901125119.GA3250129@coredump.intra.peff.net>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <20200831180537.GC331156@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200831180537.GC331156@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 31, 2020 at 11:05:37AM -0700, Emily Shaffer wrote:

> I'm interested in mentoring or co-mentoring this term. (I'm not working
> this week but I didn't want to miss a deadline to volunteer.)

OK, between you and Christian, then, it sounds like it's worth pursuing.
I'll sign us up and try to arrange funding.

> One thought I had was whether it might be cool to shop for another
> co-mentor from Wireshark and have an intern teach Wireshark how to
> decipher Git protocol. But it seems large, and maybe last-minute for
> this term.

That sounds neat. I don't think it would be too large (in fact, I think
it might end up being a bit small for a whole-term project). It would
definitely require somebody from Wireshark being a co-mentor, though.

-Peff
