Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA5A1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 20:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750943AbdAYUpI (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 15:45:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:44740 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750856AbdAYUpH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 15:45:07 -0500
Received: (qmail 1342 invoked by uid 109); 25 Jan 2017 20:45:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 20:45:07 +0000
Received: (qmail 15630 invoked by uid 111); 25 Jan 2017 20:45:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 15:45:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 15:45:05 -0500
Date:   Wed, 25 Jan 2017 15:45:05 -0500
From:   Jeff King <peff@peff.net>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: GSoC 2017: application open, deadline = February 9, 2017
Message-ID: <20170125204504.ebw2sa4uokfwwfnt@sigill.intra.peff.net>
References: <vpq1svtstud.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vpq1svtstud.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2017 at 04:02:02PM +0100, Matthieu Moy wrote:

> If the answer to one of the above question is yes, then:
> 
> * Who's willing to mentor? and to admin?

I did co-admin last year and the year before, but I made Matthieu do all
the work. :)

I do not mind doing the administrative stuff.  But the real work is in
polishing up the ideas list and microprojects page. So I think the first
step, if people are interested in GSoC, is not just to say "yes, let's
do it", but to actually flesh out these pages:

> * We need to write the application, i.e. essentially polish and update
>   the text here: https://git.github.io/SoC-2016-Org-Application/ and
>   update the list of project ideas and microprojects :
>   https://git.github.io/SoC-2017-Ideas/
>   https://git.github.io/SoC-2016-Microprojects/

That can be done incrementally by people who care (especially mentors)
over the next week or so, and doesn't require any real admin
coordination. If it happens and the result looks good, then the
application process is pretty straightforward.

If it doesn't, then we probably ought not to participate in GSoC.

-Peff

PS If we do participate, we should consider Outreachy as well, which can
   expand our base of possible applicants. Though note that ones who are
   not eligible for GSoC would need to be funded by us. Last year GitHub
   offered to cover the stipend for an Outreachy intern for Git. If
   there's interest I can see if that offer can be extended for this
   year.
