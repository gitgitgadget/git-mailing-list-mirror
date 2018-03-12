Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219E21F404
	for <e@80x24.org>; Mon, 12 Mar 2018 23:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932303AbeCLXds (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 19:33:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:54690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751333AbeCLXdr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 19:33:47 -0400
Received: (qmail 13330 invoked by uid 109); 12 Mar 2018 23:33:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Mar 2018 23:33:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18974 invoked by uid 111); 12 Mar 2018 23:34:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Mar 2018 19:34:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2018 19:33:45 -0400
Date:   Mon, 12 Mar 2018 19:33:45 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        jonathantanmy@google.com, bmwill@google.com, stolee@gmail.com,
        sbeller@google.com, avarab@gmail.com, johannes.schindelin@gmx.de
Subject: Re: Git Merge contributor summit notes
Message-ID: <20180312233344.GD1968@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 09, 2018 at 04:06:18PM -0800, Alex Vandiver wrote:

> It was great to meet some of you in person!  Some notes from the
> Contributor Summit at Git Merge are below.  Taken in haste, so
> my apologies if there are any mis-statements.

Thanks very much for these notes!

I think in future years we should do a better job of making sure we have
an official note-taker so that this stuff makes it onto the list. I was
very happy when you announced part-way through the summit that you had
already been taking notes. :)

>   "Does anyone think there's a compelling reason for git to exist?"
>     - peff

Heh, those words did indeed escape my mouth.

Your notes look accurate overall from a brief skim. I'm still post-trip
recovering, but I may try to follow-up and expand on a few areas where I
have thoughts. And I'd encourage others to do the same as a way of
bridging the discussion back to the list.

-Peff
