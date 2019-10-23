Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 193E91F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 23:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392799AbfJWXss (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 19:48:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:56600 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392795AbfJWXsr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 19:48:47 -0400
Received: (qmail 9127 invoked by uid 109); 23 Oct 2019 23:48:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Oct 2019 23:48:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28507 invoked by uid 111); 23 Oct 2019 23:51:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Oct 2019 19:51:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Oct 2019 19:48:46 -0400
From:   Jeff King <peff@peff.net>
To:     James Ramsay <james@jramsay.com.au>
Cc:     git@vger.kernel.org
Subject: Re: RFC - Git Developer Blog
Message-ID: <20191023234846.GA9545@sigill.intra.peff.net>
References: <20190806014935.GA26909@google.com>
 <20190806132052.GB18442@sigill.intra.peff.net>
 <20190806204925.GA196191@google.com>
 <885DEEA4-154B-4990-945D-19DABC87C627@jramsay.com.au>
 <4F3ADBAF-2DEF-4764-8056-56FFCB9EB767@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4F3ADBAF-2DEF-4764-8056-56FFCB9EB767@jramsay.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 06:36:25PM -0400, James Ramsay wrote:

> On 13 Sep 2019, at 9:29, James Ramsay wrote:
> 
> > Peff, you mentioned Jason might have some designs or ideas with regards
> > visuals. I'm happy to be put in touch directly or collaborate here.
> 
> Peff, did you touch base with Jason on the designs?
> 
> I have some travel coming up which I hope will provide quality train time to
> work on this.

I did, but I was a bit slow at keeping the conversation going. If you
have specific things to ask for, you might want to reply at:

  https://github.com/git/git-scm.com/pull/1179#issuecomment-537945151

-Peff
