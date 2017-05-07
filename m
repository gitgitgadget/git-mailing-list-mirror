Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B4171F71C
	for <e@80x24.org>; Sun,  7 May 2017 22:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754309AbdEGWO2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 18:14:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46182 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752139AbdEGWO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 18:14:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5CFC61F71C;
        Sun,  7 May 2017 01:05:37 +0000 (UTC)
Date:   Sun, 7 May 2017 01:05:37 +0000
From:   Eric Wong <e@80x24.org>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Jonathan Tirado <tiradojonathan32@gmail.com>,
        Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        meta@public-inbox.org
Subject: Re: vger not relaying some of Junio's messages today?
Message-ID: <20170507010537.GA21703@starla>
References: <v26esrmyqyqykypjs75fx2vy.1494092763967@email.android.com>
 <CAJZjrdWYDMFHRrbeFk89p+GebLpWJBUQfnpC6w87aVh8czL5_w@mail.gmail.com>
 <20170506205041.GA26189@starla>
 <CAJZjrdXPgrSAHJPsQiW756XFK1-XyGY0skJTefczaqJpOy6yKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdXPgrSAHJPsQiW756XFK1-XyGY0skJTefczaqJpOy6yKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> wrote:
> Sorry, should've been clearer - I did check my spambox in my original
> message. Some old patches from Brandon were in there, but the ones I
> mentioned in my original message just seem to have been dropped.

Apparently, vger also throttles mail to gmail aggressively, so
maybe some show up eventually:

https://marc.info/?i=20170501.105057.824365162373797902.davem@davemloft.net



On a side note, I just started trying the "mutt-patched"
package in Debian stable.  It looks like "mutt" package will
absorb it's functionality in future releases, but maybe more
mutt users can have NNTP support in their favorite MUA :)
