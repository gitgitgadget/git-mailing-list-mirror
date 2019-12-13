Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABECC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 05:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3583B22527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 05:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfLMFAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:00:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:45618 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725385AbfLMFAk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 00:00:40 -0500
Received: (qmail 27495 invoked by uid 109); 13 Dec 2019 05:00:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Dec 2019 05:00:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21327 invoked by uid 111); 13 Dec 2019 05:05:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Dec 2019 00:05:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Dec 2019 00:00:38 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git Merge Contributor's Summit, March 5, 2020, Los Angeles
Message-ID: <20191213050038.GA75792@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git Merge 2020 is happening on March 4th. There will be a Contributor's
Summit the day after (not before, as in years past!). Here are the
details:

  When: Thursday, March 5th. 10am-5pm.
  Where: TBD, Los Angeles, California, USA
  What: Round-table discussion about Git
  Who: All contributors to Git or related projects in the Git ecosystem
       are invited; if you're not sure if you qualify, please ask!

This email is just to announce the date so people can start planning.
You'll need to register eventually, but I don't have details of that
procedure yet. I expect it will be similar to past years. In particular,
if you're coming to the contrib summit, DON'T register for the main
conference yet, as the registration will probably cover both. You don't
need to email me for a code yet; I'll send more details when I have
them.

Note that this is a little different from past years, in that the
contributor summit will be (by popular demand) the day _after_ the main
conference, rather than before. Hopefully this should give us the
opportunity to dissect some of the main conference talks.

The plan is to have an A/V setup sufficiently good for people to join
remotely. I'll provide details for how to do that when we get closer to
the event.

If you'd like to come but need financial assistance with travel costs,
please reach out to the Git PLC at git@sfconservancy.org. We'll collect
requests and try to make decisions and notify people by mid-January,
which would hopefully still leave time for making travel arrangements.

Other than that, please be thinking about (and feel free to discuss in
this thread) topics you'd like to discuss, or any general thoughts on
the format, venue setup, etc.

-Peff
