Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37BC12047A
	for <e@80x24.org>; Fri, 19 Aug 2016 22:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755108AbcHSWfe (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 18:35:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52248 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754617AbcHSWfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 18:35:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C6BC81F859;
        Fri, 19 Aug 2016 22:35:32 +0000 (UTC)
Date:   Fri, 19 Aug 2016 22:35:32 +0000
From:   Eric Wong <e@80x24.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        meta@public-inbox.org, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160819223532.GA19084@starla>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160818204902.GA1670@starla>
 <alpine.DEB.2.20.1608191720040.4924@virtualbox>
 <CAGZ79kb9x6RHdFeA8WXpq4NFYr-G+B1R7_8u883LO8zvPyr+CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb9x6RHdFeA8WXpq4NFYr-G+B1R7_8u883LO8zvPyr+CQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:
> Maybe we should invent a patch format that copes with broken whitespace?

No redundant new formats, please.  MIME attachments are already
widely-supported and fine by me.  But it's not my call for git.
