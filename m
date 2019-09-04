Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947D51F461
	for <e@80x24.org>; Wed,  4 Sep 2019 19:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbfIDTlE (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 15:41:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:39494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730591AbfIDTlE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 15:41:04 -0400
Received: (qmail 16969 invoked by uid 109); 4 Sep 2019 19:41:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Sep 2019 19:41:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18098 invoked by uid 111); 4 Sep 2019 19:42:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Sep 2019 15:42:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Sep 2019 15:41:03 -0400
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     pedro rijo <pedrorijo91@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [RFC] Post/tutorial for newcomers
Message-ID: <20190904194102.GA31805@sigill.intra.peff.net>
References: <CAHd-oW4d=x51EwwyZ-FhxHgLJNZM5sHLd19mUOuacFrhT_CQwQ@mail.gmail.com>
 <CAPMsMoB=8M2Nivf=20bLEnVhN_U9f0gmG6iZHgc1MJ_TvKB3Ww@mail.gmail.com>
 <CAHd-oW6aCcx8QviZtwpjaNQ6z=PDFKt91au77cDO7w5i=caR6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd-oW6aCcx8QviZtwpjaNQ6z=PDFKt91au77cDO7w5i=caR6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 03, 2019 at 09:59:13PM -0300, Matheus Tavares Bernardino wrote:

> > It may be interesting to add a link on
> > https://git-scm.com/community, what do you think @peff ?
> 
> Nice :) I think a link to `Documentation/MyFirstContribution.txt`
> could also be added to the "Contributing to Git" section.

Yes, I think either or both would be good. Patches welcome (here, or at
https://github.com/git/git-scm.com).

-Peff
