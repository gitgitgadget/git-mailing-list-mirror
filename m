Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56902018A
	for <e@80x24.org>; Thu, 30 Jun 2016 06:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbcF3Gms (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 02:42:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:38173 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751621AbcF3Gms (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 02:42:48 -0400
Received: (qmail 23825 invoked by uid 102); 30 Jun 2016 06:42:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 02:42:28 -0400
Received: (qmail 5869 invoked by uid 107); 30 Jun 2016 06:42:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jun 2016 02:42:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2016 02:42:22 -0400
Date:	Thu, 30 Jun 2016 02:42:22 -0400
From:	Jeff King <peff@peff.net>
To:	Matthieu Moy <Matthieu.Moy@imag.fr>
Cc:	gitster@pobox.com, git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v2 0/7] literal formatting in documentation
Message-ID: <20160630064222.GD15380@sigill.intra.peff.net>
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
 <20160628114015.25828-1-Matthieu.Moy@imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160628114015.25828-1-Matthieu.Moy@imag.fr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 01:40:08PM +0200, Matthieu Moy wrote:

> This should address all comments from Peff.

Thanks. The review is mind-numbing enough that I didn't do a complete
read-through again, but just spot-checked a few places. This version
looks good to me.

-Peff
