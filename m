Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246D41FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 19:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967305AbdAFTpA (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 14:45:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:36141 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754983AbdAFTo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 14:44:59 -0500
Received: (qmail 11051 invoked by uid 109); 6 Jan 2017 19:44:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 19:44:59 +0000
Received: (qmail 19628 invoked by uid 111); 6 Jan 2017 19:45:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Jan 2017 14:45:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2017 14:44:57 -0500
Date:   Fri, 6 Jan 2017 14:44:57 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v4 00/23] Delete directories left empty after ref deletion
Message-ID: <20170106194457.3qbhggpo6yox34al@sigill.intra.peff.net>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 05:22:20PM +0100, Michael Haggerty wrote:

> This is v4 of this patch series. Thanks to Peff, Junio, Jake, and
> Philip for their feedback about v3. I believe I have addressed all of
> the comments about v1 [1], v2 [2], and v3 [3].

This version looks good to me.

-Peff
