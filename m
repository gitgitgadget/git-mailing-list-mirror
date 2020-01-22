Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E975DC32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 05:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15692253D
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 05:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgAVFe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 00:34:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:41820 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725730AbgAVFe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 00:34:56 -0500
Received: (qmail 13206 invoked by uid 109); 22 Jan 2020 05:34:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Jan 2020 05:34:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19748 invoked by uid 111); 22 Jan 2020 05:41:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Jan 2020 00:41:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Jan 2020 00:34:55 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: GSoC and Outreachy Summer 2020?
Message-ID: <20200122053455.GA51054@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I notice deadlines are approaching for Git to apply for GSoC (Feb 5th)
and for Outreachy (Feb 18th), though we still have some time. Do mentors
have sufficient bandwidth for us to participate?

-Peff
