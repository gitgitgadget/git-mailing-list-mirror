Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D39C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5BD208DB
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="EW55k/3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgFRI1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:27:18 -0400
Received: from huan6.mail.rambler.ru ([81.19.78.5]:53526 "EHLO
        huan6.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgFRI1R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 04:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=EoxEGWCW5p/jJluYiSEAJUMpJkj+BhsiW/bcLhwOPlc=; b=EW55k/3M5M6DYyIhYwlrJbfD2L
        sTVOeJHMWktvfOQEaSMdf5MlAalLIPNvyK/flICuMGHf08M4HQdfy3Y2AsruyhW5CNeQZSbzLxI3e
        8FrPN6c0jlvybZ0THqHv9uiN9l++YpQCdXfn9QJ8gnYF+YevgoS7eyQAEFPWLubfd6I0=;
Received: from [UNAVAILABLE] ([194.190.114.28]:47200 helo=localhost)
        by huan6.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jlptD-0003c2-L6
        for git@vger.kernel.org; Thu, 18 Jun 2020 11:27:15 +0300
Date:   Thu, 18 Jun 2020 11:28:57 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200618082857.GA20837@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <20200617074940.GB18445@legohost>
 <20200617204842.23344-1-zeevriend@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617204842.23344-1-zeevriend@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 10:48:42PM +0200, ZeeVriend wrote:
> Thanks for your feedback. I have no knowledge from cyrillic so it is nice to hear from you! As a fact, in French "zero" also has
> bad meanings. But, positive meaning exist also. Building up from nothing as example I give you.

A positive meaning exist for any word ;-).

> Now if my suggestions are not ok we can try something else. I thought alternatives can be "source" and "root". Both are used A LOT
> by programmers everywhere so possible they all agree! Let me tell you "source" has EXACT same meaning in French, I like it a lot.
> We all write 'source code' is not?

Not all of us :-). Somebody try to play in politics games, instead of coding.

> Maybe you have other words to describe this. We can all share the best words and select the best agreement. A true inclusive collaboration
> from all!

Yes, i have one - "master". It's used about 15 years by millions of developers
and projects. I think this is a best portfolio ever. Other words we are
discussing already show drawbacks. We have no one ideal word :-). In any case,
this is not matter. Nor my or you opinion. There are some white people with
conscience problems and they try to solve it in such a strange way. After that,
they willn't become better, but they think they will. Code and the rest of
humanity just victims in this situation.

> Let me wish you a good day and happy moments next!

Thanks. But i don't see any happy moments here.

-- 
Олег Неманов (Oleg Nemanov)
