Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757CAC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 20:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FABA61164
	for <git@archiver.kernel.org>; Sat, 22 May 2021 20:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhEVU1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 16:27:11 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:7212 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231398AbhEVU1L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 16:27:11 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:d787:42d5:3b3a:1b26])
        by smtp5-g21.free.fr (Postfix) with ESMTP id 088015FF23
        for <git@vger.kernel.org>; Sat, 22 May 2021 22:25:44 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc1
Date:   Sat, 22 May 2021 22:25:44 +0200
Message-ID: <3156524.cFZ8jhdkIW@cayenne>
In-Reply-To: <xmqqk0nqq266.fsf@gitster.g>
References: <xmqqk0nqq266.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there any reason the patch

[PATCH] help: fix small typo in error message

was not pushed for update?

It affects translators.

JN



