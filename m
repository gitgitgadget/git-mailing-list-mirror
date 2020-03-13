Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6E8C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 20:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C192074A
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 20:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgCMUrk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:47:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:39464 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727389AbgCMUrk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 16:47:40 -0400
Received: (qmail 25546 invoked by uid 109); 13 Mar 2020 20:47:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Mar 2020 20:47:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9976 invoked by uid 111); 13 Mar 2020 20:57:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Mar 2020 16:57:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Mar 2020 16:47:38 -0400
From:   Jeff King <peff@peff.net>
To:     James Ramsay <james@jramsay.com.au>
Cc:     git@vger.kernel.org
Subject: Re: Notes from Git Contributor Summit, Los Angeles (April 5, 2020)
Message-ID: <20200313204738.GA557052@coredump.intra.peff.net>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 02:55:21PM +1100, James Ramsay wrote:

> It was great to see everyone at the Contributor Summit last week, in person
> and virtually.
> 
> Particular thanks go to Peff for facilitating, and to GitHub for organizing
> the logistics of the meeting place and food. Thank you!

Thanks very much to you and others who took these notes! It's nice to
have a more permanent record of these discussions.

-Peff
