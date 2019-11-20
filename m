Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095B5C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 19:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4CD21882
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 19:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfKTTz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:55:56 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42810 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfKTTz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 14:55:56 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 431A61F4B5;
        Wed, 20 Nov 2019 19:55:56 +0000 (UTC)
Date:   Wed, 20 Nov 2019 19:55:56 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: Re: This list is now also archived on lore.kernel.org/git
Message-ID: <20191120195556.GA25189@dcvr>
References: <20191120154347.x6w4v7cdzy4yrx6q@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120154347.x6w4v7cdzy4yrx6q@chatter.i7.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> Hi, all:
> 
> I used Eric's public-inbox.org archives to set up our own copy on 
> lore.kernel.org and identical list archives are now available on that 
> server.

Almost :)  I forget it exists, but there's the "gmane:$ARTICLE_NUM"
altid mapping search support on my server for legacy gmane URLs.

Instructions to set it up:
https://public-inbox.org/meta/20160811002348.9719-1-e@80x24.org/

> I spoke with Eric and he recommends that official project documentation 
> starts using lore.kernel.org/git URLs in daily use and git's official 
> documentation in order to allow him more freedom of decision when it 
> comes to hosting his equipment. The URLs at both domains remain the 
> same, e.g.:

Yup,  .org TLD renewal costs will likely go up and I won't pay
higher costs to keep .org domains.

The system running public-inbox.org (and the recommended
onions(*)) will stay running and will have bleeding edge
code on it.



* Accessible via Tor, no need to depend on registrars:
  http://hjrcffqmbrq6wope.onion/
  http://ou63pmih66umazou.onion/
  http://czquwvybam4bgbro.onion/
