Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9866E2022D
	for <e@80x24.org>; Tue, 28 Feb 2017 08:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbdB1I7Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 03:59:16 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:40080 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbdB1I7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 03:59:15 -0500
Received: from localhost (x55b3852d.dyn.telefonica.de [85.179.133.45])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id E605C178870;
        Tue, 28 Feb 2017 09:59:08 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] docs/diffcore: fix grammar in diffcore-rename header
Date:   Tue, 28 Feb 2017 09:59:04 +0100
Message-Id: <2882e77a58e4219d60a39827c3ea8d4537d5178a.1488272203.git.patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/gitdiffcore.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 46bc6d077..cf009a187 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -119,7 +119,7 @@ the original is used), and can be customized by giving a number
 after "-B" option (e.g. "-B75" to tell it to use 75%).
 
 
-diffcore-rename: For Detection Renames and Copies
+diffcore-rename: For Detecting Renames and Copies
 -------------------------------------------------
 
 This transformation is used to detect renames and copies, and is
-- 
2.12.0

