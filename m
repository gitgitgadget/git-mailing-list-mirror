Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDB31F859
	for <e@80x24.org>; Thu, 11 Aug 2016 07:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbcHKH4c (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 03:56:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48278 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbcHKH4a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 03:56:30 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F2C1F859;
	Thu, 11 Aug 2016 07:56:29 +0000 (UTC)
Date:	Thu, 11 Aug 2016 07:56:28 +0000
From:	Eric Wong <e@80x24.org>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	git@vger.kernel.org
Subject: Re: Mapping old gmane numbers to existing amil servers?
Message-ID: <20160811075628.GA24690@starla>
References: <73FC8DE87D24466EBEE0A5B96CBDFFBF@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73FC8DE87D24466EBEE0A5B96CBDFFBF@PhilipOakley>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> wrote:
> Is there an accessible mapping from the old gmane message numbers to one of
> the remaining email list servers for the git list?

Yes, I just posted about this after posting an initial mapping
a few weeks ago:
https://public-inbox.org/git/20160811002819.GA8311@starla/T/#u

Using "gmane:$NUM" in the search bar should work, now.
(there's a few missing messages which might've been due to
 off-by-one errors, will fill them in soon)

> I've seen discussions about the public-inbox, but no mention of any mapping
> for old message references.

I had a gzipped text file published originally if you look
upthread there.
