Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78332C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1695C64EA1
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhBBJVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:21:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:44136 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232529AbhBBJVU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:21:20 -0500
Received: (qmail 12490 invoked by uid 109); 2 Feb 2021 09:20:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Feb 2021 09:20:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32403 invoked by uid 111); 2 Feb 2021 09:20:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Feb 2021 04:20:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Feb 2021 04:20:38 -0500
From:   Jeff King <peff@peff.net>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
Message-ID: <YBkZZrDzBo0UC+SQ@coredump.intra.peff.net>
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
 <CAGP6POJ62-HG88uRv7yHHGy3Uu+T57APQ6GiNU3nQDW2eT4cXw@mail.gmail.com>
 <YBkUJP2u4NcldpOp@coredump.intra.peff.net>
 <CAGP6POKxr6k5KaC0xNaFGt=mBoEMkObNGHhDpUHQdEbsokrHhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGP6POKxr6k5KaC0xNaFGt=mBoEMkObNGHhDpUHQdEbsokrHhQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 05:02:53PM +0800, Hongyi Zhao wrote:

> > If you only care about topics that you have participated in, the easiest
> > thing is to simply unsubscribe from the list.
> 
> Do you mean I still can post to this list without subscription to it?

Yes.

You can also read the archive at https://lore.kernel.org/git if you
later feel like checking for threads you might have missed.

-Peff
