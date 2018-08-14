Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D89C1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 14:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbeHNRXS (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 13:23:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:54570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730759AbeHNRXS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 13:23:18 -0400
Received: (qmail 23904 invoked by uid 109); 14 Aug 2018 14:35:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 14:35:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22734 invoked by uid 111); 14 Aug 2018 14:35:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 10:35:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 10:35:50 -0400
Date:   Tue, 14 Aug 2018 10:35:50 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: Contributor Summit planning
Message-ID: <20180814143550.GA3441@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <CAGZ79kYMV0DCd89Pw3v4d48GyQN9iQzt=XZ9=aGswHFHWhas3g@mail.gmail.com>
 <CAP8UFD11BTfkw3pP_F9O5miRw2wtcE7Unnhj0DMEPwo+LW=Dhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD11BTfkw3pP_F9O5miRw2wtcE7Unnhj0DMEPwo+LW=Dhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 06:31:50AM +0200, Christian Couder wrote:

> > We have been kicking around the thought of reviving the GitTogethers
> > like back in the olden days (I only know them from hearsay), in
> > Mountain View or Sunnyvale at the Google Campus, but we have not yet
> > spent enough thought to make it so.
> 
> I think it would be great to have GitTogethers again around the time
> of the GSoC Mentor Summit like we did a long time ago!

Yeah, that's an interesting concept. In addition to amortizing travel
for one or maybe two Git devs who are mentors, it also allowed us to
pull in other open source folks who were tangential to Git (e.g., I
remember Joey Hess of git-annex fame came one year).

On the other hand, we can only send two mentors to the summit, so there
is no draw at all for the rest of the folks. :)

Timing-wise, it may be getting a little close to plan this year, as it's
exactly 2 months away (and I'd think many people, especially coming from
Europe, would already have made travel plans). We could start next year,
but that's 14 months away.

> > Personally I think the way is fine; we could collect topics in advance on
> > the list to have a head start, but the whiteboard is totally fine, IMHO.
> 
> Yeah for the GitTogethers we used to collect topics in advance, but we
> still had a whiteboard and voted on them at the beginning of the
> actual GitTogether.

Heh. Every year I ask for topics on the list, and the response leads me
to believe that people are happy white-boarding in the morning. ;)

-Peff
