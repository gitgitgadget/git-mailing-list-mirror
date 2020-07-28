Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A240C433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304CB207FC
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgG1Qo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:44:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:39934 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgG1Qo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:44:56 -0400
Received: (qmail 27778 invoked by uid 109); 28 Jul 2020 16:44:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 16:44:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26619 invoked by uid 111); 28 Jul 2020 16:44:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 12:44:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 12:44:54 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Taylor Blau <me@ttaylorr.com>, Carmen Andoh <candoh@google.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git Inclusion Summit
Message-ID: <20200728164454.GA2650362@coredump.intra.peff.net>
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
 <20200726040226.GA19030@dcvr>
 <20200727151023.GB62919@syl.lan>
 <20200728100726.GA24408@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728100726.GA24408@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 10:07:26AM +0000, Eric Wong wrote:

> > Hopefully everybody should have a good-enough internet connection to
> > stream a low-quality audio-only feed so that they can listen in and
> > participate via the chat feature. This is what we did at the
> > Contributor's Summit in March (I know we had a number of text-only
> > participants in time-zones where it was late, etc.).
> > 
> > What are your thoughts?
> 
> Jitsi w/ audio-only certainly seems to be a step in the right
> direction and would be more inclusive.
> 
> Is there any speech-to-text transcription done for the hearing
> (or extremely bandwidth) impaired?
> 
> It'd ideally go to #git on IRC (or something that doesn't
> require a browser to trigger swap storms on old systems).

Whether we have automatic speech-to-text conversion or not, I think it
would be good for people involved to take and publish notes summarizing
the conversation. One of the important things about our usual async
written communication is that it gives people time to organize their
thoughts and say what they want succinctly. Live conversations are often
full of false starts and rambling. That's OK, and a necessary part of
the process. But if you want a wider audience to follow along, it helps
to turn that into something more time efficient for readers.

-Peff
