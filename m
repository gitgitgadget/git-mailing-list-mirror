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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D1C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD9921475
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="ApjFdG/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgFPTCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:02:04 -0400
Received: from huan8.mail.rambler.ru ([81.19.78.7]:60322 "EHLO
        huan8.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgFPTCE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=G+KfQRF1OIEa+IGvOa7n731wr4NAgITEpGUEd5MsEv4=; b=ApjFdG/7zLaGlZC6DMYGBGxzSw
        pG7Px0oS2h2Fnp31lFn30bWXQ3X6puNm+/boFjQ6DZ38ae6fcIzH1WFFSsKcGZORNkmv7PPCQYBZj
        QVnyBYZhzLa58hlfP9wCTzW2qTlbdr6xBzJjmZrjdUcILfxzgEXjLcWAqeWvexk0aWoI=;
Received: from [UNAVAILABLE] ([194.190.114.28]:56852 helo=localhost)
        by huan8.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlGqP-0002lC-P0
        for git@vger.kernel.org; Tue, 16 Jun 2020 22:02:01 +0300
Date:   Tue, 16 Jun 2020 22:03:42 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616190342.GC27441@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <20200616100424.39718-1-alexsmith@gmail.com>
 <c0c2d9ad-1d67-8ebe-0063-524005ca97fe@whinis.com>
 <3cd5d8b9-a9f8-fbd1-f218-622f70e45566@whinis.com>
 <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
 <20200616142651.GA27946@legohost>
 <20200616160349.t65we3jkpq7hqwra@chatter.i7.local>
 <20200616172749.GB18874@legohost>
 <20200616174206.oana33736jkemyqs@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616174206.oana33736jkemyqs@chatter.i7.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 01:42:06PM -0400, Konstantin Ryabitsev wrote:
> > Because there are no such people. You try to fix non-existent problem.
> 
> We can reasonably expect that there will be a government decree coming 
> out tomorrow that will make it illegal to use non-cyrillic terminology 
> in government projects. You know this is entirely possible.

No. This is not possible. This is a fantasy.

> (Heck, every time we promote "pu" to "master" it can be seen as 
> politically charged commentary on current Russian events.)

"current Russian events" :-D? And what are these current events?

-- 
Олег Неманов (Oleg Nemanov)
