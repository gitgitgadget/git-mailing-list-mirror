Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BD6C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 06:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AC720825
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 06:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgH1G4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 02:56:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:43318 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgH1G4L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 02:56:11 -0400
Received: (qmail 23164 invoked by uid 109); 28 Aug 2020 06:56:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Aug 2020 06:56:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3620 invoked by uid 111); 28 Aug 2020 06:56:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Aug 2020 02:56:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Aug 2020 02:56:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git in Outreachy?
Message-ID: <20200828065609.GA2105118@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Are we interested in participating in the December 2020 round of
Outreachy? The community application period is now open.

I can look into lining up funding, but we'd also need:

  - volunteers to act as mentors

  - updates to our applicant materials (proposed projects, but also
    microproject / patch suggestions)

-Peff
