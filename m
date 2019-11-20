Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23980C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 01:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DCB22311
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 01:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKTBuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:50:08 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54294 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfKTBuI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 20:50:08 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 38FDB1F4B5;
        Wed, 20 Nov 2019 01:50:08 +0000 (UTC)
Date:   Wed, 20 Nov 2019 01:50:08 +0000
From:   Eric Wong <e@80x24.org>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
Message-ID: <20191120015008.GB2864@dcvr>
References: <20191115230637.76877-1-emilyshaffer@google.com>
 <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com>
 <20191118214519.GH22855@google.com>
 <20191119184919.GM23183@szeder.dev>
 <nycvar.QRO.7.76.6.1911192227280.15956@tvgsbejvaqbjf.bet>
 <20191119214101.GN23183@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119214101.GN23183@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Tue, Nov 19, 2019 at 10:29:43PM +0100, Johannes Schindelin wrote:
> > On Tue, 19 Nov 2019, SZEDER Gábor wrote:
> > > git@vger is the ultimate source of all wisdom :) and it is openly
> > > accessible for anyone for writing,
> > 
> > ... except people with an @outlook.com address (all of their emails will
> > bounce) and people who do not know how to suppress HTML in their emails
> > (which I believe constitutes the vast majority)...
> 
> And I believe that that "vast majority" will never try to contribute
> to Git, and thus doesn't matter.

No.  A better objective would be to promote plain-text to the
point where the "vast majority" expect it.  Ironically, major
social networks and forums are already that way.  HTML mail can
become solely an avenue for phishers and spammers, and
eventually eradicated.  It'll be a long battle ahead, though...
