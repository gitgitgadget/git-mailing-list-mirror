Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0612211B5
	for <e@80x24.org>; Mon, 21 Jan 2019 20:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfAUUV3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 15:21:29 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53410 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbfAUUV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 15:21:29 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1B1F21F453;
        Mon, 21 Jan 2019 20:21:29 +0000 (UTC)
Date:   Mon, 21 Jan 2019 20:21:28 +0000
From:   Eric Wong <e@80x24.org>
To:     Stefan Xenos <sxenos@google.com>
Cc:     git@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: Missing patch?
Message-ID: <20190121202128.am7caicqexcwewj5@dcvr>
References: <CAPL8Ziv9LKBBXnCdWcG6r19zBs6SW-f_OvBbBncMqFjLSyPyqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPL8Ziv9LKBBXnCdWcG6r19zBs6SW-f_OvBbBncMqFjLSyPyqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos <sxenos@google.com> wrote:
> I've tried to upload a patch twice but it doesn't seem to be showing
> up in my mailbox or in the mailing list archives. The patch title was
> "[RFC PATCH] evolve: Implement the git change command".
> 
> Has anyone seen it? Is there a reason the mailing list would reject a patch?

Who was on the Cc: list (if anyone)?  Any other info,
particularly the date/time of the patch.

Was it huge?  vger rejects giant mails.

Any bounces? (perhaps in your spam box).

I noticed I didn't get too many messages from vger yesterday,
so maybe it was down for a bit and still going through a backlog
(or people were just enjoying the weekend).

I've been hacking on public-inbox lately so I checked to see if
I accidentally deleted it, but that doesn't seem to be the case.
