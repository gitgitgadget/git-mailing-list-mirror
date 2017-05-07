Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263071F9A9
	for <e@80x24.org>; Sun,  7 May 2017 22:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756711AbdEGWJc (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 18:09:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45666 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756069AbdEGWJb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 18:09:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E1E7B1FE2A;
        Sun,  7 May 2017 12:41:58 +0000 (UTC)
Date:   Sun, 7 May 2017 12:41:58 +0000
From:   Eric Wong <e@80x24.org>
To:     meta@public-inbox.org
Cc:     Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: vger not relaying some of Junio's messages today?
Message-ID: <20170507124158.GA15706@starla>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
 <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com>
 <20170506205041.GA26189@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170506205041.GA26189@starla>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> (OTOH, I noticed a thread/mbox download bug in public-inbox,
> https://public-inbox.org/git/xmqqmvaq702u.fsf@gitster.mtv.corp.google.com/t.mbox.gz
> only shows two messages out of many.   Will need to fix that...)

I think I fixed that bug, at least:
https://public-inbox.org/meta/20170507110328.GA20102@whir/

And vger is still down...
