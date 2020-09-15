Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8DFC2D0E0
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 18:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EBA2068D
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 18:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgIOSoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:44:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:57340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgIORfb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 13:35:31 -0400
Received: (qmail 13737 invoked by uid 109); 15 Sep 2020 17:35:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Sep 2020 17:35:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20125 invoked by uid 111); 15 Sep 2020 17:35:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Sep 2020 13:35:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Sep 2020 13:35:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: Git in Outreachy?
Message-ID: <20200915173529.GA2859918@coredump.intra.peff.net>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <20200831180537.GC331156@google.com>
 <20200901125119.GA3250129@coredump.intra.peff.net>
 <20200903054126.GA2053272@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903054126.GA2053272@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 03, 2020 at 01:41:26AM -0400, Jeff King wrote:

> I'm still working out funding details, but in the meantime we're signed
> up. Potential mentors should propose projects here:
> 
>   https://www.outreachy.org/communities/cfp/git/
> 
> Sooner is better than later. We can technically submit projects up until
> the 24th, but student applications are open now, and have to be in by
> September 20th.

[Adding everybody to the cc list who has been in the Outreachy
thread this year...]

AFAICT we still have no proposed projects nor signed-up mentors.
Interns are actively applying _now_, so we are likely missing out on (or
have already missed out on) applicants.

If you're interested in mentoring, the time to propose is definitely
ASAP.

-Peff
