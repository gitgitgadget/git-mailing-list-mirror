Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB06520195
	for <e@80x24.org>; Fri, 22 Jul 2016 16:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbcGVQbB (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 12:31:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:48689 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752082AbcGVQbB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 12:31:01 -0400
Received: (qmail 13211 invoked by uid 102); 22 Jul 2016 16:31:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 12:31:01 -0400
Received: (qmail 7315 invoked by uid 107); 22 Jul 2016 16:31:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 12:31:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2016 12:30:58 -0400
Date:	Fri, 22 Jul 2016 12:30:58 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Subject: [PATCH 3/3] contrib/git-jump: fix typo in README
Message-ID: <20160722163057.GC14080@sigill.intra.peff.net>
References: <20160722162707.GA13905@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160722162707.GA13905@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/git-jump/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 1cebc32..202b499 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -83,7 +83,7 @@ complete list of files and line numbers for each match.
 Limitations
 -----------
 
-This scripts was written and tested with vim. Given that the quickfix
+This script was written and tested with vim. Given that the quickfix
 format is the same as what gcc produces, I expect emacs users have a
 similar feature for iterating through the list, but I know nothing about
 how to activate it.
-- 
2.9.2.506.g8452fe7
