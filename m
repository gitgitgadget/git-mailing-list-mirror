Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2791F404
	for <e@80x24.org>; Tue, 14 Aug 2018 14:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbeHNRR1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 13:17:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:54550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730759AbeHNRR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 13:17:27 -0400
Received: (qmail 23672 invoked by uid 109); 14 Aug 2018 14:30:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 14:30:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22662 invoked by uid 111); 14 Aug 2018 14:30:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 10:30:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 10:30:01 -0400
Date:   Tue, 14 Aug 2018 10:30:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Elijah Newren' <newren@gmail.com>,
        'Git Mailing List' <git@vger.kernel.org>
Subject: Re: Contributor Summit planning
Message-ID: <20180814143000.GB3324@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <CABPp-BHdoRobhF=avL+12rAJF=Qmp2vNHgwdqJxBPFs=EBm+Tw@mail.gmail.com>
 <000601d433d2$4f9b6600$eed23200$@nexbridge.com>
 <878t59rqjk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t59rqjk.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 04:06:23PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I very much regret sending that 'git log' command without some further
> explanation.
> 
> It was only meant as a *very* rough shortlist of people in the context
> of a discussion of why some active contributors don't come to the
> contributor summit. I.e. whether that's because of the location, timing
> or whatever.
> 
> Any output from such a command definitely doesn't mean "you shouldn't
> come to the contributor summit because this one-liner doesn't list
> you".

Amen.

> I only meant to suggest that it would be interesting as a heuristic to
> solicit feedback from people who *are* very active contributors to the
> main git project who don't show up, to see why that is. Only because it
> might be indicative of why some people who'd otherwise don't show up
> don't show up.

I've bugged people privately in the past to see if they want to come,
and I think the limiting factor is usually just time/effort to travel.

-Peff
