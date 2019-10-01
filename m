Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2A81F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 14:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfJAOOz (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 10:14:55 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51209 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJAOOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 10:14:55 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost.localdomain (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0202640002;
        Tue,  1 Oct 2019 14:14:52 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH] SubmittingPatches: update git-gui maintainer information
Date:   Tue,  1 Oct 2019 19:44:35 +0530
Message-Id: <20191001141435.21787-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since I have taken over maintainership of git-gui, it is a good idea to
point new contributors to my fork of the project, so they can see the
latest version of the project.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 Documentation/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 6d589e118c..06bfaf1c1c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -372,9 +372,9 @@ such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
 Some parts of the system have dedicated maintainers with their own
 repositories.

-- `git-gui/` comes from git-gui project, maintained by Pat Thoyts:
+- `git-gui/` comes from git-gui project, maintained by Pratyush Yadav:

-	git://repo.or.cz/git-gui.git
+	https://github.com/prati0100/git-gui

 - `gitk-git/` comes from Paul Mackerras's gitk project:

--
2.21.0

