Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1DEF1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 15:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeH1TG3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 15:06:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:58904 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726383AbeH1TG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 15:06:28 -0400
Received: (qmail 7482 invoked by uid 109); 28 Aug 2018 15:14:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Aug 2018 15:14:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1365 invoked by uid 111); 28 Aug 2018 15:14:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 Aug 2018 11:14:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Aug 2018 11:14:19 -0400
Date:   Tue, 28 Aug 2018 11:14:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: Git in Outreachy Dec-Mar?
Message-ID: <20180828151419.GA17467@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Outreachy application period is set to begin on September 10th for
interns participating in the December-March program. Do we want to
participate?

Details on the program are here:

  https://www.outreachy.org/communities/cfp/

If we want to, then we need:

  1. Volunteers to mentor. This is similar in scope to being a GSoC
     mentor.

  2. To get our landing page and list of projects in order (and also
     micro-projects for applicants). This can probably build on the
     previous round at:

       https://git.github.io/Outreachy-15/

     and on the project/microprojects lists for GSoC (which will need
     some updating and culling).

  3. To figure out funding (unlike GSoC, the intern stipend comes from
     the projects). I can look into getting outside funds (which is what
     we did last year). Worst case, we do have enough project money to
     cover an intern. Last year[1] opinions were that this was a
     reasonable use of project money, but of course new opinions are
     welcome.

If the answer is "yes, we should participate", it will hopefully be
accompanied with "yes, I will mentor", and "yes, and I will start
getting the landing page ready." :)

-Peff

[1] https://public-inbox.org/git/20170901223059.xsbcpqff45mnblnj@sigill.intra.peff.net/
