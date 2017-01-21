Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523601F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 13:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbdAUNzt (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 08:55:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:42580 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbdAUNzs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 08:55:48 -0500
Received: (qmail 886 invoked by uid 109); 21 Jan 2017 13:55:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 13:55:47 +0000
Received: (qmail 24072 invoked by uid 111); 21 Jan 2017 13:56:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 08:56:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jan 2017 08:55:45 -0500
Date:   Sat, 21 Jan 2017 08:55:45 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [RFC] what content should go in https://git-scm.com/doc/ext
Message-ID: <20170121135545.gi6crct66msylhpr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm wondering if anybody has opinions on:

  https://github.com/git/git-scm.com/pull/924

(and I suspect most people in this community do not read pull requests
there, hence this post).

Basically, we maintain a list of links to outside documentation, as well
as to books. Somebody has requested a link to their paid tutorial
course. How should we handle it?

If the resource is valuable, then it may make sense to link to it, even
if it costs money. We already do this with book links, and my policy has
been to link any relevant book that is requested (I don't read them for
quality, so I have no opinions).

Should we do the same for tutorial content like this?

-Peff
