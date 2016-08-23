Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFCB1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 15:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754225AbcHWPi3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 11:38:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:56172 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753918AbcHWPiD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 11:38:03 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LtIdP-1bATS62KqJ-012t3e; Tue, 23 Aug 2016 17:37:45
 +0200
Date:   Tue, 23 Aug 2016 17:37:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@drmicha.warpmail.net>
cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: [ANNOUNCE] Git for Windows 2.9.3
In-Reply-To: <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net>
Message-ID: <alpine.DEB.2.20.1608231736180.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox> <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com> <alpine.DEB.2.20.1608231553030.4924@virtualbox> <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wZ6Pm75X0RyPU89YPeqwEvtPp03SuluEcYQiqdniq3HjqUBVMym
 dlhzC7F6FrIZuVN/7yW0GF2K1BFQz9cjont7kmVwQPQo1zVMZJif5BoTj4Ck6nyIAHr6I5l
 YsBJRPR7Sks5FT+PsvbU1JDgU9YusihsHpB77NAYdt+ETng9jPkCGKxqwhshE7FzOyKq6ha
 9FVPebzKUyZDjx/6S99pg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eQYqV4pW0oU=:Z6bek68wJAJVGFS60fCv53
 IuxkSxYSA1E1W/gOSs3Jkte/6mTacszKys8kS3ychIHJpTPB5UW51GP36b0LSxwMKEOC3rarH
 9as00GhaY3NQ+GcM68Q1igKXcfg4JGHaQQdDKRryGfDV0d4uL2FQInZF1hk/4HGFhYupC1pgK
 gi1QUgn6+bJv30KszHk2coU3z8kVC47XPVV2UHdCql89IrCzeP149Zj81wGUafmo4IASB6Hf8
 0fgpMotpwMPV60GAV+SOp5/vVPQiEbVo5Va2NshOaG/Zok6oNqJL1MqIGRiNJ+aBA8q6yvT8T
 7OGlX+sAhbUNTrkVhry3pSYAgo5ohkKYVFTj0Zy9Lcl2ZTdBgpxOqEuCDHqL1WVaxJfOr4itf
 Pc9eVgTRDBgk2hvM9uyasSacvTjt8RM1RR0NTZLmEvTtR9iJCgLTzO+LHWZgdY5jyZ2UJyMmG
 wAMsnYpzJUzzhd5ZOhfRWrOfGOyJsj4yRawJ3BLM8pzqFk4iI4MHgpXPiNGWnd2onqIlpL7JY
 Tgia5e4vbmx3HSgS065tkN4A4jpWMUfMenlitTzpYYcy8QlUSr43GFTYBqPty6nnXLA8iZMzr
 d08Bp6Ecdx+IfEOJe5h6JWTB1+G3VClAGP3FM6YsO23DrFLbDx5l2gJ6WF14rMH+u6tbmFKMc
 XQRdgYNTTOoP3Pn7iVuS8gsTuI0ekcJdJf0SECZd1tcx+JRHliRJhPUOT0MyRW8V8yq9GmBS8
 yaRl0nOgs+gKVOAd6fuOe5r5dY5yYQGjqvqxOWXoI/DnDFtP2NCXdPt3aFslJ1kUtAUQbTvg6
 0WRsYft
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

On Tue, 23 Aug 2016, Michael J Gruber wrote:

> Maybe you want to re-read what you wrote to trigger his response, and
> consider adjusting your attitude ("I want this now so I'll release it in
> Git4Win") rather than the downstream name.

I am working *very* hard on improving the user experience of Git for
Windows. And yes, sometimes I have to include something in Git for Windows
versions that upstream Git does not include in the corresponding version
number.

I am really at a loss why you see fit to attack me about that.

Ciao,
Dscho
