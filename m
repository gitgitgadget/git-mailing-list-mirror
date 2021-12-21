Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30309C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 16:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhLUQCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:02:49 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:41685 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhLUQCt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 11:02:49 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mzhbD-0004px-3t; Tue, 21 Dec 2021 16:02:47 +0000
Message-ID: <86c2d705-377b-380b-341c-a371b04ef917@iee.email>
Date:   Tue, 21 Dec 2021 16:02:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: taking a break from Git
Content-Language: en-GB
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/12/2021 16:38, Jeff King wrote:
> Hey all,
>
> I'm going to be offline and completely absent from the mailing list for
> five months starting at the end of December. After that, things are up
> in the air, but I may not be as involved in the project as I have been.

May I wish you a very happy Christmas, a great New Year and enjoyable break.

Thank you for all the contributions and help over the years, and it was
good to see you at Git Merge 2019 (seems so long ago now)

All the best

Philip

>
> Sorry, there's no juicy gossip or drama to share. I still like everyone,
> and think it's a cool project. ;) After 15 years, it just feels like
> it's time for a break and to perhaps apply my brain to something else
> for a while.
>
> There are a couple logistical things related to this:
>
>   - I'm planning to step down from Git's Project Leadership Committee
>     (the entity that represents Git within Software Freedom Conservancy,
>     and which occasionally makes decisions on things like our project
>     funds or assets like the trademark).
>
>     That leaves Junio, Ævar, and Christian on the PLC, and the charter
>     calls for having at least 3 members. So I don't technically need to
>     be replaced, but maybe it's an opportunity for somebody else to get
>     involved.
>
>     We don't have a formal process here. The last discussion on adding
>     new members was this thread from a few years ago:
>
>       https://lore.kernel.org/git/20180816224138.GA15490@sigill.intra.peff.net/
>
>   - I maintain the git-scm.com site (well, insofar as anybody does).
>     There are a few regulars who review and merge pull requests at
>     https://github.com/git/git-scm.com, but more help is always welcome
>     there.
>
>     The production parts of the site run on Heroku and Cloudflare. They
>     don't need touched often, though we do trigger a manual update and
>     flush the caches right after Junio releases, so that the site is
>     updated immediately.  The Git PLC has the necessary credentials for
>     those sites, though in practice I think I'm the only one there that
>     touched it. Taylor (cc'd) has been helping out with that and also
>     has access.
>
>     If you want to get involved, I'd suggest subscribing to the repo
>     linked above, and just helping out with issue/PR triage and
>     response.  And of course bug fixes, features, and content updates
>     are welcome, too. The README.md and ARCHITECTURE.md documents give
>     an overview.
>
>   - I really am going to stop reading the list. Even if you cc me. So
>     please don't get mad if I don't review your patches, or respond to
>     bug reports. :)
>
>     Likewise, I'll be around for a bit more, and am trying to wrap up
>     some personal topics and reviews. But undoubtedly I'll end up
>     dropping many on the floor. Though that probably would have happened
>     over the holidays anyway!
>
> -Peff

