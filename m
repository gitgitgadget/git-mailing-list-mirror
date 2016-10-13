Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D0B1F4F8
	for <e@80x24.org>; Thu, 13 Oct 2016 06:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755396AbcJMGly (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 02:41:54 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48202 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755382AbcJMGlx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 02:41:53 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
        id 75DAA1C0144; Thu, 13 Oct 2016 08:34:18 +0200 (CEST)
Date:   Thu, 13 Oct 2016 08:34:18 +0200
From:   Stepan Kasal <kasal@ucw.cz>
To:     Jeff King <peff@peff.net>
Cc:     John Keeping <john@keeping.me.uk>, git@vger.kernel.org
Subject: Re: [PATCH] merge-base: handle --fork-point without reflog
Message-ID: <20161013063418.GA2217@ucw.cz>
References: <20161012103716.GA31533@ucw.cz>
 <20161012163209.oadmm7xsmm7oeumr@sigill.intra.peff.net>
 <20161012201040.pyrp6bktz3fgmqzn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161012201040.pyrp6bktz3fgmqzn@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

thank you for this nice and quick fix of this corner case!

Stepan
