Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A262FC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341F920878
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406479AbgJPUkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:40:37 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:27906 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404016AbgJPUkh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:40:37 -0400
Received: from aiailu.local (unknown [IPv6:2a01:e0a:3d0:7640:b5c9:99c7:98cf:c17c])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 958302003CE;
        Fri, 16 Oct 2020 22:39:58 +0200 (CEST)
Subject: Re: [PATCH] credential: load default config
To:     Jeff King <peff@peff.net>,
        Thomas Koutcher via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.881.git.git.1602799160623.gitgitgadget@gmail.com>
 <20201016010423.GD2932796@coredump.intra.peff.net>
From:   Thomas Koutcher <thomas.koutcher@online.fr>
Message-ID: <9410cdd8-f249-6da3-dd8d-4c8b4ea0c805@online.fr>
Date:   Fri, 16 Oct 2020 22:39:57 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201016010423.GD2932796@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 16/10/2020 à 03:04, Jeff King a écrit :

> Perhaps it's worth squashing in this test?

Definitely, thanks for adding the test, Peff !


