Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9192C2BA1B
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 17:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D44220730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 17:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgDHRaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:30:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:37190 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728771AbgDHRaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 13:30:22 -0400
Received: (qmail 12329 invoked by uid 109); 8 Apr 2020 17:30:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Apr 2020 17:30:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9651 invoked by uid 111); 8 Apr 2020 17:40:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2020 13:40:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Apr 2020 13:30:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Happy birthday to all of us ;-)
Message-ID: <20200408173021.GB1961925@coredump.intra.peff.net>
References: <xmqqzhbmpyh6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhbmpyh6.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 07, 2020 at 06:17:41PM -0700, Junio C Hamano wrote:

> So, it was today 15 years ago that Linus announced the availability
> of the first tarball of Git.
> 
> Let me thank all the contributors, both long timers and relatively
> newer ones, for working on the system to help our users better.
> 
> But I should not forget to thank others who help us by doing things
> other than writing code.  Writing code is not the only work on the
> software.

And let us also not forget to thank any maintainers. :)

-Peff
