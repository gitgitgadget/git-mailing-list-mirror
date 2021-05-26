Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8147C47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 20:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16DC613ED
	for <git@archiver.kernel.org>; Wed, 26 May 2021 20:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhEZUCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 16:02:46 -0400
Received: from ikke.info ([178.21.113.177]:34494 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234600AbhEZUCh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 16:02:37 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id E0BAD440102; Wed, 26 May 2021 22:01:02 +0200 (CEST)
Date:   Wed, 26 May 2021 22:01:02 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
Message-ID: <YK6o/j7P0JIGW0Q0@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com>
 <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net>
 <YK6XvmrtrdkJvsnI@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK6XvmrtrdkJvsnI@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 02:47:26PM -0400, Taylor Blau wrote:
> On Thu, May 20, 2021 at 01:19:02PM -0400, Jeff King wrote:
> > So if there is a critical mass of useful people that will hang out on
> > the Matrix equivalent of #git (or whatever other tool), then that may
> > become a new place. And people who want to do that should let people
> > know where they can be found (whatever happens, I'd appreciate a PR to
> > https://github.com/git/git-scm.com updating the "Community" page).
> 
> Emily tweeted today [1] that the #git channel on Freenode has been taken
> over (presumably for violating their guideline that channels not mention
> Libera in their description).
> 
> So using Libera seems like a good idea (although I agree that there is
> no "official" place to go, and this is more about making people aware of
> the new status-quo). In that case, here's a PR to update the "Community"
> page on git-scm.com:
> 
>     https://github.com/git/git-scm.com/pull/1607
> 
> Thanks,
> Taylor
> 
> [1]: https://twitter.com/nasamuffin/status/1397619871278530560

We still manage #git, but #git-devel has been deowned and redirected to
##git-devel.

In the mean time, the ircops on libera helped us to register #git there
pending the official namespace registration from Junio (they have a
backlog, so they are working through that).


