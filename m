Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4074E207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947366AbdDTUcm (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:32:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:37195 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943112AbdDTUcm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:32:42 -0400
Received: (qmail 32226 invoked by uid 109); 20 Apr 2017 20:32:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 20:32:41 +0000
Received: (qmail 9022 invoked by uid 111); 20 Apr 2017 20:33:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 16:33:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 16:32:39 -0400
Date:   Thu, 20 Apr 2017 16:32:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] doc: replace or.cz gitwiki link with git.wiki.kernel.org
Message-ID: <20170420203238.kqflctbulimw4npn@sigill.intra.peff.net>
References: <20170420203203.xlbajdfzy7gp3hj3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420203203.xlbajdfzy7gp3hj3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The or.cz version of the Git wiki went away long ago, and
now just redirects to kernel.org.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-tools.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index 2f4ff5015..d0fec4cdd 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -7,4 +7,4 @@ maintained here. These days, however, search engines fill that role much
 more efficiently, so this manually-maintained list has been retired.
 
 See also the `contrib/` area, and the Git wiki:
-http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
+https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
-- 
2.13.0.rc0.363.g8726c260e

