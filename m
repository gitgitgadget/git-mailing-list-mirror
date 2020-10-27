Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DA0C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 12:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1978422447
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 12:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899821AbgJ0MZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 08:25:14 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:34046 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899815AbgJ0MZN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 08:25:13 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 5CB723A92D8
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [82.66.241.80])
        (Authenticated sender: b@ptistefontaine.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7BD4024001F;
        Tue, 27 Oct 2020 12:06:42 +0000 (UTC)
From:   Baptiste Fontaine <b@ptistefontaine.fr>
To:     git@vger.kernel.org
Cc:     Baptiste Fontaine <b@ptistefontaine.fr>
Subject: [PATCH] l10n: fr.po Fix a typo
Date:   Tue, 27 Oct 2020 13:06:12 +0100
Message-Id: <20201027120611.5084-1-b@ptistefontaine.fr>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Baptiste Fontaine <b@ptistefontaine.fr>
---
 po/fr.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git po/fr.po po/fr.po
index f510f0bc6f..b1cbaca24d 100644
--- po/fr.po
+++ po/fr.po
@@ -8282,7 +8282,7 @@ msgstr ""
 #: sha1-name.c:1717
 #, c-format
 msgid "path '%s' does not exist in '%.*s'"
-msgstr "le chemin '%s' n'existe pas dnas '%.*s'"
+msgstr "le chemin '%s' n'existe pas dans '%.*s'"
 
 #: sha1-name.c:1745
 #, c-format
-- 
2.28.0

