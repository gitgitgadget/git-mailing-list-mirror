Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_05,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B5CC433B4
	for <git@archiver.kernel.org>; Sun, 16 May 2021 09:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1AD86103E
	for <git@archiver.kernel.org>; Sun, 16 May 2021 09:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhEPJCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 05:02:53 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38837 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhEPJCw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 05:02:52 -0400
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 45F761C0002;
        Sun, 16 May 2021 09:01:35 +0000 (UTC)
Date:   Sun, 16 May 2021 14:31:33 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Allan Ford <allan.ford17@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: Git Gui - Searching for in Google
Message-ID: <20210516090133.xe2cooqzr2knyt46@yadavpratyush.com>
References: <CAL-6oQo3KDrrw+DiQsJJR_2tMjrLY3xu5ARJz0SJJ-naQqo8Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL-6oQo3KDrrw+DiQsJJR_2tMjrLY3xu5ARJz0SJJ-naQqo8Rw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/05/21 07:17PM, Allan Ford wrote:
> Dear Git Community,
> 
> Just a thought and suggestion ..
> 
> Git Gui comes with Git download .. (remember this now ..)
> 
> https://git-scm.com/downloads states this in text.
> https://git-scm.com/downloads/guis states this in text.
> 
> 
> However .. If a person is using Google and searching for Git Gui
> download am thinking a picture of what Git Gui interface looks like
> would help flag to the searcher that they are in the right place ! ?
> 
> I.e. https://git-scm.com/downloads/guis has pictures of all the other
> GUI Clients .. but not git gui !
> 
> Git Gui has the recognizable vertical Git in large Grey Red and Green letters ..
> 
> What do you think ?
> Can we add a picture of Git Gui interface to either
> https://git-scm.com/downloads or https://git-scm.com/downloads/guis ?

I think this would be a good idea. I have added Jeff in Cc who I think 
maintains the git-scm.com website at [0]. Please create a Pull Request 
there to add the screenshots.

[0] https://github.com/git/git-scm.com

-- 
Regards,
Pratyush Yadav
