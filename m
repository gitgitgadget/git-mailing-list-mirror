Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6018FC433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 04:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405952053B
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 04:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgGZEC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 00:02:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42282 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgGZEC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 00:02:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A481A1F5AE;
        Sun, 26 Jul 2020 04:02:26 +0000 (UTC)
Date:   Sun, 26 Jul 2020 04:02:26 +0000
From:   Eric Wong <e@80x24.org>
To:     Carmen Andoh <candoh@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git Inclusion Summit
Message-ID: <20200726040226.GA19030@dcvr>
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carmen Andoh <candoh@google.com> wrote:
> Hello Git community,
> 
> There's been some conversation about holding a virtual contributor
> summit focused on inclusion [1]. I've volunteered to work with
> Jonathan Nieder’s team on organizing this event.
> 
> The purpose of this inclusion summit is to engage core Git
> contributors as active participants in diversity and inclusion
> initiatives for the Git project. As mentioned [2] "to align and
> coordinate, to set out goals that we want to agree on." This is part
> of a broader goal to make the Git version control system better
> support inclusive open source projects. The summit will give
> contributors the opportunity to learn about and share perspectives on
> inclusive culture, product inclusion, and career development.
> 
> This can be run unconference style like previous contributor summits:
> we'll use a spreadsheet to choose and vote on topics. This event will
> be a success if we walk away with specific recommendations on where
> and how Git will make changes to improve the experiences of
> underrepresented users in the Git project, and how to make the Git
> project better represent the needs of current and potential users.
> 
> It was mentioned in [1] that we should have conversations about equity
> and inclusion with more diverse voices present.  But we also don’t
> want to put a burden on individuals coming to educate us about things
> that we should be researching for ourselves. To that end, we are
> meeting with Diversity, Equity, Inclusion (DEI) experts for guidance
> and will have recommendations to incorporate into the summit. Prior to
> the summit, we will send out some resources to look through ahead of
> time.
> 
> Who all are invited?
> 
> Git core contributors on https://lore.kernel.org/git/., anyone
> interested in teaching OSS projects about DEI.
> 
> If your network includes any groups or individuals who focus on
> educating others about DEI, you're welcome to invite them or contact
> summit organizers to learn more.  We prefer groups and individuals who
> are in the business of educating on inclusion, or if they are
> volunteers, already explicitly expressed their interest in
> volunteering rather than being asked, as we want to be very mindful of
> free emotional labor. A bonus for knowledge of inclusion in open
> source.  We can widen our understanding by asking non-Git contributors
> to come share their perspectives for some or all of the summit.

Hello, I'm only an occasional contributor to git since 2005;
but I have many concerns which don't seem be brought up.

I have several concerns about the increasing use of video
conferencing in Open Source development in general.

1. The data can potentially be used to feed facial and
   voice recognition (either by the host or some participant).

   I haven't allowed myself to be photographed in over a decade
   and never video conferenced.  I've also turned down countless
   professional and personal opportunities because of this, along
   with never flying due to invasive screenings at airports.

2. Even without the privacy perspective, I have some hearing loss
   and conversations can be difficult.  There's plenty of folks
   with more severe hearing loss than mine who'd be left out.

3. It seems much of the software used for video conferencing
   proprietary, even though Free (as in speech) alternatives exist.
   I don't know enough about this area but maybe others can chime
   in.

4. Finally, the hardware and bandwidth requirements for video
   streaming is high.  Poorer folks on slow computers or in areas
   with expensive bandwidth would also be left out.

   And one of the reasons I don't code as much as I used to is
   both gcc and clang are taking longer to compile with every
   release and our test suite isn't exactly fast.

So yes, I'd like these concerns addressed even though I'm not
willing to be on video or deal with JavaScript.  Thanks.


/me goes back to making public-inbox (and thus lore) faster on
 rusty old hardware...
