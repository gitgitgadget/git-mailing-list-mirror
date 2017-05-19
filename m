Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82CA201CF
	for <e@80x24.org>; Fri, 19 May 2017 00:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbdESAAY (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 20:00:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:54637 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751944AbdESAAX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 20:00:23 -0400
Received: (qmail 14626 invoked by uid 109); 19 May 2017 00:00:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 00:00:19 +0000
Received: (qmail 24665 invoked by uid 111); 19 May 2017 00:00:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 20:00:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 May 2017 20:00:16 -0400
Date:   Thu, 18 May 2017 20:00:16 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Demonstrate and partially work around a
 gitattributes problem
Message-ID: <20170519000016.bvqaml6d3o6q6qus@sigill.intra.peff.net>
References: <cover.1494861793.git.johannes.schindelin@gmx.de>
 <20170516075418.m3knwvdsr5ab6vzy@sigill.intra.peff.net>
 <20170516081023.lh3zflnf473jiviq@sigill.intra.peff.net>
 <xmqqshk4z2hv.fsf@gitster.mtv.corp.google.com>
 <20170517020535.qqmw2yncfomd3hfb@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1705182122430.3610@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1705182122430.3610@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 09:23:17PM +0200, Johannes Schindelin wrote:

> So you drive this forward? That would really help me a lot. Please make my
> 1/2 part of your patches to that end.

Yes, sorry, I haven't gotten a chance to polish the patches yet.

-Peff
