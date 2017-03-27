Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13251FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 16:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbdC0Qu7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 12:50:59 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbdC0Qu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 12:50:56 -0400
Received: from localhost ([178.11.46.195]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MV4iD-1cdy3A2Cgn-00YRqj; Mon, 27 Mar 2017 18:50:09 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH v2 2/2] l10n: de: translate describe debug terms
Date:   Mon, 27 Mar 2017 18:50:06 +0200
Message-Id: <685807568fdafc86707e7c99e82bf03ef8ff3a87.1490633145.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.584.g7becbf139a
In-Reply-To: <xmqqpohf7opl.fsf@gitster.mtv.corp.google.com>
References: <xmqqpohf7opl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <cover.1490633145.git.git@grubix.eu>
References: <cover.1490633145.git.git@grubix.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:F7t6jsxFImqPb86ZQkgO/yPgQ7tsDXX87xnnsM8n69e5izb4tIJ
 nb/BU1oJxHNJgIEKzlf4Yf1F4Opoeecp2iyO0FNhKfsbMoR7Y/bgyeJ1yEMHnzMBaC81nfj
 zJPHcMLwxXEE7B42IrjF8Mg86Kc7jOuW4by2cjthtBkZwsbHnTUUmghyeOwgPwVJRjV79FT
 vI4WUoWyj3qe7sKCeoMVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:znulihbvV2w=:8HE9pSudDHjhkBiJbCrcFU
 xbgcClHhgcKf5McsqIpANgOM48tc8FF6CTatuN8WSsRzoUnzROdLg+28eVhvgFS1Y6oWnekuN
 uyO45PAIxioH/9FZiftGVCEkvHAWtCnwOjMsmKklC4ri8RDwE3U3oZbAd4je4tqFNOZAlEL5p
 XnXYP+RezjzYdGWslkfdAAKY6aNVUmhIz4m0PsNSANM3oPA0CkRb6ip5baZVPw8ljnvqpwahP
 +T/973J+2WZgRvdHJpMxUkyFD/FaGX6IeoH0yc+NlKgEnyqqV9JVRa12D/TxKyeBjAKZ01c1b
 gEZx16xmGdGMx6i7bhtndMWcvdS73RteDXwXZXwtK4MMA3M3eL//uTwvWoGLqTcl1Kjo31MVN
 bkdZhz0HKCIPc3vYIRuU0ZsDlKAZB9dbxIrMoQOgmDDIKBKV/8eh5W7MdZegTJf7IMkIw3fzc
 a8dPRJ0N6oMNYfG/PvzuA6+9laZi0NtXVb6c6JewI74zB5Jyd1HkaiD58Uzv4sFcS/692b/yl
 muY8xVjQXt9wZCc3WgaerbzOQCNOvXTQSStvlL9kobxvHP52L062PnQiWryZKxEbRMAhGltSH
 TKqcWafC66pMXo9cduW0YUYswfwG2jhRlQjye4LfbJs0Z6pTtkoZgLhtPVXJ8cpb+yECSFA4u
 5gAH9jzfW0LQQNLfOXuNp7lUOBoB8VT8Z6Ra9hPeVkCIP3gZl5Ll04z/Ko085n/Xs5TQYI6Je
 ZEMa4muMegAY8h+X
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 po/de.po | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index e9c86f5488..913db393dc 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7530,7 +7530,19 @@ msgstr "git describe [<Optionen>] [<Commit-Angabe>...]"
 msgid "git describe [<options>] --dirty"
 msgstr "git describe [<Optionen>] --dirty"
 
-#: builtin/describe.c:217
+#: builtin/describe.c:52
+msgid "head"
+msgstr "Branch"
+
+#: builtin/describe.c:52
+msgid "lightweight"
+msgstr "nicht-annotiert"
+
+#: builtin/describe.c:52
+msgid "annotated"
+msgstr "annotiert"
+
+#: builtin/describe.c:249
 #, c-format
 msgid "annotated tag %s not available"
 msgstr "annotiertes Tag %s ist nicht verfügbar"
-- 
2.12.2.584.g7becbf139a

