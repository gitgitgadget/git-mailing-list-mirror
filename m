Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BAFC35E01
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 20:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0626721744
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 20:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbgBYUUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:20:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:54068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730794AbgBYUUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 15:20:16 -0500
Received: (qmail 15231 invoked by uid 109); 25 Feb 2020 20:20:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Feb 2020 20:20:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20308 invoked by uid 111); 25 Feb 2020 20:29:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2020 15:29:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Feb 2020 15:20:14 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Heba Waly <heba.waly@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: GSoC and Outreachy Summer 2020?
Message-ID: <20200225202014.GA2773363@coredump.intra.peff.net>
References: <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
 <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
 <20200204163716.GA7308@coredump.intra.peff.net>
 <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com>
 <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com>
 <CAP8UFD1QbOK9g2oAhfTm2npoNF9Ay_HiAfFai9rJwZzc73cBbw@mail.gmail.com>
 <20200221183003.GA9786@coredump.intra.peff.net>
 <CACg5j24mH0LRHXbhgf16f+7KqOnrsh7BRovh8mR6AzHG=y5gFA@mail.gmail.com>
 <20200223214433.GA564650@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2002241648000.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2002241648000.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 04:48:41PM +0100, Johannes Schindelin wrote:

> > Dscho mentioned a willingness to mentor, but I don't know if he's got a
> > project proposal ready.
> 
> I would be willing to co-mentor, but I have no good project lined up, so
> it feels a bit rushed to me. Maybe take it easy and apply this fall?

I think that makes sense in this case.

-Peff
