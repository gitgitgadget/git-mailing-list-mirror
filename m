Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42D8420248
	for <e@80x24.org>; Sat,  6 Apr 2019 13:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDFN1z (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 09:27:55 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:33540 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDFN1y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 09:27:54 -0400
Received: from localhost.localdomain ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id ClMPhui0snuQZClMPhhS4Q; Sat, 06 Apr 2019 14:27:53 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=xtxXYLxNAAAA:8 a=hkU2WXdTQEN3TPVW-2gA:9 a=xts0dhWdiJbonKbuqhAr:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Subject: [PATCH 1/2] rerere doc: quote `rerere.enabled`
Date:   Sat,  6 Apr 2019 14:27:46 +0100
Message-Id: <20190406132747.16376-2-philipoakley@iee.org>
X-Mailer: git-send-email 2.21.0.windows.1.80.gdc2ae9a382
In-Reply-To: <20190406132747.16376-1-philipoakley@iee.org>
References: <20190406132747.16376-1-philipoakley@iee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfIJSaphgkdVtW9NslD+hPLy9IwXyHxIv7UvRROOl6i31LV0/wJRzDkdOg8DD7W/EIyDVSIkuiNS40P/rwnxuzhfFU2cXzo6sCUT53CKNyG9Hj8cfjUb7
 8JnlWLEB4IjbsvirAfkP5fgXNEU07oRUgza/z8WQFDkLA3Oxvkgg7rjCoxOHeH3FN+yEiVK9YuvO+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
Noticed while attempting to train the Git-for-Windows rebasing-
merge series.
---
 Documentation/git-rerere.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index df310d2a58..95763d7581 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -24,7 +24,7 @@ on the initial manual merge, and applying previously recorded
 hand resolutions to their corresponding automerge results.
 
 [NOTE]
-You need to set the configuration variable rerere.enabled in order to
+You need to set the configuration variable `rerere.enabled` in order to
 enable this command.
 
 
-- 
2.21.0.windows.1.80.gdc2ae9a382

