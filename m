Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36093205F4
	for <e@80x24.org>; Thu, 15 Dec 2016 21:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755722AbcLOV5D (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 16:57:03 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60684 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754148AbcLOV5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 16:57:03 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B152D1FF6D;
        Thu, 15 Dec 2016 21:57:02 +0000 (UTC)
Date:   Thu, 15 Dec 2016 21:57:02 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Chiel ten Brinke <ctenbrinke@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] README: replace gmane link with public-inbox
Message-ID: <20161215215702.GA28777@starla>
References: <CAFw20syajXbjCQRcrqCv8pS9JwSge7-V4Hsg96n8SpYv2jJneQ@mail.gmail.com>
 <20161215141719.52peppv5pbjk3nuf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161215141719.52peppv5pbjk3nuf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Thu, Dec 15, 2016 at 02:57:18PM +0100, Chiel ten Brinke wrote:
> 
> > Btw, the link in the README
> > http://news.gmane.org/gmane.comp.version-control.git/ is dead.
> 
> Yes, the status of gmane was up in the air for a while, but I think we
> can give it up as dead now (at least for our purposes).

s/http/nntp/ still works for gmane.

> -- >8 --
> Subject: README: replace gmane link with public-inbox
> 
> The general status and future of gmane is unclear at this
> point, but certainly it does not seem to be carrying
> gmane.comp.version-control.git at all anymore. Let's point
> to public-inbox.org, which seems to be the favored archive
> on the list these days (and which uses message-ids in its
> URLs, making the links somewhat future-proof).

No objections, here.

There's also https://mail-archive.com/git@vger.kernel.org
Where https://mid.mail-archive.com/<Message-ID> also works
