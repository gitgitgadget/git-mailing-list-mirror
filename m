Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A88F1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 19:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfIWTaL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 15:30:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:57512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726777AbfIWTaL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 15:30:11 -0400
Received: (qmail 29572 invoked by uid 109); 23 Sep 2019 19:30:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Sep 2019 19:30:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3933 invoked by uid 111); 23 Sep 2019 19:32:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Sep 2019 15:32:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Sep 2019 15:30:09 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190923193009.GE21344@sigill.intra.peff.net>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <CAP8UFD38S_nV2NmjeadZ0J5ftJgBwghOZ+BNHZaNQ72nZmLtNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD38S_nV2NmjeadZ0J5ftJgBwghOZ+BNHZaNQ72nZmLtNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 17, 2019 at 05:10:43PM +0200, Christian Couder wrote:

> > Nice projects, all. There are a couple more ideas on
> > https://github.com/gitgitgadget/git/issues, they could probably use some
> > tagging.
> 
> Thanks! Maybe we should have a page with Outreachy microprojects on
> https://git.github.io/
> 
> I will see if I find the time to create one soon with the above information.

Please let me know if you do; there's a spot in the project page for:

  Description of your first time contribution tutorial:

  If your applicants need to complete a tutorial before working on
  contributions with mentors, please provide a description and the URL
  for the tutorial. For example, the Linux kernel asks applicants to
  complete a tutorial for compiling and installing a custom kernel, and
  sending in a simple whitespace change patch. Once applicants complete
  this tutorial, they can start to work with mentors on more complex
  contributions.

which could link to that list (and the list should probably discuss how
we consider micro-projects, etc, and link to MyFirstContribution or
similar).

I think this suggestion is a good one to add, as well:

  https://public-inbox.org/git/20190923180649.GA2886@szeder.dev/

-Peff
