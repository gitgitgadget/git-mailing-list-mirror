Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0EF71F428
	for <e@80x24.org>; Wed, 15 Aug 2018 07:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeHOKDA (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 06:03:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44650 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeHOKDA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 06:03:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9E3A41F404;
        Wed, 15 Aug 2018 07:12:01 +0000 (UTC)
Date:   Wed, 15 Aug 2018 07:12:01 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Measuring Community Involvement (was Re: Contributor Summit
 planning)
Message-ID: <20180815071201.GA3169@dcvr>
References: <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
 <20180813210617.GA19738@sigill.intra.peff.net>
 <CAGZ79kaNa2bo31rQexs4rAH6bAz1rMzpxS3-fSFE6Cj87E8saw@mail.gmail.com>
 <20180813215431.GB16006@sigill.intra.peff.net>
 <3f0da3cd-0929-4aad-2c50-92c9d6c660e5@gmail.com>
 <20180814193646.GC28452@sigill.intra.peff.net>
 <CAGZ79kZYx-BOpx8SWeaP2Zskw0-OsSSVPZB4QJerAu9ST2swaA@mail.gmail.com>
 <20180814200611.GG28452@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814200611.GG28452@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Tue, Aug 14, 2018 at 12:47:59PM -0700, Stefan Beller wrote:
> > With the advent of public inbox, this is easy to obtain?
> 
> For our project, yes. But I was thinking of a tool that could be used
> for other projects, too.

Nothing prevents public-inbox from being adopted by other projects :)
Fwiw, Linux Foundation has LKML at https://lore.kernel.org/lkml
