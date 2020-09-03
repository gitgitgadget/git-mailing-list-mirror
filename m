Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55B9C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 05:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF35F2071B
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 05:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgICFlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:41:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:47962 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgICFl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 01:41:28 -0400
Received: (qmail 7965 invoked by uid 109); 3 Sep 2020 05:41:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Sep 2020 05:41:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11744 invoked by uid 111); 3 Sep 2020 05:41:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Sep 2020 01:41:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Sep 2020 01:41:26 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git in Outreachy?
Message-ID: <20200903054126.GA2053272@coredump.intra.peff.net>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <20200831180537.GC331156@google.com>
 <20200901125119.GA3250129@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901125119.GA3250129@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 01, 2020 at 08:51:20AM -0400, Jeff King wrote:

> On Mon, Aug 31, 2020 at 11:05:37AM -0700, Emily Shaffer wrote:
> 
> > I'm interested in mentoring or co-mentoring this term. (I'm not working
> > this week but I didn't want to miss a deadline to volunteer.)
> 
> OK, between you and Christian, then, it sounds like it's worth pursuing.
> I'll sign us up and try to arrange funding.

I'm still working out funding details, but in the meantime we're signed
up. Potential mentors should propose projects here:

  https://www.outreachy.org/communities/cfp/git/

Sooner is better than later. We can technically submit projects up until
the 24th, but student applications are open now, and have to be in by
September 20th.

-Peff
