Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EDC520C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753929AbdLHPSb (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:18:31 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:43494 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbdLHPSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:18:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 52C9BA0168
        for <git@vger.kernel.org>; Fri,  8 Dec 2017 16:18:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 26vLq7joXwTg for <git@vger.kernel.org>;
        Fri,  8 Dec 2017 16:18:28 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 97E14A0095
        for <git@vger.kernel.org>; Fri,  8 Dec 2017 16:18:28 +0100 (CET)
Received: from dnl-413.univ-lyon1.fr (134.214.126.172) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Fri, 8 Dec 2017 16:18:33 +0100
From:   Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
To:     <git@vger.kernel.org>
CC:     Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Subject: [PATCH] doc: reword gitworflows for neutrality
Date:   Fri, 8 Dec 2017 16:18:07 +0100
Message-ID: <20171208151807.3569-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [134.214.126.172]
X-ClientProxiedBy: JPMBX2013-02.univ-lyon1.fr (134.214.201.246) To
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changed 'he' to 'them' to be more neutral in "gitworkflows.txt".

See discussion at: https://public-inbox.org/git/xmqqvahieeqy.fsf@gitster.mtv.corp.google.com/

Signed-off-by: Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
---
 Documentation/gitworkflows.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 02569d0..926e044 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -407,8 +407,8 @@ follows.
 `git pull <url> <branch>`
 =====================================
 
-Occasionally, the maintainer may get merge conflicts when he tries to
-pull changes from downstream.  In this case, he can ask downstream to
+Occasionally, the maintainer may get merge conflicts when they try to
+pull changes from downstream.  In this case, they can ask downstream to
 do the merge and resolve the conflicts themselves (perhaps they will
 know better how to resolve them).  It is one of the rare cases where
 downstream 'should' merge from upstream.
-- 
2.11.0

