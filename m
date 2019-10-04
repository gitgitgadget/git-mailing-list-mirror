Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775B01F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 22:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfJDWaB (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 18:30:01 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39409 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfJDWaB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 18:30:01 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost.localdomain (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1AB8B40005;
        Fri,  4 Oct 2019 22:29:58 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation: update the location of the git-gui repo
Date:   Sat,  5 Oct 2019 03:59:56 +0530
Message-Id: <20191004222956.12341-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 Documentation/git-gui.txt | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 5f93f8003d..98337b69f1 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -114,13 +114,9 @@ of end users.
 
 A 'git gui' development repository can be obtained from:
 
-  git clone git://repo.or.cz/git-gui.git
+  git clone https://github.com/prati0100/git-gui.git
 
-or
-
-  git clone http://repo.or.cz/r/git-gui.git
-
-or browsed online at http://repo.or.cz/w/git-gui.git/[].
+or browsed online at https://github.com/prati0100/git-gui[].
 
 GIT
 ---
-- 
2.21.0

