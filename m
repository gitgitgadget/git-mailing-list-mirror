Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36E561F955
	for <e@80x24.org>; Fri, 29 Jul 2016 16:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbcG2Qkt (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 12:40:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:51124 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751695AbcG2Qks (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 12:40:48 -0400
Received: (qmail 890 invoked by uid 102); 29 Jul 2016 16:40:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 12:40:48 -0400
Received: (qmail 2858 invoked by uid 107); 29 Jul 2016 16:41:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 12:41:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 12:40:45 -0400
Date:	Fri, 29 Jul 2016 12:40:45 -0400
From:	Jeff King <peff@peff.net>
To:	Brian Henderson <henderson.bj@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 0/3] diff-highlight: add support for git log --graph
 output.
Message-ID: <20160729164045.GE29773@sigill.intra.peff.net>
References: <20160729145130.9514-1-henderson.bj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160729145130.9514-1-henderson.bj@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 07:51:27AM -0700, Brian Henderson wrote:

> (resending as thread instead of attachments)

Hmm, the actual patches don't seem to have made it to the list. :(

-Peff
