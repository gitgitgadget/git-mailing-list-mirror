Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A094C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 06:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64A0613EA
	for <git@archiver.kernel.org>; Fri,  7 May 2021 06:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhEGGX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 02:23:26 -0400
Received: from smtp517.hk.chengmail.me ([113.10.190.201]:43270 "EHLO
        smtp517.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhEGGXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 02:23:25 -0400
X-CHENGMAILHOST: 113.10.190.201
X-CHENGMAIL-INSTANCEID: 140e.6094dc9a.94704.0
From:   lilinchao@oschina.cn
To:     git@vger.kernel.org
Cc:     Li Linchao <lilinchao@oschina.cn>
Subject: [PATCH] Fix type in Documentation/RelNotes/2.31.0.txt
Date:   Fri,  7 May 2021 14:21:46 +0800
X-source-message-id: <20210507062146.12883-1-lilinchao@oschina.cn>
X-Mailer: git-send-email 2.31.1.442.g7e39198978
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <93f1d430aefc11ebb63c0024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Li Linchao <lilinchao@oschina.cn>

replace 'whey' with `when`

Signed-off-by: Li Linchao <lilinchao@oschina.cn>
---
 Documentation/RelNotes/2.31.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.31.0.txt b/Documentation/RelNotes/2.31.0.txt
index cf0c7d8d40..617d211f3f 100644
--- a/Documentation/RelNotes/2.31.0.txt
+++ b/Documentation/RelNotes/2.31.0.txt
@@ -49,7 +49,7 @@ UI, Workflows & Features
    @{1}, but we failed to answer "what commit were we on?", i.e. @{1}
 
  * "git bundle" learns "--stdin" option to read its refs from the
-   standard input.  Also, it now does not lose refs whey they point
+   standard input.  Also, it now does not lose refs when they point
    at the same object.
 
  * "git log" learned a new "--diff-merges=<how>" option.
-- 
2.31.1.442.g7e39198978

