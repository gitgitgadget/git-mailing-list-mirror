Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7A511F744
	for <e@80x24.org>; Fri, 17 Jun 2016 09:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbcFQJVl (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 05:21:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:56078 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754203AbcFQJVi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 05:21:38 -0400
Received: (qmail 4476 invoked by uid 102); 17 Jun 2016 09:21:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 05:21:38 -0400
Received: (qmail 23957 invoked by uid 107); 17 Jun 2016 09:21:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 05:21:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 05:21:35 -0400
Date:	Fri, 17 Jun 2016 05:21:35 -0400
From:	Jeff King <peff@peff.net>
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/7] gpg-interface cleanups
Message-ID: <20160617092134.GA25299@sigill.intra.peff.net>
References: <20160616093248.GA15130@sigill.intra.peff.net>
 <xmqqy4653si6.fsf@gitster.mtv.corp.google.com>
 <11a07248-ddf5-1424-2197-ca3ed117e200@drmicha.warpmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11a07248-ddf5-1424-2197-ca3ed117e200@drmicha.warpmail.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 17, 2016 at 11:20:09AM +0200, Michael J Gruber wrote:

> (With tests, I'm always unsure whether to follow surrounding style or
> the style guide; I did the former, Jeff improved the config handling by
> doing the latter.)

Yes, but I kept the horrendous indentation as a nod to consistency. :)

-Peff
