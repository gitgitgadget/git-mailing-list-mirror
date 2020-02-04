Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9A4C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408C921744
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 16:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgBDQhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:37:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:52174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727388AbgBDQhS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 11:37:18 -0500
Received: (qmail 10194 invoked by uid 109); 4 Feb 2020 16:37:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Feb 2020 16:37:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 725 invoked by uid 111); 4 Feb 2020 16:45:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Feb 2020 11:45:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Feb 2020 11:37:16 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: GSoC and Outreachy Summer 2020?
Message-ID: <20200204163716.GA7308@coredump.intra.peff.net>
References: <20200122053455.GA51054@coredump.intra.peff.net>
 <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
 <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 05:11:20PM +0100, Christian Couder wrote:

> > As with https://github.com/git/git.github.io/blob/master/General-Microproject-Information.md
> > the idea is to not have separate documents for each year and each
> > program (GSoC or Outreachy), but rather point people to the same
> > document that we should update regularly.
> 
> While at it, I just applied on behalf of Git to the GSoC 2020 and I
> sent invite to possible Organization Administrators. I am one of the
> admins already but we need another person to accept the invite before
> tomorrow as they require at least 2 admins. This is the only thing
> left we need to apply.
> 
> The information I used to apply is in:
> https://git.github.io/SoC-2020-Org-Application/

Thank you for getting this going! I'm happy to be the second admin (and
am signed up now).

-Peff
