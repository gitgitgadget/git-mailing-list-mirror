Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9DDC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 07:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A64E60BD3
	for <git@archiver.kernel.org>; Thu, 20 May 2021 07:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhETHNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 03:13:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhETHNE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 03:13:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06E17B016;
        Thu, 20 May 2021 07:11:43 +0000 (UTC)
Date:   Thu, 20 May 2021 09:11:41 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
Message-ID: <20210520071141.GZ8544@kitsune.suse.cz>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YKViF9OVLeA95JPH@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 12:08:07PM -0700, Jonathan Nieder wrote:
> Hi,
> 
> Emily Shaffer wrote[0]:
> 
> > Seems like there's been some kerfuffle with Freenode staff and new
> > ownership[1][2][3]. What does this mean for Git project? I think #git
> > on Freenode isn't maintained by Git developers directly, right?
> 
> https://gitirc.eu/ involved a lot of work by Jan Krüger (thanks!), so
> cc-ing him since he likely knows who else is active there.
> 
> [...]
> >                                                             We do
> > theoretically keep up #git-devel on Freenode, though it's largely
> > silent. Should we be worrying? Migrating?
> 
> The main practical struggle on #git-devel has been spam.  I don't know
> that any particular IRC network is better at spam prevention than
> others.
> 
> It looks like most of the Freenode admins have moved to
> https://libera.chat/, so that would be a close equivalent.  Another
> alternative is OFTC <https://www.oftc.net/>, which is used by
> irc.debian.org, for example.
> 
> There are also other real-time chat programs such as Zulip (open
> source, used in Outreachy), Discord (used by LLVM), and Slack (used by
> Chromium); each has its benefits and flaws.

Or Matrix used by Mozilla, GNOME, and others.

Unlike the others Matrix intends to be not just a chat application
(opensource or proprietary) but open standard which has multiple
implementetions of both the server and the client.

In that way it is the most flexible option allowing communication
between people with different UX preferences.

Thanks

Michal
