Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D3BC35646
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 18:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1B2222C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 18:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgBUSaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:30:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:50498 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726066AbgBUSaF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 13:30:05 -0500
Received: (qmail 19255 invoked by uid 109); 21 Feb 2020 18:30:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Feb 2020 18:30:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20187 invoked by uid 111); 21 Feb 2020 18:39:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2020 13:39:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Feb 2020 13:30:03 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Heba Waly <heba.waly@gmail.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: GSoC and Outreachy Summer 2020?
Message-ID: <20200221183003.GA9786@coredump.intra.peff.net>
References: <20200122053455.GA51054@coredump.intra.peff.net>
 <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
 <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
 <20200204163716.GA7308@coredump.intra.peff.net>
 <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com>
 <CACg5j25_098i=rU++OB=YSbAFjCQdgUX7gP6D-9yo6F_A_yn0w@mail.gmail.com>
 <CAP8UFD1QbOK9g2oAhfTm2npoNF9Ay_HiAfFai9rJwZzc73cBbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1QbOK9g2oAhfTm2npoNF9Ay_HiAfFai9rJwZzc73cBbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 21, 2020 at 05:03:47PM +0100, Christian Couder wrote:

> > I'd be happy to co-mentor an Outreachy intern with an experienced
> > mentor, hope I'm not too late.
> 
> Thank you for your interest in co-mentoring! It's very much appreciated!
> 
> I don't think you are late. It seems that February 25 at 4pm UTC is
> the deadline for project submission.

I think it is too late. That's the deadline for mentor project
submission, but the signup for orgs was Feb 18th.

-Peff
