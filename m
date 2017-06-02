Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2F322027C
	for <e@80x24.org>; Fri,  2 Jun 2017 20:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbdFBUyk (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 16:54:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:34097 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdFBUyj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 16:54:39 -0400
Received: (qmail 3311 invoked by uid 109); 2 Jun 2017 02:07:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 02:07:58 +0000
Received: (qmail 24608 invoked by uid 111); 2 Jun 2017 02:08:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 22:08:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jun 2017 22:07:56 -0400
Date:   Thu, 1 Jun 2017 22:07:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Subject: Re: [PATCH v2] docs: fix formatting and grammar
Message-ID: <20170602020755.yiavhsorkm2pv4ki@sigill.intra.peff.net>
References: <20170601095520.GA25777@dinwoodie.org>
 <20170601103703.12216-1-adam@dinwoodie.org>
 <20170601155311.urqaxmjagqgiogmh@sigill.intra.peff.net>
 <xmqqr2z317st.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2z317st.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2017 at 10:45:38AM +0900, Junio C Hamano wrote:

> > ...I should have read to the end of the sentence. It should also be "in
> > the `$GIT_DIR/remotes/<origin>` file". Or just drop "file".
> 
> There is another one nearby.  Here is what I understand as your
> suggestion (the "just drop" variant), which I'll queue as SQUASH???
> on top of Adam's patch.

Yes, that's exactly what I meant (and the other looks good, too).
Thanks.

-Peff
