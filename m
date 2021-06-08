Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E0C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC776127A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFHH3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:29:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:48750 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhFHH3x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 03:29:53 -0400
Received: (qmail 28624 invoked by uid 109); 8 Jun 2021 07:28:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 07:28:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7458 invoked by uid 111); 8 Jun 2021 07:28:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 03:28:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 03:27:59 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: make -v useful
Message-ID: <YL8b/zUx0ikbqwC6@coredump.intra.peff.net>
References: <20210605011339.2202-1-felipe.contreras@gmail.com>
 <87czt059sn.fsf@evledraar.gmail.com>
 <YLv8NWL7WfBRkiGe@coredump.intra.peff.net>
 <60be41f6473e2_39c0a208f6@natae.notmuch>
 <YL8KiiGXF8LdGmQ2@coredump.intra.peff.net>
 <60bf1997b1a72_1a2ac520865@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60bf1997b1a72_1a2ac520865@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 02:17:43AM -0500, Felipe Contreras wrote:

> > Don't bother on my account. I have generally found that going more than
> > one round deep of discussion with you does not lead anywhere productive,
> > and I don't intend to continue this thread.
> 
> If there's no evidence that will ever convince you otherwise, that means
> you are not interested in actual real users, only in your idea of users.

I think you missed the point here. I am not interested in engaging with
_you_, because I often find it a waste of time. And I choose to do more
productive things.

-Peff
