Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC4CC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 20:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E146B20787
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 20:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgCaUh2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:37:28 -0400
Received: from a3.inai.de ([88.198.85.195]:43998 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgCaUh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 16:37:28 -0400
Received: by a3.inai.de (Postfix, from userid 65534)
        id 0E23A5872C954; Tue, 31 Mar 2020 22:37:27 +0200 (CEST)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id CA7435872C1A9
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 22:37:26 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     git@vger.kernel.org
Subject: [PATCH] l10n: de.po: fix spello in the German variant of octopus
Date:   Tue, 31 Mar 2020 22:37:26 +0200
Message-Id: <20200331203726.28613-1-jengelh@inai.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index cfe50c1055..fd545bc2f2 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7307,7 +7307,7 @@ msgstr "Nichts zum Zusammenführen: '%.*s'"
 #: sequencer.c:3418
 msgid "octopus merge cannot be executed on top of a [new root]"
 msgstr ""
-"Octupus-Merge kann nicht auf Basis von [neuem Root-Commit] ausgeführt werden."
+"Oktopus-Merge kann nicht auf Basis von [neuem Root-Commit] ausgeführt werden."
 
 #: sequencer.c:3434
 #, c-format
-- 
2.26.0

