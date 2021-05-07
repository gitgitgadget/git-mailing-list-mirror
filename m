Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CD8C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 06:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E9D613DD
	for <git@archiver.kernel.org>; Fri,  7 May 2021 06:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhEGG1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 02:27:20 -0400
Received: from smtp512.hk.chengmail.me ([113.10.190.174]:32936 "EHLO
        smtp512.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhEGG1T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 02:27:19 -0400
X-CHENGMAILHOST: 113.10.190.174
X-CHENGMAIL-INSTANCEID: 4e3e.6094dd88.9d9cd.0
From:   lilinchao@oschina.cn
To:     git@vger.kernel.org
Cc:     Li Linchao <lilinchao@oschina.cn>
Subject: [PATCH] Fix typo in Documentation/RelNotes/2.31.0.txt
Date:   Fri,  7 May 2021 14:26:12 +0800
X-source-message-id: <20210507062612.13326-1-lilinchao@oschina.cn>
X-Mailer: git-send-email 2.31.1.442.g7e39198978
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <21c2f550aefd11eb9a470026b95c99cc@oschina.cn>
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

