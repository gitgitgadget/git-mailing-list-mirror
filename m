Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCE9D1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 18:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbdJKS1M (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 14:27:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:49882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752029AbdJKS1L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 14:27:11 -0400
Received: (qmail 30212 invoked by uid 109); 11 Oct 2017 18:27:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Oct 2017 18:27:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8556 invoked by uid 111); 11 Oct 2017 18:27:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Oct 2017 14:27:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Oct 2017 14:27:09 -0400
Date:   Wed, 11 Oct 2017 14:27:09 -0400
From:   Jeff King <peff@peff.net>
To:     Ayush Goel <ayushgoel111@gmail.com>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: Unable to use --patch with git add
Message-ID: <20171011182709.be6qwvbsdnam66u7@sigill.intra.peff.net>
References: <CAEBs8jLnU44n2fhE8tGommqfEpFPdd0FLUtmeZXZ+qhB1RV6XQ@mail.gmail.com>
 <20171011174952.almye3qa2tmyrmol@LykOS.localdomain>
 <CAEBs8jKAsb3B-6WJ=ptL2AsGvDRFVPYLCsztpdTN6KCBLOo1XA@mail.gmail.com>
 <20171011180015.mqn5xkj5z4yjdrhm@sigill.intra.peff.net>
 <CAEBs8jLyvyE+t=9mDHkD0nUY2SBYymg44BeQbUF0Li4CSZhMWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEBs8jLyvyE+t=9mDHkD0nUY2SBYymg44BeQbUF0Li4CSZhMWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2017 at 11:43:46PM +0530, Ayush Goel wrote:

> Thank you for your mail. It works :)
> 
> For future reference, is there a page for known issues of git?

No, there's just the mailing list archive. But you can search it. E.g.:

  https://public-inbox.org/git/?q=%22add+-p%22

finds the relevant threads.

-Peff
