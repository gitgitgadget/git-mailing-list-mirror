Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3FEC2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F93A613B6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 14:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhE1Old convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 28 May 2021 10:41:33 -0400
Received: from vps.thesusis.net ([34.202.238.73]:43902 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhE1Olc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 10:41:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 6DC5B23DE4;
        Fri, 28 May 2021 10:39:57 -0400 (EDT)
Received: from vps.thesusis.net ([IPv6:::1])
        by localhost (vps.thesusis.net [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id yqAWU85dY5Ap; Fri, 28 May 2021 10:39:57 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 2D2E523DE2; Fri, 28 May 2021 10:39:57 -0400 (EDT)
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com> <YKViF9OVLeA95JPH@google.com> <20210520071141.GZ8544@kitsune.suse.cz> <YKaaBj0KmJ3K5foC@coredump.intra.peff.net> <YK6XvmrtrdkJvsnI@nand.local> <YK6o/j7P0JIGW0Q0@alpha> <7e9683aee2c0fea2ff77b82bfa547e15@jk.gs> <87im33ltqr.fsf@evledraar.gmail.com> <b8e48d464858c0ef6da2629dab507ebc@jk.gs>
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Kevin Daudt <me@ikke.info>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Should we do something with #git-devel on Freenode?
Date:   Fri, 28 May 2021 10:37:36 -0400
In-reply-to: <b8e48d464858c0ef6da2629dab507ebc@jk.gs>
Message-ID: <87k0niapmq.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Jan Krüger writes:

> If that was all that had happened, I would totally agree. Unfortunately,
> they did quite a bit more than that. They made a script that
> automatically ran the following actions on channels that mentioned
> "libera" in the topic:
>
> * sent a vague message about a ToS violation to the channel;
> * dropped the registration, including the full access list;
> * set the channel to moderated;
> * removed all ops;
> * set an auto-forward to a similarly named topic channel (e.g.
>    #git-devel forwarded to ##git-devel);
> * made no attempt to give control of the topic channel to the previous
>    community, i.e. the new channel would usually end up completely
>    op-less and thus impossible to register at all. If it had been
>    squatted by unrelated people beforehand, it would stay in their
>    control.

Oh wow.  That's crossing a line for me.


