Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB6B1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 01:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeIFFyd (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 01:54:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:40724 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726171AbeIFFyd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 01:54:33 -0400
Received: (qmail 8506 invoked by uid 109); 6 Sep 2018 01:21:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 01:21:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25882 invoked by uid 111); 6 Sep 2018 01:21:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Sep 2018 21:21:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Sep 2018 21:21:43 -0400
Date:   Wed, 5 Sep 2018 21:21:43 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Git in Outreachy Dec-Mar?
Message-ID: <20180906012143.GA7477@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
 <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net>
 <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 03, 2018 at 06:36:19AM +0200, Christian Couder wrote:

> So here is a landing page for the next Outreachy round:
> 
> https://git.github.io/Outreachy-17/
> 
> about the microprojects I am not sure which page I should create or improve.

Thanks. I signed us up as a community (making me the "coordinator" in
their terminology). I think the procedure is a little different this
year, and we actually propose projects to mentor through their system.
So anybody interested in mentoring should go here:

  https://www.outreachy.org/communities/cfp/git/

(and you'll need to create a login if you don't have one from last
year). You should be able to click through "Submit a Project Proposal",
after which the fields are pretty self-explanatory.

-Peff
