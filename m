Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D543C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 11:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5C361363
	for <git@archiver.kernel.org>; Fri, 21 May 2021 11:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhEUL1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 07:27:25 -0400
Received: from ikke.info ([178.21.113.177]:58392 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhEUL1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 07:27:25 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 May 2021 07:27:24 EDT
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id ACC2C440108; Fri, 21 May 2021 13:19:37 +0200 (CEST)
Date:   Fri, 21 May 2021 13:19:37 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
Message-ID: <YKeXSYjPFz7iBi+3@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com>
 <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
 <xmqqwnrtt84s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwnrtt84s.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 06:20:19AM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > decision. Likewise for irc. I don't think #git or even #git-devel has
> > any official status. It is simply where people doing things chose to go.
> > Now they may choose to go somewhere else, but they don't necessarily
> > have to do it as a unit.
> 
> FYI I contacted https://libera.chat/ to register "as a project",
> primarily to prevent other folks squat on #git and #git-*; if we
> decide to move our bi-weekly "Git Standup" there, it may turn out to
> be useful.
> 
> 

Thanks. #alpine-devel has already been handed over to Jonathan Nieder,
but #git is not managed by anyone (no operators in the channel).

Fixing this would indeed require registering as a project.

Kevin
