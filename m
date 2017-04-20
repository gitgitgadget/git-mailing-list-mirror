Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA9BB207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032943AbdDTUfk (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:35:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:37207 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970712AbdDTUfj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:35:39 -0400
Received: (qmail 32420 invoked by uid 109); 20 Apr 2017 20:35:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 20:35:39 +0000
Received: (qmail 9089 invoked by uid 111); 20 Apr 2017 20:36:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 16:36:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 16:35:36 -0400
Date:   Thu, 20 Apr 2017 16:35:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] docs/bisect-lk2009: update java code conventions link
Message-ID: <20170420203536.pbzwtao5vrsqwwsi@sigill.intra.peff.net>
References: <20170420203203.xlbajdfzy7gp3hj3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420203203.xlbajdfzy7gp3hj3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old link just redirects to a big index page. I was able
to find a new link for the original document via Google.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-bisect-lk2009.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 263a853fa..8ac75fcc2 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1348,7 +1348,7 @@ References
 ----------
 
 - [[[1]]] https://www.nist.gov/sites/default/files/documents/director/planning/report02-3.pdf['The Economic Impacts of Inadequate Infratructure for Software Testing'.  Nist Planning Report 02-3], see Executive Summary and Chapter 8.
-- [[[2]]] http://java.sun.com/docs/codeconv/html/CodeConventions.doc.html#16712['Code Conventions for the Java Programming Language'. Sun Microsystems.]
+- [[[2]]] http://www.oracle.com/technetwork/java/codeconvtoc-136057.html['Code Conventions for the Java Programming Language'. Sun Microsystems.]
 - [[[3]]] https://en.wikipedia.org/wiki/Software_maintenance['Software maintenance'. Wikipedia.]
 - [[[4]]] http://article.gmane.org/gmane.comp.version-control.git/45195/[Junio C Hamano. 'Automated bisect success story'. Gmane.]
 - [[[5]]] https://lwn.net/Articles/317154/[Christian Couder. 'Fully automated bisecting with "git bisect run"'. LWN.net.]
-- 
2.13.0.rc0.363.g8726c260e
