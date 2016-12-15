Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73CB0205F4
	for <e@80x24.org>; Thu, 15 Dec 2016 14:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbcLOOTP (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 09:19:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:57003 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752070AbcLOOTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 09:19:15 -0500
Received: (qmail 29355 invoked by uid 109); 15 Dec 2016 14:19:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 14:19:09 +0000
Received: (qmail 2219 invoked by uid 111); 15 Dec 2016 14:19:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 09:19:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 09:19:06 -0500
Date:   Thu, 15 Dec 2016 09:19:06 -0500
From:   Jeff King <peff@peff.net>
To:     Chiel ten Brinke <ctenbrinke@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Additional git hooks
Message-ID: <20161215141906.y4mdsmk6vhhftkym@sigill.intra.peff.net>
References: <CAFw20syajXbjCQRcrqCv8pS9JwSge7-V4Hsg96n8SpYv2jJneQ@mail.gmail.com>
 <20161215141430.natk4mi7imixcoow@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161215141430.natk4mi7imixcoow@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 09:14:30AM -0500, Jeff King wrote:

> On Thu, Dec 15, 2016 at 02:57:18PM +0100, Chiel ten Brinke wrote:
> 
> > Would patches introducing new git hooks, e.g. for post-fetch, be
> > eligible for acceptance?
> 
> The general guidelines for adding hooks is laid out here:
> 
>   http://public-inbox.org/git/7vbq7ibxhh.fsf@gitster.siamese.dyndns.org/

One interesting follow-up, though (which seems sensible to me):

  http://public-inbox.org/git/7vr5fraxbf.fsf@alter.siamese.dyndns.org/

-Peff
