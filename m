Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57282C3E8C5
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D2B248EB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgKRRne (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 12:43:34 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:46079 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgKRRnc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 12:43:32 -0500
Received: from localhost (unknown [103.82.80.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 3C7FA100005;
        Wed, 18 Nov 2020 17:43:29 +0000 (UTC)
Date:   Wed, 18 Nov 2020 23:13:27 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Dimitriy <dimitriy.ryazantcev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-gui: update Russian translation
Message-ID: <20201118174327.djyugsjxstrjeo46@yadavpratyush.com>
References: <20201106184904.7196-1-dimitriy.ryazantcev@gmail.com>
 <CAPUT4mR75M6138MVUdb_=ag0aG9MdrLbj-PgwP7y7J+2fv4zLw@mail.gmail.com>
 <20201118122814.kvt2zjt4kp4rudgh@yadavpratyush.com>
 <CAPUT4mTkcuY_mUv6Nf0ChPiay4C5c+imu_xo1br9ZhMFKTA40g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPUT4mTkcuY_mUv6Nf0ChPiay4C5c+imu_xo1br9ZhMFKTA40g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/11/20 05:27PM, Dimitriy wrote:
> Hi Pratyush,
> 
> > It must have slipped through the cracks because I don't remember seeing
> > this at all.
> 
> Seems I forgot to add you as CC into the original email.
> 
> > Can you please explain in more detail what you "updated". I don't know
> > Russian, and I don't know any Russian speakers willing to review this
> > patch. So a brief description of what you change will make me a little
> > more comfortable merging this patch.
> 
> Actually I don't know what to say regarding "whats updated" - I just
> updated an outdated translation.

What I mean is, did you fix any incorrect translations or just 
translated the new strings introduced since the last translation update?
 
> > Also, please don't redirect people to this website. If you _are_
> > interested in maintaining the Russian translation long term, let's do it
> > here on this list :-)
> 
> I am already maintaining Git Russian translation (po/TEAMS in git
> repo) and doing actual editing online via that website - just added a
> link so people could know where they can submit corrections.
> If you want I can remove that from the commit message.

I would prefer having discussions here, but if that platform makes it 
easier for you to collaborate and work on translations, I have no 
objections.

-- 
Regards,
Pratyush Yadav
