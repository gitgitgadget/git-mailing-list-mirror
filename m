Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA9B1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 08:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfAVI0u (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 03:26:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:43706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727062AbfAVI0u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 03:26:50 -0500
Received: (qmail 8894 invoked by uid 109); 22 Jan 2019 08:26:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Jan 2019 08:26:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4179 invoked by uid 111); 22 Jan 2019 08:26:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 22 Jan 2019 03:26:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2019 03:26:48 -0500
Date:   Tue, 22 Jan 2019 03:26:48 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Contributor Summit Topics and Logistics
Message-ID: <20190122082647.GA31608@sigill.intra.peff.net>
References: <20190122075027.GA29441@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122075027.GA29441@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 02:50:27AM -0500, Jeff King wrote:

> There's no set agenda; we'll decide what to discuss that day. But if
> anybody would like to mention topics they are interested in (whether you
> want to present on them, or just have an open discussion), please do so
> here. A little advance notice can help people prepare more for the
> discussions.

One topic worth discussing (here or there): the GSoC org deadline is Feb
6th. Last year's org admins were Christian and Stefan (cc'd). Are you
both interested and able to continue?

-Peff
