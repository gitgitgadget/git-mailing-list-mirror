Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17ACC433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873EE20776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 12:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="BaPmc1uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFPMPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:15:12 -0400
Received: from huan10.mail.rambler.ru ([81.19.78.9]:33914 "EHLO
        huan10.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPMPL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 08:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=Zyt2VOCf5sf0ZYonLbV6BuQrgOsbEOZePXOGPPnT1Oc=; b=BaPmc1ufYwQ2rPj//F2idxuVqN
        maZgvNNmL+NM5gSzFGotB6dPV5iLMpnO/lpSV0jmmcyhxzPziyxR5EzHaVPrDeafeX+TwQk0cdmBX
        MwQ8xJRTIijQx8s+BBqMzUqtQkZixlu9yh8z763a6DW/EaM+3xSP8eSJX+mUsJOrV/pY=;
Received: from [UNAVAILABLE] ([194.190.114.28]:46700 helo=localhost)
        by huan10.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlAUf-0006Mm-Sr
        for git@vger.kernel.org; Tue, 16 Jun 2020 15:15:10 +0300
Date:   Tue, 16 Jun 2020 15:16:51 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616121631.GA26959@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <20200616100424.39718-1-alexsmith@gmail.com>
 <c0c2d9ad-1d67-8ebe-0063-524005ca97fe@whinis.com>
 <3cd5d8b9-a9f8-fbd1-f218-622f70e45566@whinis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cd5d8b9-a9f8-fbd1-f218-622f70e45566@whinis.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 07:38:33AM -0400, Whinis wrote:
> > Whether or not any patch would be accepted, the damage is already done.
> >  From now on, people will judge you if you dare to use the name "master" anywhere
> > and this is incredibly sad. These people are literally bullying us into
> > submission in the name of political correctness where no harm was actually
> > done.
> >
> > This sickens me.
> Not just that, any twitter use can complain and get entire communities 
> to throw out all rules on changes to appear to be on the "right" side. 
> If anyone submitted a patch to change any functioning name without good 
> reason, especially one assumed to never change and would likely break a 
> significant number of external processes it would be denied without 
> second thought. Here the entire thread didn't ask should we change it 
> but instead started on the premise, even though this is documented 
> throughout the world and millions or even billions of scripts and 
> programs assume it to be constant, it must change without discussion.

Some people don't think about it. They not engeeners, they are linguistic
racist. May be it time to fork git... and place it somewhere where people
are better educated, more democratic and not so totalitarian to words.

> Not just that the entire process has become a laughing stock that the 
> tech community seriously believes anyone has a problem with 'master' but 
> even worse that it will somehow fix something in the world. You can find 
> no shortages of post on forums and websites of people wondering what 
> exactly is trying to be accomplished.While not done here presumably due

I'll tell you more. On almost every non-english forum you can see that
users wonder about this incredibly stupid process :-).
And you are right. Anywhere in the world, outside US, this looks like a laughing
stock :-). All people just sit near their monitors with popcorn and looking
what else crazy white americans will do with all production stuff to which they
have access.

Actually, it's sad like any obscurantism.

-- 
Олег Неманов (Oleg Nemanov)
