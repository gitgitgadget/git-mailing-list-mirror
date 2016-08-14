Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DA0B1F6C1
	for <e@80x24.org>; Sun, 14 Aug 2016 09:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbcHNJVP (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 05:21:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45620 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112AbcHNJVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 05:21:14 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1000D1F6C1;
	Sun, 14 Aug 2016 02:12:35 +0000 (UTC)
Date:	Sun, 14 Aug 2016 02:12:34 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer
Message-ID: <20160814021234.GA1017@starla>
References: <xmqq1t1twymf.fsf@gitster.mtv.corp.google.com>
 <20160812224255.GA16250@dcvr>
 <20160813081012.p46i4jcvkkfqch7m@sigill.intra.peff.net>
 <20160813090432.GA25565@starla>
 <20160813111449.vkoo3fmlfd65loh5@sigill.intra.peff.net>
 <20160814012706.GA18784@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160814012706.GA18784@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Thanks, should all be imported.

Oops, missed one which was missing X-Mailing-List (causing
it to not get imported) and had "X-No-Archive: yes" set;
which meant I couldn't get it from gmane this year.

Hmm... XNAY defeats the point of public-inbox (and probably the
point of public-to-all mailing lists); so I don't think it's
worth honoring.
