Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9D6C433E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DB320714
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 10:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgG1KH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:07:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54318 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbgG1KH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 06:07:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A9A1F1F5AE;
        Tue, 28 Jul 2020 10:07:26 +0000 (UTC)
Date:   Tue, 28 Jul 2020 10:07:26 +0000
From:   Eric Wong <e@80x24.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Carmen Andoh <candoh@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git Inclusion Summit
Message-ID: <20200728100726.GA24408@dcvr>
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
 <20200726040226.GA19030@dcvr>
 <20200727151023.GB62919@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727151023.GB62919@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

<snip>

> I think that it's tough to make individuals on both sides of this feel
> comfortable. On the one hand, folks such as yourself may feel
> uncomfortable with this format for the reasons that you posted above. On
> the other hand, some folks may prefer audio or video instead of text
> because they find it easier to express themselves with their body
> language, intonation, etc.

I can understand that.  However most coding nowadays (especially
for this project) is text, so that's already the lowest common
denominator.

> A bare minimum seems to be using a free service (I know that Jitsi Meet
> is an often-recommended alternative) with support for joining without
> video (either using audio only, or participating over chat).
> 
> Hopefully everybody should have a good-enough internet connection to
> stream a low-quality audio-only feed so that they can listen in and
> participate via the chat feature. This is what we did at the
> Contributor's Summit in March (I know we had a number of text-only
> participants in time-zones where it was late, etc.).
> 
> What are your thoughts?

Jitsi w/ audio-only certainly seems to be a step in the right
direction and would be more inclusive.

Is there any speech-to-text transcription done for the hearing
(or extremely bandwidth) impaired?

It'd ideally go to #git on IRC (or something that doesn't
require a browser to trigger swap storms on old systems).

Even for people with good hearing, acceptable audio quality for
speech seems tricky to get right, being dependent on mics,
bandwidth, codecs, background noise, speaker/earphone quality,
etc.
