Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32B1C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 08:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2008F2088E
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 08:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rambler.ru header.i=@rambler.ru header.b="axJcxfH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389108AbgFXIRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:17:51 -0400
Received: from huan7.mail.rambler.ru ([81.19.78.6]:39880 "EHLO
        huan7.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbgFXIRv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 04:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rambler.ru;
         s=mail; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:To:From:Date;
        bh=4/pDLLa/a3X2vWC0BH6RhUx6GSCM2hQENtcC0G98/1s=; b=axJcxfH06Py9c1Rys7vFASOxKZ
        qdzz5+SkDEYYz336uHfSWwcPUDcOvZqtkuj4Ihyg0ToUiJsjtYvcTfObR/9A0XDp82/NG2xhvrokG
        nBqPapZVPxvg/Azd+W6NFOFSf51M6wUKLrrRL6AfCXI+uBYZ+dsDNo140eb8s7fVLEeI=;
Received: from [UNAVAILABLE] ([194.190.114.28]:44878 helo=localhost)
        by huan7.mail.rambler.ru with esmtpa (Exim 4.86_2)
        (envelope-from <lego_12239@rambler.ru>)
        id 1jo0bM-0002Se-T4
        for git@vger.kernel.org; Wed, 24 Jun 2020 11:17:49 +0300
Date:   Wed, 24 Jun 2020 11:19:35 +0300
From:   lego_12239@rambler.ru
To:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200624081907.GA32753@legohost>
Reply-To: lego_12239@rambler.ru
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <CAAOnFsNUB_+NZMGnu2yasL8tk_KTfqPY6JiHOpvYHiyY_Lytrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAOnFsNUB_+NZMGnu2yasL8tk_KTfqPY6JiHOpvYHiyY_Lytrw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Rambler-User: lego_12239@rambler.ru/194.190.114.28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 24, 2020 at 01:21:32AM +0200, Gunnar Liljas wrote:
> at least give some pause. A common reaction seems to be something like
> what @SpeedKicks (a software engineer in the "target group") tweeted:
> 
> "Reading a thread of white people, including the CEO of GitHub,
> advocating changing the name of the ‘Master’ branch to make black devs
> more comfortable...
> 
> is the most racially uncomfortable I've ever felt about GitHub."

Yes. That's sad. This is the real problem. Devs of some projects, whether
they understand this or not, work as provocateurs and incite hatred between
people. Their actions hurt black people. After that, black people will
feel that almost everyone hates them(because it was done "for them"). But i
don't think devs are so evil. They are just computer nerds/geeks and complete
idiots in social sphere. They don't understand the consequences of their
actions and just a toy in politics game.

-- 
Олег Неманов (Oleg Nemanov)
