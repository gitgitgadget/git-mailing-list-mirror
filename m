Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B56C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9425520899
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgE0V1V convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 May 2020 17:27:21 -0400
Received: from westphal.uberspace.de ([185.26.156.72]:58080 "EHLO
        westphal.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0V1V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 17:27:21 -0400
Received: (qmail 22468 invoked from network); 27 May 2020 21:27:19 -0000
Received: from localhost (HELO localhost) (127.0.0.1)
  by westphal.uberspace.de with SMTP; 27 May 2020 21:27:19 -0000
Date:   Wed, 27 May 2020 23:27:17 +0200
From:   Merlin =?UTF-8?B?QsO8Z2U=?= <toni@bluenox07.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Question about behaviour of git-checkout --patch option
Message-ID: <20200527232717.64b2e124.toni@bluenox07.de>
In-Reply-To: <nycvar.QRO.7.76.6.2005270646550.56@tvgsbejvaqbjf.bet>
References: <20200525221100.31d36d4d.toni@bluenox07.de>
        <20200527075648.GA4006373@coredump.intra.peff.net>
        <20200527080009.GB4006373@coredump.intra.peff.net>
        <20200527123234.737efc3f.toni@bluenox07.de>
        <nycvar.QRO.7.76.6.2005270646550.56@tvgsbejvaqbjf.bet>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Wed, 27 May 2020 06:48:28 +0200 (CEST), Johannes Schindelin wrote:

> There is not really any centralized way to keep track of open bugs.
> 
> And yes, sometimes they get lost after a few days.
> 
> In your case, however, there is now
> https://lore.kernel.org/git/pull.646.git.1590613746507.gitgitgadget@gmail.com/T/#u
> which is better than just a ticket: it is already a patch.

Wow, that was fast!

Thanks a lot!

-- 
Merlin Büge
