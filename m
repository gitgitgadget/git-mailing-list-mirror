Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BAD0206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbcLLTQH (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:16:07 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49586 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752198AbcLLTQH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:16:07 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8C01B206A4;
        Mon, 12 Dec 2016 19:16:05 +0000 (UTC)
Date:   Mon, 12 Dec 2016 19:16:05 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PULL] minor git-svn updates (probably for 2.11.x)
Message-ID: <20161212191605.GA24875@starla>
References: <20161212111320.GA25451@starla>
 <xmqqmvg1m197.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvg1m197.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Thanks; basing these two on top of "Start post 2.11 cycle" that is
> on 'master' would mean that this won't merge to 'maint' for 2.11.x,
> though.  I hope you wouldn't mind if I rebased them on top of
> 'maint' before merging?

Nope, wouldn't mind at all.

I was wondering if you preferred to cherry-pick them
individually since they're independent fixes.
