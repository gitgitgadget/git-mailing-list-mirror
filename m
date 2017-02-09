Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565391FD6A
	for <e@80x24.org>; Thu,  9 Feb 2017 04:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbdBIEah (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 23:30:37 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:56574 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbdBIEah (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 23:30:37 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 76C2B1FAF4;
        Thu,  9 Feb 2017 04:30:34 +0000 (UTC)
Date:   Thu, 9 Feb 2017 04:30:34 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git-scm.com status report
Message-ID: <20170209043034.GA30409@dcvr.yhbt.net>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
 <20170206182754.qxgzl7546i7u5wnw@sigill.intra.peff.net>
 <20170209021208.rvy7uww3qsktbf4a@genre.crustytoothpaste.net>
 <20170209025030.52frbjekatebjoii@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170209025030.52frbjekatebjoii@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> I agree we should continue to serve HTTPS. The usual solution for our
> use case is to stick a CDN like Cloudflare in front of GitHub Pages (and
> I think we'd want to do that anyway for performance).
> 
> I haven't done it, but there are various guides. Here's the one from
> Cloudflare:
> 
>   https://blog.cloudflare.com/secure-and-fast-github-pages-with-cloudflare/

AFAIK, there's a way to keep CloudFlare stuff accessible to Tor
users.  If there is, please do so.  As a Tor user, it's been
disappointing to see so much of the web walled off by CAPTCHAs.

Thank you.

Heck, maybe a .onion mirror would be nice :)
I wouldn't mind hosting one myself if it's static.
