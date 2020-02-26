Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9861DC4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 18:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADEE20732
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 18:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBZSiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:38:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:55220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726789AbgBZSiu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 13:38:50 -0500
Received: (qmail 20937 invoked by uid 109); 26 Feb 2020 18:38:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Feb 2020 18:38:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28003 invoked by uid 111); 26 Feb 2020 18:47:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2020 13:47:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Feb 2020 13:38:49 -0500
From:   Jeff King <peff@peff.net>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: GSoC and Outreachy Summer 2020?
Message-ID: <20200226183849.GA23188@coredump.intra.peff.net>
References: <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com>
 <CAP8UFD1QbOK9g2oAhfTm2npoNF9Ay_HiAfFai9rJwZzc73cBbw@mail.gmail.com>
 <20200221183003.GA9786@coredump.intra.peff.net>
 <CACg5j24mH0LRHXbhgf16f+7KqOnrsh7BRovh8mR6AzHG=y5gFA@mail.gmail.com>
 <20200223214433.GA564650@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2002241648000.46@tvgsbejvaqbjf.bet>
 <20200225202014.GA2773363@coredump.intra.peff.net>
 <CACg5j25qmYivZdW_=dfun-ZP5m3Zx8dcYEkf24xDhVc7xmqwig@mail.gmail.com>
 <20200226014228.GA2913263@coredump.intra.peff.net>
 <CACg5j26XTA4Z5pnBKWJiF6-dxTA7LJ3ZsxSi1ZvHbK4qZ9jhTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACg5j26XTA4Z5pnBKWJiF6-dxTA7LJ3ZsxSi1ZvHbK4qZ9jhTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 11:17:26PM +1300, Heba Waly wrote:

> > > I think I'll co-mentor with Christian then :)
> > >
> > Just to be clear: you mean on GSoC, or trying to get something together
> > for Outreachy?
> 
> GSoC.

Thanks! I just wanted to make sure I didn't need to keep pursuing
funding for this Outreachy round.

-Peff
