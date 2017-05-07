Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 209FE1F71C
	for <e@80x24.org>; Sun,  7 May 2017 22:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbdEGWo1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 18:44:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49798 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbdEGWo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 18:44:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BB931207F8;
        Sun,  7 May 2017 00:26:30 +0000 (UTC)
Date:   Sun, 7 May 2017 00:26:30 +0000
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
Message-ID: <20170507002630.GA15897@starla>
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
> > Samuel Lijin <sxlijin@gmail.com> wrote:
> >> Yep, I see these on public-inbox.org/git/ but not in my gmail inbox:
> >
> > Hi Samuel, check your Spam box (and move it to a normal inbox so
> > they can train it).  Gmail filters are known to trigger happy
> > and incorrectly flag messages.  It's been a problem on LKML,
> > too.
> 
> Sorry, should've been clearer - I did check my spambox in my original
> message. Some old patches from Brandon were in there, but the ones I
> mentioned in my original message just seem to have been dropped.

Yikes.  I wonder if Gmail automatically nukes messages if
they end up in enough Spam boxes...  Really hoping Googlers
can do something about this (or better, more people start
running their own SMTP servers, again).
