Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650E51F463
	for <e@80x24.org>; Tue, 24 Sep 2019 15:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbfIXPvn (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 11:51:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:58442 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390614AbfIXPvn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 11:51:43 -0400
Received: (qmail 7894 invoked by uid 109); 24 Sep 2019 15:51:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Sep 2019 15:51:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10008 invoked by uid 111); 24 Sep 2019 15:54:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2019 11:54:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Sep 2019 11:51:42 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@sfconservancy.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
Message-ID: <20190924155141.GB5318@sigill.intra.peff.net>
References: <20190924064454.GA30419@sigill.intra.peff.net>
 <6a9fb4c2-6c80-4475-03d3-89bdba73095b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a9fb4c2-6c80-4475-03d3-89bdba73095b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 08:13:27AM -0400, Derrick Stolee wrote:

> > I did find this nice set of guidelines in an old discussion:
> > 
> >   https://github.com/mhagger/git/commit/c6e6196be8fab3d48b12c4e42eceae6937538dee
> 
> While this document has good information, most of it would be better suited
> for a "Reviewing Code" guide. The CoC is more general, as it applies to
> behavior on-list AND off-list.

Yeah, that was specifically what I was thinking with "maybe this could
go in some other documents". I don't know if anybody is actively working
on a reviewer's guide, though.

-Peff
