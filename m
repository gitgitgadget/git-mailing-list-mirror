Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD26C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 18:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6DD820738
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 18:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgIOSHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:07:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:57416 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgIOSCh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 14:02:37 -0400
Received: (qmail 13969 invoked by uid 109); 15 Sep 2020 18:02:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Sep 2020 18:02:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20389 invoked by uid 111); 15 Sep 2020 18:02:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Sep 2020 14:02:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Sep 2020 14:02:19 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: Git in Outreachy?
Message-ID: <20200915180219.GA2861525@coredump.intra.peff.net>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <20200831180537.GC331156@google.com>
 <20200901125119.GA3250129@coredump.intra.peff.net>
 <20200903054126.GA2053272@coredump.intra.peff.net>
 <20200915173529.GA2859918@coredump.intra.peff.net>
 <12c349f3-aeee-7e44-08fd-ae03b3f16dab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12c349f3-aeee-7e44-08fd-ae03b3f16dab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 11:25:08PM +0530, Kaartic Sivaraam wrote:

> >> I'm still working out funding details, but in the meantime we're signed
> >> up. Potential mentors should propose projects here:
> >>
> >>   https://www.outreachy.org/communities/cfp/git/
> >>
> >> Sooner is better than later. We can technically submit projects up until
> >> the 24th, but student applications are open now, and have to be in by
> >> September 20th.
> > 
> > [Adding everybody to the cc list who has been in the Outreachy
> > thread this year...]
> > 
> > AFAICT we still have no proposed projects nor signed-up mentors.
> 
> Just to ensure I didn't miss anything, a person who's signing up as a
> mentor for an organization needs to propose a project or wait for one to
> be proposed, right? Or is there some other way to express interest in
> mentoring without proposing a project?

Right, mentors propose the projects they're willing to mentor.

> I ask this because I would be willing to sign up as a co-mentor for a
> project in the organization but don't have any project proposals in
> mind. I only see a way to "submit a project proposal" in the following
> page:
> 
>     https://www.outreachy.org/communities/cfp/git/

Yeah, you'd have to either find the person you want to co-mentor with
and work on a proposal with them, or wait for somebody to propose
something and then ask if you could join them as a co-mentor.

-Peff
