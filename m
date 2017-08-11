Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53C6A20899
	for <e@80x24.org>; Fri, 11 Aug 2017 20:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbdHKUln (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 16:41:43 -0400
Received: from [195.159.176.226] ([195.159.176.226]:33270 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbdHKUln (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 16:41:43 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1dgGkQ-0003KF-5K
        for git@vger.kernel.org; Fri, 11 Aug 2017 22:41:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Harry Putnam <reader@newsguy.com>
Subject: Re: Not understanding with git wants to copy one file to another
Date:   Fri, 11 Aug 2017 16:41:32 -0400
Organization: Still searching...
Message-ID: <87shgx3khv.fsf@local.lan>
References: <87mv7773tp.fsf@local.lan>
        <CAGZ79kbgb2P7KT_b9xuMj1pN1+jsPfH7YSJNDyDB5dY3cwXCQg@mail.gmail.com>
        <87efsj70d7.fsf@local.lan>
        <CAGZ79kZN1-DuiaS=bFgNUXBonAR3BHqtAFSqoJ+MJ4esMdmz-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.50 (gnu/linux)
Cancel-Lock: sha1:2zSHj+xo/Jjogh2zL+0IQB1/IPI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:


[...]

> Ah. Sorry for confusing even more.
> By pointing out the options for git-diff, I just wanted to point out that
> such a mechanism ("rename/copy detection") exists.


[...]

>> What am I missing?
>>
>
> https://www.reddit.com/r/git/comments/3ogkk1/beginner_disable_rename_detection/
>
> "Rename detection is just GUI sugar".

Thanks there is a nice full explanation at the cited url.

What is still a bit puzzling is that in that same commit, there are
files that are true copies of each other, just in different locations,
But nothing pops up about them in a git commit.


