Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62ED1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 15:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390576AbfIXPui (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 11:50:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:58416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388230AbfIXPuh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 11:50:37 -0400
Received: (qmail 7859 invoked by uid 109); 24 Sep 2019 15:50:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 15:50:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9966 invoked by uid 111); 24 Sep 2019 15:52:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2019 11:52:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Sep 2019 11:50:36 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, git@sfconservancy.org,
        Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
Message-ID: <20190924155036.GA5318@sigill.intra.peff.net>
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <20190924090152.GA7209@szeder.dev>
 <nycvar.QRO.7.76.6.1909241426580.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1909241426580.15067@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 03:20:42PM +0200, Johannes Schindelin wrote:

> > If diversity and inclusion of other cultures is indeed a priority,
> > then we should carefully consider that some potential contributors
> > will rather choose not to contribute because of a CoC like this.
> 
> Let me be blunt for a minute. The proposed CoC would not change anything
> for any contributor I consider decent. Not one thing. There would not be
> any need to change any behavior, no need to complain, they could just
> read the CoC and say: "Yep, that's right, that's exactly how I want to
> behave, and that's how I want the others in this project to behave. Back
> to this bug I wanted to debug/this feature I wanted to implement..."

Thanks for your response, Dscho. I was all set to reply to Gábor, but
you made all my points for me. :)

In particular, I think this paragraph is key. I don't think this CoC is
asking to change anything about how we work or communicate currently. I
view it as writing down the status quo (which is valuable for the
reasons I mentioned in the commit message).

(None of which is to say that people might not have disagreements that
need resolving, or that discussions about communication style aren't
welcome; just that I think the CoC is at a more meta level).

-Peff
