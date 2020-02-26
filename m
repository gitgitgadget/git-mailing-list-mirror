Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C33EC4BA09
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 01:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E04E2082F
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 01:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgBZBm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:42:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:54408 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729403AbgBZBm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 20:42:29 -0500
Received: (qmail 16628 invoked by uid 109); 26 Feb 2020 01:42:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Feb 2020 01:42:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22099 invoked by uid 111); 26 Feb 2020 01:51:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2020 20:51:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Feb 2020 20:42:28 -0500
From:   Jeff King <peff@peff.net>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: GSoC and Outreachy Summer 2020?
Message-ID: <20200226014228.GA2913263@coredump.intra.peff.net>
References: <20200204163716.GA7308@coredump.intra.peff.net>
 <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com>
 <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com>
 <CAP8UFD1QbOK9g2oAhfTm2npoNF9Ay_HiAfFai9rJwZzc73cBbw@mail.gmail.com>
 <20200221183003.GA9786@coredump.intra.peff.net>
 <CACg5j24mH0LRHXbhgf16f+7KqOnrsh7BRovh8mR6AzHG=y5gFA@mail.gmail.com>
 <20200223214433.GA564650@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2002241648000.46@tvgsbejvaqbjf.bet>
 <20200225202014.GA2773363@coredump.intra.peff.net>
 <CACg5j25qmYivZdW_=dfun-ZP5m3Zx8dcYEkf24xDhVc7xmqwig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACg5j25qmYivZdW_=dfun-ZP5m3Zx8dcYEkf24xDhVc7xmqwig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 01:55:46PM +1300, Heba Waly wrote:

> > On Mon, Feb 24, 2020 at 04:48:41PM +0100, Johannes Schindelin wrote:
> > >
> > > I would be willing to co-mentor, but I have no good project lined up, so
> > > it feels a bit rushed to me. Maybe take it easy and apply this fall?
> >
> > I think that makes sense in this case.
> 
> I think I'll co-mentor with Christian then :)
>
Just to be clear: you mean on GSoC, or trying to get something together
for Outreachy?

-Peff
