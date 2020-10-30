Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CFFC4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 12:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6387D20756
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 12:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgJ3MvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 08:51:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:42422 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgJ3MvV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 08:51:21 -0400
Received: (qmail 6786 invoked by uid 109); 30 Oct 2020 12:51:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 12:51:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20890 invoked by uid 111); 30 Oct 2020 12:51:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 08:51:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 08:51:20 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 02/10] hashmap: adjust spacing to fix argument
 alignment
Message-ID: <20201030125120.GB3277724@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <75f17619e964a8a1ab2ecd8267c25c10e5d68bef.1602549650.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75f17619e964a8a1ab2ecd8267c25c10e5d68bef.1602549650.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 12:40:42AM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> No actual code changes; just whitespace adjustments.

Obviously good. Thanks for splitting this into its own patch.

-Peff
