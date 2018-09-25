Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB661F453
	for <e@80x24.org>; Tue, 25 Sep 2018 21:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeIZEAw (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:00:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:59282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726104AbeIZEAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:00:52 -0400
Received: (qmail 2551 invoked by uid 109); 25 Sep 2018 21:51:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Sep 2018 21:51:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12454 invoked by uid 111); 25 Sep 2018 21:50:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 25 Sep 2018 17:50:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2018 17:51:14 -0400
Date:   Tue, 25 Sep 2018 17:51:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [ANNOUNCE] New Git PLC Members
Message-ID: <20180925215112.GA29627@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I mentioned about a month ago in [1] that we needed to add members to
the committee representing the Git project as part of Software Freedom
Conservancy (see that email for details on what exactly that means :) ).

I'm happy to announce that this is now done, and both Christian and Ævar
are on the committee. Welcome to both of you!

As before, if you have project governance questions, the best point of
contact is git@sfconservancy.org, which goes to the four committee
members, along with a few Conservancy folks. Though unless it
specifically needs to be private, I'd generally encourage people to
raise issues first on the list so the whole community can discuss.

-Peff

[1] https://public-inbox.org/git/20180816224138.GA15490@sigill.intra.peff.net/
