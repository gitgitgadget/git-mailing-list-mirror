Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A79E20954
	for <e@80x24.org>; Wed, 22 Nov 2017 17:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdKVRaQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 12:30:16 -0500
Received: from marot.dh.bytemark.co.uk ([212.110.172.17]:38892 "EHLO
        marot.bettens.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbdKVRaP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:30:15 -0500
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Nov 2017 12:30:15 EST
Received: by marot.bettens.info (Sendmail new on BidulOS, from userid 65534)
        id 3A5BE57058B; Wed, 22 Nov 2017 18:25:09 +0100 (CET)
Received: from machaut.bettens.info (dslgva4378.worldcom.ch [83.172.215.76])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by marot.bettens.info (Sendmail new on BidulOS) with ESMTPS id 5079257057F;
        Wed, 22 Nov 2017 18:25:05 +0100 (CET)
Received: from hadronsson.ici (hadronsson-fil.ici [192.168.1.9])
        by machaut.bettens.info (Postfix) with ESMTP id 2E8E31C9D;
        Wed, 22 Nov 2017 18:25:04 +0100 (CET)
From:   Louis Bettens <louis@bettens.info>
To:     git@vger.kernel.org
Cc:     jn.avila@free.fr, worldhello.net@gmail.com,
        Louis Bettens <louis@bettens.info>
Subject: [PATCH] fix french translation
Date:   Wed, 22 Nov 2017 18:24:40 +0100
Message-Id: <20171122172440.15106-2-louis@bettens.info>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171122172440.15106-1-louis@bettens.info>
References: <20171122172440.15106-1-louis@bettens.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Louis Bettens <louis@bettens.info>
---
 po/fr.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/fr.po b/po/fr.po
index 4deae3318..a12a2ae37 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -14331,7 +14331,7 @@ msgstr "git worktree add [<options>] <chemin> [<branche>]"
 
 #: builtin/worktree.c:17
 msgid "git worktree list [<options>]"
-msgstr "git worktree prune [<options>]"
+msgstr "git worktree list [<options>]"
 
 #: builtin/worktree.c:18
 msgid "git worktree lock [<options>] <path>"
-- 
2.15.0

