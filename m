Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5541FF40
	for <e@80x24.org>; Thu, 22 Dec 2016 01:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965007AbcLVBAg (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 20:00:36 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48576 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932352AbcLVBAg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 20:00:36 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 574041FF40;
        Thu, 22 Dec 2016 01:00:35 +0000 (UTC)
Date:   Thu, 22 Dec 2016 01:00:35 +0000
From:   Eric Wong <e@80x24.org>
To:     Stephen & Linda Smith <ischis2@cox.net>
Cc:     git@vger.kernel.org
Subject: Re: References to old messages
Message-ID: <20161222010035.GA15011@starla>
References: <2284357.IWoC4bU66L@thunderbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2284357.IWoC4bU66L@thunderbird>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen & Linda Smith <ischis2@cox.net> wrote:
> I had been told to reference (i.e. footnote) a gmane URL.  With that service 
> no longer being being online, what is the preferred method footnoting?

What the others said about Message-IDs and public-inbox :)

If you only have old URLs pointing to gmane and no NNTP access,
you can also search for "gmane:$ARTICLE_NUMBER" via public-inbox
(at least up to messages around this summer):

	https://public-inbox.org/git/?q=gmane:12345

https://public-inbox.org/git/_/text/help documents other
search prefixes you can use, too.
