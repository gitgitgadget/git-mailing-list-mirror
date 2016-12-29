Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D669D20441
	for <e@80x24.org>; Thu, 29 Dec 2016 02:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbcL2CFL (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 21:05:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:32922 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752133AbcL2CFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 21:05:11 -0500
Received: (qmail 13435 invoked by uid 109); 29 Dec 2016 02:04:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Dec 2016 02:04:37 +0000
Received: (qmail 21221 invoked by uid 111); 29 Dec 2016 02:05:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 21:05:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Dec 2016 21:04:33 -0500
Date:   Wed, 28 Dec 2016 21:04:33 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, j6t@kgdb.org
Subject: Re: [PATCH v5 0/2] repack (oops)
Message-ID: <20161229020433.ajkhqnozxvtmwt3r@sigill.intra.peff.net>
References: <1482965142-6778-1-git-send-email-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1482965142-6778-1-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 05:45:40PM -0500, David Turner wrote:

> This version addresses Johannes Sixt's comments on v4.  Also, I
> messed up the rebase on v4.

Thanks. The test logic in this one looks good to me.

-Peff
