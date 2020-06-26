Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B76BC433E1
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 10:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2207C20768
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 10:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="bOyCX65m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgFZKcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:32:43 -0400
Received: from huan5.mail.rambler.ru ([81.19.78.4]:43084 "EHLO
        huan5.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgFZKcm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 06:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=PvAmh6X9RB5FhnSvlxbb1Kd6MupoQtKgp+b4n77JFcY=; b=bOyCX65m05yd+9BpkVuloBoNDc
        Jgr/mIbzpPkWZP3/U+26xYxaOEilrUSkGZYF+l+RWkWxjnZQLnNDXrmkByCAX7ponF/hMomYXbymh
        N6r1x4crwdsdZYVPpbBkdUvRw0jbTakS9ma+p6NIamrxwWUfbb7hALsbQATyYuBSZ0Ec=;
Received: from [UNAVAILABLE] ([194.190.114.28]:53458 helo=localhost)
        by huan5.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1joley-0002N7-9X
        for git@vger.kernel.org; Fri, 26 Jun 2020 13:32:40 +0300
Date:   Fri, 26 Jun 2020 13:34:27 +0300
From:   Oleg <lego_12239@rambler.ru>
To:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200626103427.GA28732@legohost>
Reply-To: Oleg <lego_12239@rambler.ru>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <CAAOnFsNUB_+NZMGnu2yasL8tk_KTfqPY6JiHOpvYHiyY_Lytrw@mail.gmail.com>
 <20200624081907.GA32753@legohost>
 <CAAOnFsM9cruRPV9mNgu=ANk+5xG6Q77S6pW+ZBQJOZewjw0yiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAOnFsM9cruRPV9mNgu=ANk+5xG6Q77S6pW+ZBQJOZewjw0yiQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 12:08:30PM +0200, Gunnar Liljas wrote:
> On Wed, Jun 24, 2020 at 10:19 AM <lego_12239@rambler.ru> wrote:
> > Yes. That's sad. This is the real problem. Devs of some projects, whether
> > they understand this or not, work as provocateurs and incite hatred between
> > people. Their actions hurt black people. After that, black people will
> > feel that almost everyone hates them(because it was done "for them").
> 
> I don't think many would feel that. More like that everyone ignores

Almost all of adequate people. What else they should think? In situation where
devs, instead of stay away from hype, say to millions: "we will broke program
you use, because of them". And every adequate people understand that this is
stupid action(any man with any skin color), but only black people is the
declared "cause" of this actions. Naturally, they do not feel comfortable.


-- 
Олег Неманов (Oleg Nemanov)
