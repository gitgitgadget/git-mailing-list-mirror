Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1AC1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 14:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeDJOci (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 10:32:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:59994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753325AbeDJOch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 10:32:37 -0400
Received: (qmail 18880 invoked by uid 109); 10 Apr 2018 14:32:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Apr 2018 14:32:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25517 invoked by uid 111); 10 Apr 2018 14:32:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Apr 2018 10:32:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Apr 2018 10:32:35 -0400
Date:   Tue, 10 Apr 2018 10:32:35 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ben Toews <mastahyeti@gmail.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/8] gpg-interface: handle bool user.signingkey
Message-ID: <20180410143234.GA15346@sigill.intra.peff.net>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
 <20180409204129.43537-2-mastahyeti@gmail.com>
 <CAPig+cQb+ZDWgCNVPX8_eFqUy-_crQ4wtrYhv-6kwasGwLTWuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQb+ZDWgCNVPX8_eFqUy-_crQ4wtrYhv-6kwasGwLTWuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 09, 2018 at 04:55:26PM -0400, Eric Sunshine wrote:

> Peff's Signed-off-by: is missing. Also, since you're forwarding this
> patch on Peff's behalf, your Signed-off-by: should follow his. Same
> comment applies to all patches by Peff in this series.

I usually sign-off as I send to the list, but I passed these patches to
Ben via a repository. For the record, it's OK to add my s-o-b to the
whole series.

-Peff
