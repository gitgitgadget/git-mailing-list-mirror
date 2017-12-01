Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CFCE20954
	for <e@80x24.org>; Fri,  1 Dec 2017 22:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdLAWTX (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 17:19:23 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:40166 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdLAWTX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 17:19:23 -0500
Received: from fizzler.bingo (xc347130c.dyn.telefonica.de [195.71.19.12])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 693AD140CAE;
        Fri,  1 Dec 2017 23:19:21 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 195.71.19.12) smtp.mailfrom=rabel@robertabel.eu smtp.helo=fizzler.bingo
Received-SPF: pass (mxf98a: connection is authenticated)
From:   Robert Abel <rabel@robertabel.eu>
To:     git@vger.kernel.org
Cc:     Robert Abel <rabel@robertabel.eu>
Subject: [PATCH] l10n: update de_DE translation
Date:   Fri,  1 Dec 2017 23:20:55 +0100
Message-Id: <20171201222055.4723-1-rabel@robertabel.eu>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <20171201221921.2011.3185@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Der-, die- and dasselbe and their declensions are spelt as one word in German.

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 po/de.po | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/de.po b/po/de.po
index a05aca5f3..400262625 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2925,7 +2925,7 @@ msgstr "  (benutzen Sie \"git branch --unset-upstream\" zum Beheben)\n"
 #: remote.c:2083
 #, c-format
 msgid "Your branch is up to date with '%s'.\n"
-msgstr "Ihr Branch ist auf dem selben Stand wie '%s'.\n"
+msgstr "Ihr Branch ist auf demselben Stand wie '%s'.\n"
 
 #: remote.c:2087
 #, c-format
@@ -10874,7 +10874,7 @@ msgstr "Kann nicht überschreiben"
 
 #: builtin/mv.c:239
 msgid "multiple sources for the same target"
-msgstr "mehrere Quellen für das selbe Ziel"
+msgstr "mehrere Quellen für dasselbe Ziel"
 
 #: builtin/mv.c:241
 msgid "destination directory does not exist"
@@ -11827,7 +11827,7 @@ msgstr ""
 "\n"
 "    git push %s HEAD:%s\n"
 "\n"
-"Um auf den Branch mit dem selben Namen im Remote-Repository zu versenden,\n"
+"Um auf den Branch mit demselben Namen im Remote-Repository zu versenden,\n"
 "benutzen Sie:\n"
 "\n"
 "    git push %s %s\n"
-- 
2.15.1

