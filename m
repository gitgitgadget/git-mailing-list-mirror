Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C30C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 22:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA6C20776
	for <git@archiver.kernel.org>; Mon, 25 May 2020 22:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgEYWJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 18:09:48 -0400
Received: from echo.default.edsfctgx.uk0.bigv.io ([46.43.3.208]:22762 "EHLO
        echo.tratt.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbgEYWJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 18:09:48 -0400
Received: by echo.tratt.net (Postfix, from userid 1000)
        id C3F1865F0; Mon, 25 May 2020 23:09:46 +0100 (BST)
Date:   Mon, 25 May 2020 23:09:46 +0100
From:   Laurence Tratt <laurie@tratt.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: recurse-submodules can remove local changes when switching
 branches?
Message-ID: <20200525220946.kau2d3etavf2qsso@overdrive.tratt.net>
User-Agent: mutt
References: <20200525094019.22padbzuk7ukr5uv@overdrive.tratt.net>
 <1788146A-420A-41F9-A286-165F574089BD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1788146A-420A-41F9-A286-165F574089BD@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 25, 2020 at 01:28:24PM -0400, Philippe Blain wrote:

Hello Philippe,

> I believe this is the same bug that was reported in 2018 here:
> https://lore.kernel.org/git/CAHsG2VT4YB_nf8PrEmrHwK-iY-AQo0VDcvXGVsf8cEYXws4nig@mail.gmail.com/

Yes, I agree!


Laurie
