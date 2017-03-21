Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A750720958
	for <e@80x24.org>; Tue, 21 Mar 2017 01:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755279AbdCUBi3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:38:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:48331 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754356AbdCUBi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:38:28 -0400
Received: (qmail 11532 invoked by uid 109); 21 Mar 2017 01:38:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:38:28 +0000
Received: (qmail 10032 invoked by uid 111); 21 Mar 2017 01:38:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 21:38:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 21:38:23 -0400
Date:   Mon, 20 Mar 2017 21:38:23 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/5] t1400: rename test descriptions to be unique
Message-ID: <20170321013823.icefpibh2cjcnmsi@sigill.intra.peff.net>
References: <20170321005616.31324-1-kyle@kyleam.com>
 <20170321005616.31324-2-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321005616.31324-2-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 08:56:12PM -0400, Kyle Meyer wrote:

> A few tests share their description with another test.  Extend the
> descriptions to indicate how the tests differ.
> 
> Signed-off-by: Kyle Meyer <kyle@kyleam.com>

Makes sense, and your descriptions look good.

-Peff
