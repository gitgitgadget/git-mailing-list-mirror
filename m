Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57869211B4
	for <e@80x24.org>; Wed, 16 Jan 2019 04:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfAPECz (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 23:02:55 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44062 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbfAPECz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 23:02:55 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A49FF1F62E;
        Wed, 16 Jan 2019 04:02:54 +0000 (UTC)
Date:   Wed, 16 Jan 2019 04:02:54 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #02; Tue, 15)
Message-ID: <20190116040254.oeeqelwkfe5b35gu@dcvr>
References: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> * ew/ban-strncat (2019-01-02) 1 commit
>   (merged to 'next' on 2019-01-08 at 3bba2ae2bb)
>  + banned.h: mark strncat() as banned

Can you squash in Eric Sunshine's speling fix in my commit message?
(s/iself/itself/)
https://public-inbox.org/git/CAPig+cR2w3S==3-zstjmuB9jw4H-aPK7xqMeMLK-P94=+18jJQ@mail.gmail.com/

Thanks.
