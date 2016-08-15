Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2563E1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 13:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbcHONEZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 09:04:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:55415 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752905AbcHONDv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 09:03:51 -0400
Received: (qmail 15963 invoked by uid 109); 15 Aug 2016 13:03:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 13:03:50 +0000
Received: (qmail 14646 invoked by uid 111); 15 Aug 2016 13:03:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 09:03:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 09:03:48 -0400
Date:	Mon, 15 Aug 2016 09:03:48 -0400
From:	Jeff King <peff@peff.net>
To:	Arkady Shapkin <arkady.shapkin@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Git shallow clone branch doesn't work with recursive submodules
 cloning
Message-ID: <20160815130347.3isxpdlnuy7nldmk@sigill.intra.peff.net>
References: <CAB-zwL28qUBO5PrRznH9KmLJZUHO65_J-DxvPP+NHZEuofKh9Q@mail.gmail.com>
 <20160815120441.nwtdqfgcv3ljt4vl@sigill.intra.peff.net>
 <CAB-zwL2oFMBFjkkoh1EhSD7FCK_1wVV+whu8uxTKTHQKJgNzrQ@mail.gmail.com>
 <20160815124725.t6bo5fv4lbbnqnfo@sigill.intra.peff.net>
 <CAB-zwL2P08YC=3Ube8mkZ=mB4xpW6TUnG2gEZKtvRU03eE6ALA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB-zwL2P08YC=3Ube8mkZ=mB4xpW6TUnG2gEZKtvRU03eE6ALA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 03:53:48PM +0300, Arkady Shapkin wrote:

> So it will work only if github update their server configuration
> (boringssl submodule on github)?

Correct.

-Peff
