Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D151FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 19:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966327AbdCXTBb (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 15:01:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:51297 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934578AbdCXTB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 15:01:26 -0400
Received: (qmail 24799 invoked by uid 109); 24 Mar 2017 19:01:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 19:01:25 +0000
Received: (qmail 2955 invoked by uid 111); 24 Mar 2017 19:01:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 15:01:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 15:01:23 -0400
Date:   Fri, 24 Mar 2017 15:01:23 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Romuald Brunet <romuald@chivil.com>, git@vger.kernel.org,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: allow atomic flag via configuration
Message-ID: <20170324190123.b3ln56x5s6uztvil@sigill.intra.peff.net>
References: <1490375874.745.227.camel@locke.gandi.net>
 <20170324184550.3l6mw4ybynizblsm@sigill.intra.peff.net>
 <20170324185354.GE31294@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170324185354.GE31294@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 11:53:54AM -0700, Jonathan Nieder wrote:

> I didn't receive the original patch (maybe mailing delay?) so
> commenting here.

Vger seems a bit slow lately. The list copy did eventually get delivered
to me and public-inbox:

  http://public-inbox.org/git/1490375874.745.227.camel@locke.gandi.net/

I don't think it answers any of your questions, though. ;)

-Peff
