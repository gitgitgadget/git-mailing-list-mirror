Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F7FC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B4C20684
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 14:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLSO5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:57:33 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:49049 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLSO5d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 09:57:33 -0500
Received: from localhost (unknown [42.109.223.123])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C5CB224000E;
        Thu, 19 Dec 2019 14:57:29 +0000 (UTC)
Date:   Thu, 19 Dec 2019 20:26:34 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2019, #04; Tue, 17)
Message-ID: <20191219145634.cszbyi5bwozspkj6@yadavpratyush.com>
References: <xmqqa77qfw99.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa77qfw99.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/12/19 02:00PM, Junio C Hamano wrote:
> --------------------------------------------------
> [New Topics]

I'm not sure what your criteria for picking up patches in 'pu' is, but I 
notice that a patch I sent a few days ago [0] is missing. A reminder in 
case it was missed accidentally.

[0] https://lore.kernel.org/git/20191214161438.16157-2-me@yadavpratyush.com/

-- 
Regards,
Pratyush Yadav
