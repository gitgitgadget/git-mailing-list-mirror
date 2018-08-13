Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A0B41F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbeHMW2Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:28:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:53646 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729990AbeHMW2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:28:16 -0400
Received: (qmail 13355 invoked by uid 109); 13 Aug 2018 19:44:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Aug 2018 19:44:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13048 invoked by uid 111); 13 Aug 2018 19:44:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 15:44:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 15:44:35 -0400
Date:   Mon, 13 Aug 2018 15:44:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Contributor Summit planning
Message-ID: <20180813194435.GD10013@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <87h8jyrtj6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8jyrtj6.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 08:49:33PM +0200, Ævar Arnfjörð Bjarmason wrote:

>  * I think we should tread carefully when it comes to say some form of
>    remote A/V participation open to the Internet.
> 
>    It was fine to have Dscho on a chair, but it would be quite different
>    if this were say streamed on YouTube and everyone felt like they were
>    on stage the whole time, and if offhand comments / jokes etc. were
>    recorded.
> 
>    I'm not categorically against that, it's just something to think
>    carefully about. Maybe if there's demand for it we could dedicate
>    some time slot to that.

Interesting points. I had in mind that the "invite list" for remote
would be the same as for in-person. I also am not categorically against
some kind of wider output for part of event, but I do think the casual
and intimate nature is most of what makes the event useful.

>  * Re the second half of "Not everyone can travel or can afford to do
>    so" from Derrick, there's been travel sponsorships in past years.

Yes, and I think we should continue with that offer. That's mostly been
paid out from project funds in past years, but I suspect we could dig up
sponsorship specific to the event if we had to.

> [...]
>    Or would those companies be OK with trusting that some 20-ish of us
>    can hold our tongues for one day and not ruin the surprise?

Also good points. Obviously it's up to whoever is trying to keep their
secret what they want to do, but my opinion is that it's reasonable to
talk about things the day before. I really enjoyed in one of the early
years (Berlin 2013, I think) when Michael Haggerty gave two talks on
git-imerge: one to the general population that might be interested in
using it, and one to developers that really went into detail on the
theory of how it worked.

Another option I know we've discussed is having the contributor summit
the day _after_ the main conference. That really complicates the
logistics, though, because usually we piggy-back on the main event
space, which we already have available the day before for
main-conference setup and for training. I think it would also conflict
with people wanting to go to FOSDEM on the following day.

But I'll mention it to the folks organizing for this year to see if we
can work something out. Secrets aside, I think it would be fun to have a
session discussing all of the stuff we just heard about the day before. ;)

-Peff
