Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79C91F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 18:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbdAYSnB (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:43:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:44622 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751513AbdAYSnB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:43:01 -0500
Received: (qmail 25347 invoked by uid 109); 25 Jan 2017 18:43:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 18:43:00 +0000
Received: (qmail 14207 invoked by uid 111); 25 Jan 2017 18:43:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 13:43:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 13:42:58 -0500
Date:   Wed, 25 Jan 2017 13:42:58 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] what content should go in https://git-scm.com/doc/ext
Message-ID: <20170125184258.v5sy6hwwpdsxz2u6@sigill.intra.peff.net>
References: <20170121135545.gi6crct66msylhpr@sigill.intra.peff.net>
 <CAP8UFD3Z9ZrLEZVkgL7ACkL5nOsoo2R6dUC=Bfy1AjF_9+4snQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3Z9ZrLEZVkgL7ACkL5nOsoo2R6dUC=Bfy1AjF_9+4snQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 22, 2017 at 08:13:53PM +0100, Christian Couder wrote:

> > Basically, we maintain a list of links to outside documentation, as well
> > as to books. Somebody has requested a link to their paid tutorial
> > course. How should we handle it?
> 
> I think it depends if you are ready and willing to handle more changes.

I don't clicking "merge" on more changes if people are willing to do the
design work.

> > Should we do the same for tutorial content like this?
> 
> It could make sense to link to tutorial content, and then it could
> also make sense to link to trainings (online and maybe offline too),
> but my fear is that you could then have many people who want to
> advertise their tutorials and trainings, and that it might be
> difficult to draw a line while keeping the playing field even.
> 
> But maybe it's worth trying anyway.

I think I'm inclined to try it, as long as it's kept in a separate "paid
training" section, and is open to everybody. If it becomes a burden, we
can cut it out later. I think the important thing is that it be equally
open to everybody or nobody, but not just "some". So we'll go with
everybody for now, and switch to nobody later if need be.

-Peff
