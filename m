Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ACEC1F428
	for <e@80x24.org>; Wed, 29 Aug 2018 05:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeH2JCw (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 05:02:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:60160 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726209AbeH2JCv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 05:02:51 -0400
Received: (qmail 15088 invoked by uid 109); 29 Aug 2018 05:07:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 05:07:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10157 invoked by uid 111); 29 Aug 2018 05:07:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 01:07:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 01:07:46 -0400
Date:   Wed, 29 Aug 2018 01:07:46 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: Thank you for public-inbox!
Message-ID: <20180829050745.GD15274@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 04:25:13PM +0200, Johannes Schindelin wrote:

> I would like to take five minutes to thank you for public-inbox. It is
> invaluable for me in the meantime. And I think I will never be able to
> thank you enough for it.

Let me echo that appreciation. I have always kept my own archive of the
list, but it's so valuable to have stable URLs for communicating with
other folks (and I find the general design of public-inbox _way_ more
useful than gmane ever was).

> P.S.: FWIW I added a mirror of public-inbox to
> https://git-for-windows.visualstudio.com/git.public-inbox, so that my
> automated tasks, as well as my playing around, does not stress your server
> too much.

I've thought about mirroring it to a public server as well, just for
redundancy. But without the same domain, I'm not sure it would be all
that useful as a community resource.

Eric, let me know if there's something there that would help (e.g.,
putting more servers in DNS round-robin).

-Peff
