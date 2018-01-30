Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23461F404
	for <e@80x24.org>; Tue, 30 Jan 2018 18:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeA3StL (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 13:49:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:34258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751429AbeA3StK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 13:49:10 -0500
Received: (qmail 28476 invoked by uid 109); 30 Jan 2018 18:49:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Jan 2018 18:49:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17230 invoked by uid 111); 30 Jan 2018 18:49:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Jan 2018 13:49:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jan 2018 13:49:08 -0500
Date:   Tue, 30 Jan 2018 13:49:08 -0500
From:   Jeff King <peff@peff.net>
To:     chris@dibona.com
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Scott@gasch.org
Subject: Re: Shawn Pearce has died
Message-ID: <20180130184908.GA8330@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1801291031040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87bmhcsnhv.fsf@evledraar.booking.com>
 <20180129172452.GB4185@sigill.intra.peff.net>
 <87372oo3tk.fsf@evledraar.gmail.com>
 <CAEq5uwnzgRVob7i4e7LCwDbuDRjZOXNj4QOWc8nDC_VHa5v4Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEq5uwnzgRVob7i4e7LCwDbuDRjZOXNj4QOWc8nDC_VHa5v4Hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 11:15:55PM -0800, Chris DiBona wrote:

> That's a fantastic idea.  When is the contrib summit and is it open to
> others? I could send someone ...

It's March 7th in Barcelona. Details are here:

  https://public-inbox.org/git/20180119001034.GA29172@sigill.intra.peff.net/

There will be GitHub video folks on premises the following day for the
Git Merge main conference, but I'm looking into whether they'll be
around to record a few interviews on the contributor summit day.

-Peff
