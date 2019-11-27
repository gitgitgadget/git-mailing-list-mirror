Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7C7C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C2E2071E
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 16:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfK0QSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 11:18:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:34016 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726514AbfK0QSi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 11:18:38 -0500
Received: (qmail 12317 invoked by uid 109); 27 Nov 2019 16:18:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 16:18:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11114 invoked by uid 111); 27 Nov 2019 16:22:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 11:22:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 11:18:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Git at SFC <git@sfconservancy.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: This list is now also archived on lore.kernel.org/git
Message-ID: <20191127161836.GA30581@sigill.intra.peff.net>
References: <20191120154347.x6w4v7cdzy4yrx6q@chatter.i7.local>
 <20191120195556.GA25189@dcvr>
 <87woblnxnc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87woblnxnc.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 04:31:51PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I think it would make sense for the Git SFC arm of things[1] to consider
> taking over the public-inbox.org domain rather than letting it expire
> (of course contingent on your approval) and turning it into a CNAME (or
> other redirect) for lore.kernel.org.
> 
> We have a lot of mailing list and some (~130 commits) git.git commit
> references to that domain. It seems like a worthwhile expense to me to
> pay for the renewal of it rather than having it turn into e.g. some spam
> landing page as the registration expires.
> 
> 1. Disclaimer: I'm one of the people who'd vote on making that decision
>    if it came to that, but this E-Mail is, as they say, just like, my
>    opinion, man :)

I'm also one of those people, and I'd consider it as well. A lot of it
would depend on the cost, and what happens with this whole .org
registrar thing.

-Peff
