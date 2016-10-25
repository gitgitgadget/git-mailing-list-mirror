Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA11D2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 16:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941866AbcJYQ2g (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 12:28:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:33983 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936309AbcJYQ2c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 12:28:32 -0400
Received: (qmail 4636 invoked by uid 109); 25 Oct 2016 16:28:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 16:28:31 +0000
Received: (qmail 2780 invoked by uid 111); 25 Oct 2016 16:28:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 12:28:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Oct 2016 12:28:29 -0400
Date:   Tue, 25 Oct 2016 12:28:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: pre-planning for git contributor's summit: Feb 2, 2017, Brussels
Message-ID: <20161025162829.jcy6fmnmdjual6io@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GitHub is organizing Git Merge 2017, and is offering space to do another
contributor's summit. I want to share what details I have so far, get
any input on what we want the event to be like, and see who's interested
in coming (for venue planning purposes).

The details below are still tentative, but I imagine the date and rough
location will not change at this point, as it's scheduled to be adjacent
to FOSDEM.

The plan is to do the contributor summit on Thursday, Feb 2,
2017. The main conference track for Git Merge is the day after, then
FOSDEM on the weekend. The location will be a conference space in
Brussels, Belgium (probably the one in [1]).

Right now we have a room with a projector and whiteboard that fits about
20-25 people. It's pretty conference-roomish. If we're bigger or smaller
than that, there are some alternative rooms. I think we'd ideally know
our approximate size by Dec 1st. We'll probably have the room 10am-3pm,
but that's in flux.

The format, attendee list, etc, are up to us in the Git community. In
past year's it's been pretty loosely organized. One room, about 20 or so
people, and people bringing up topics for discussion, presenting short
talks, etc. I think I'd like to do a _little_ more planning this year,
and have people propose topics a few days ahead of time, rather than on
a whiteboard the morning of the conference.

As far as attendees, in the past it's basically been open to anybody who
participates in development of Git or the surrounding ecosystem. That's
seemed fine to me, but I'm open to input. I'd also say that people who
are _interested_ in joining Git development would be welcome, even if
they haven't contributed a patch yet. Maybe we can convince them. :)

I think in the past it has technically been "invite only", and I've just
had interested people email me and cross-checked them in the list
archive and git-log, or sent a polite "who are you" email to anybody I
didn't recognize. I'm open to changing that to something more
democratic, but AFAIK I didn't exclude anybody in past years.

The registration fee for Git Merge (the whole thing) is $100, and I
think contributor summit registration will be tied to that. I should be
getting some registration codes to hand out that will waive the fee
completely. All of the proceeds are going to Software Freedom
Conservancy, so I'd encourage people who can get their company to send
them to a conference to consider having them pay. But it shouldn't be a
big deal for me to waive fees for contributors who want to do so.

Speaking of money, we've used some Git project money to subsidize travel
for contributors in past years. That's always been done in a very ad hoc
way, with people emailing the Git program committee (me, Junio, Shawn)
and working it out privately. I'm open to alternate proposals there.

I think that's about it. What I'd like to hear from you:

  1. A rough count of interested folks. Even if you're not sure you can
     make it, let me know (either on the list or via private email) so I
     can get an idea and communicate it to the folks booking the room.

  2. Any ideas or discussion on the event, format, etc. If there's
     something we need from the venue or event organizers, I can try to
     arrange it. Sooner is better for such things.

-Peff

PS There isn't an official RFP for talks for the main track yet, nor for
   the workshops which will happen the same day as the contributor
   summit.  But if you have an idea for a talk or a hands-on workshop,
   let me know and I can put you in touch with the event organizers.

[1] https://www.google.com/maps/place/The+Egg/@50.8357424,4.321425,15z/data=!4m13!1m7!3m6!1s0x0:0xe028c6680611d1da!2sThe+Egg!3b1!8m2!3d50.8331946!4d4.3270469!3m4!1s0x0:0xe028c6680611d1da!8m2!3d50.8331946!4d4.3270469
