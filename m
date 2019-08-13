Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0311F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 13:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfHMNks (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 09:40:48 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49463 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfHMNks (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 09:40:48 -0400
X-Originating-IP: 157.49.214.110
Received: from localhost (unknown [157.49.214.110])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 987C6FF807;
        Tue, 13 Aug 2019 13:40:45 +0000 (UTC)
Date:   Tue, 13 Aug 2019 19:10:43 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Call do_quit before destroying the main window
Message-ID: <20190813134043.7wgxiqainecpopzq@localhost.localdomain>
References: <20190804143919.10732-1-me@yadavpratyush.com>
 <b7cbe50d-879f-68b9-30b2-181c3058297f@yadavpratyush.com>
 <xmqqftmejgr1.fsf@gitster-ct.c.googlers.com>
 <549ad583-5ca1-7096-f4ce-10e8a836f7f9@yadavpratyush.com>
 <xmqq5zn8j25p.fsf@gitster-ct.c.googlers.com>
 <9a425bf6-1138-48db-3506-6bee1eff21ee@yadavpratyush.com>
 <xmqqa7ckhcc4.fsf@gitster-ct.c.googlers.com>
 <7a515181-d73f-f21c-a564-db5602d91e93@yadavpratyush.com>
 <xmqqftmacdj3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftmacdj3.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/19 01:03PM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
> >> If you meant to volunteer to act as a git-gui maintainer, that would
> >> be wonderful.  Then I do not have to play an interim maintainer.
> >
> > Yes, I do mean to volunteer to act as a git-gui maintainer.
> >
> > Is there something I should know other than
> > Documentation/howto/maintain-git.txt?
> 
> Well, I do not think that document has anything useful for being a
> maintainer for git-gui in it.
> 
> The Git community members needs to be able to trust that the new
> Git-gui maintainer would make a sensible decision when picking up
> (or asking to improve) a patch from the list to collect and forward
> to me.  We somehow need to make sure that happens.
 
Yes, but how? Of course, I don't intend to run this thing into the 
ground. I want the project to be useful for everyone. I only recently 
got involved with the project, and so most people here don't know me or 
my work that well. Maybe me contributing to the main git project can 
help. But other than that, the only way to build that trust is with 
time.

> It also is nice if we can get the handing over the maintainership
> endorsed by the current Git-gui maintainer.

Well, Pat has not replied to your email, so I don't think that will be 
possible.

> Compared to that, the procedural issues (how the patches are
> reviewed, when and how they are forwarded to me, etc.) are much less
> important.

Of course. But knowing them doesn't hurt :).

[0] 
https://public-inbox.org/git/CAP8UFD1C_FD5TLz0oyn6QzGU2rdvvTe6PNhpK29vkMfuHim-qg@mail.gmail.com/

-- 
Regards,
Pratyush Yadav
