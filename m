Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95D861FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 15:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754790AbdBHPvg (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 10:51:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:51537 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752923AbdBHPvf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 10:51:35 -0500
Received: (qmail 7163 invoked by uid 109); 8 Feb 2017 15:43:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:43:59 +0000
Received: (qmail 32290 invoked by uid 111); 8 Feb 2017 15:44:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 10:44:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 10:43:57 -0500
Date:   Wed, 8 Feb 2017 10:43:57 -0500
From:   Jeff King <peff@peff.net>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
Message-ID: <20170208154357.sjmqs2wlxlnnllvf@sigill.intra.peff.net>
References: <vpq1svtstud.fsf@anie.imag.fr>
 <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
 <vpq37fowx5q.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vpq37fowx5q.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2017 at 03:54:25PM +0100, Matthieu Moy wrote:

> >> * We need to write the application, i.e. essentially polish and update
> >>   the text here: https://git.github.io/SoC-2016-Org-Application/ and
> >>   update the list of project ideas and microprojects :
> >>   https://git.github.io/SoC-2017-Ideas/
> >>   https://git.github.io/SoC-2016-Microprojects/
> >
> > That can be done incrementally by people who care (especially mentors)
> > over the next week or so, and doesn't require any real admin
> > coordination. If it happens and the result looks good, then the
> > application process is pretty straightforward.
> >
> > If it doesn't, then we probably ought not to participate in GSoC.
> 
> OK, it seems the last message did not raise a lot of enthousiasm (unless
> I missed some off-list discussion at Git-Merge?).

Nope, there was no discussion that I'm aware of.

> The application deadline is tomorrow. I think it's time to admit that we
> won't participate this year, unless someone steps in really soon.

Yes, I'd agree with that.

Outreachy folks asked if we were interested in participating, but I
think it has roughly the same pre-requisite lists for ideas and
microprojects.

> If we don't participate, I'll add a disclaimer at the top of the
> SoC-related pages on git.github.io to make sure students don't waste
> time preparing an application.

Good idea.

-Peff
