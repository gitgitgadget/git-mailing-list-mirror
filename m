Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BCAC32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3C222522
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgAOUFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:05:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:37262 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726527AbgAOUFd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 15:05:33 -0500
Received: (qmail 18987 invoked by uid 109); 15 Jan 2020 20:05:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Jan 2020 20:05:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32443 invoked by uid 111); 15 Jan 2020 20:11:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2020 15:11:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jan 2020 15:05:32 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git Contributor Summit Registration, Mar 5, 2020, Los
 Angeles
Message-ID: <20200115200532.GA4101552@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following up on my earlier announcement, I have some more details for
the Contributor Summit at Git Merge this year:

  When: Thursday, March 5th. 10am-5pm.
  Where: Downtown Loft, 1054 S Olive St, Los Angeles, CA 90015
  What: Round-table discussion about Git
  Who: All contributors to Git or related projects in the Git ecosystem
       are invited; if you're not sure if you qualify, please ask!

Note that this is the day _after_ the main Git Merge conference, unlike
previous years. The main conference schedule and agenda is up at:

  https://git-merge.com

To attend, you'll need to register online; please email me off-list for
instructions and a special code. It's bundled with your main conference
registration, so please DO NOT register for the main conference until
you get the code. As with previous years, you'll have the option of
attending for free, or paying the $125 conference fee (all of which goes
to Software Freedom Conservancy).

If you'd like to come but need financial assistance with travel costs,
please reach out as soon as possible to the Git PLC at git@sfconservancy.org.
We'd like to make any funding decisions soon so that people have time to
make travel arrangements. So let's try to have all requests in by next
Monday, January 21st.

When picking a hotel, note that the contributor summit is not at the
same venue as the main conference (but it's nearby). There are some
hotels with special pricing listed on the conference page at
https://git-merge.com/#experience.

We're still working out details of the A/V setup, but the plan is to
have a way for people to join remotely. I'll send details when I have
them.

The afternoon schedule for the main conference is a bit different this
year: we'll have some round-table "Birds of Feather" discussions to get
attendees talking to each other. Think about topics you'd like to
discuss, and also whether you'd like to facilitate a discussion. The
online registration will ask about both. If you're interested, we'll
provide more information and some documentation in advance about how it
will work.

There's also a tentative "Stump the Experts" panel as one of the
sessions. There are still logistics to be worked out (e.g., how far in
advance questions will come), but the general idea is to take attendee
questions about some of the more confusing parts of Git. If you're
interested in being on the panel, let me know.

Sooner is better to make our planning easier, so please let me know if
you're interested by January 31st.

I hope to see everybody there!

-Peff
