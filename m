Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE7AB1F428
	for <e@80x24.org>; Thu, 30 Aug 2018 07:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeH3LV2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:21:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50514 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbeH3LV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:21:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0A7311F404;
        Thu, 30 Aug 2018 07:20:44 +0000 (UTC)
Date:   Thu, 30 Aug 2018 07:20:43 +0000
From:   Eric Wong <e@80x24.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Thank you for public-inbox!
Message-ID: <20180830072043.GA14514@dcvr.yhbt.net>
References: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
 <20180829050745.GD15274@sigill.intra.peff.net>
 <20180829100243.GA28180@dcvr>
 <20180830033000.GD665@sigill.intra.peff.net>
 <20180830035609.GA140348@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830035609.GA140348@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jeff King wrote:
> 
> > I guess I just wonder if I set up a mirror on another domain, would
> > anybody actually _use_ it? I'd think most people would just go to
> > public-inbox.org as the de facto URL.
> 
> If it's faster than public-inbox.org and you don't mind the traffic I
> would send, then I'll use it. :)

Is performance a problem on public-inbox.org for you?

It should be pretty fast, but maybe there's corner-cases
and I haven't had time to pay close attention, lately...

I've also been sorta considering downgrading to a $5/month VPS
(from a $20/month VPS) to force myself to pay more attention to
performance while saving myself a few bucks.  But I wouldn't get
to dogfood on SMP, anymore...
