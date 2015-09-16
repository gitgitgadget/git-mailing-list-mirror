From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 2 messages
Date: Wed, 16 Sep 2015 19:33:37 +0200
Message-ID: <1442424817-10972-1-git-send-email-ralf.thielow@gmail.com>
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 19:33:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcGaf-00062T-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 19:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbbIPRdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 13:33:49 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34338 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbbIPRds (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 13:33:48 -0400
Received: by wicfx3 with SMTP id fx3so83714360wic.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7Y5gghemEeZ88zvQ3wgFvCtlQ9FGGowdOi45Zzsy+DY=;
        b=FJtAM/iEv8ONUyzNpKuqRQItZ2hE3sGecxQA0GFu3eUbciiLqyaaEcjaXbz8KWDqRh
         5C8iY+OodIB+GTszQgn7bXdg2gHJRPcTu8z5+kWXUryXhfZBo3J/G7z1oTxOWFypXEHL
         ej+zGKYDGeo+1mxpFfMbPZlVrDEQn6EPzn02Si74bFrMQ5N+TyGimbDdaiPpIQgeBYxI
         nUxOBfsgJ5JTNBYlMxt1kWXkOpV2kGKG97+quLEbE/axBDcJ8NtQ8xahfRX/h2M5n4Im
         jKgl0xCnjFcbnlafQahgu5NCgtEzbQU+WyOQdrPvAFnzfaKLVW//EunVv24x9f43VCiB
         zwsA==
X-Received: by 10.194.110.37 with SMTP id hx5mr54351685wjb.149.1442424827574;
        Wed, 16 Sep 2015 10:33:47 -0700 (PDT)
Received: from localhost (cable-62-117-27-190.cust.telecolumbus.net. [62.117.27.190])
        by smtp.gmail.com with ESMTPSA id bq7sm27597595wjc.31.2015.09.16.10.33.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 10:33:46 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc1.199.g678474c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278038>

Translate 2 messages came from git.pot update in e447091
(l10n: git.pot: v2.6.0 round 2 (3 improvements)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/po/de.po b/po/de.po
index e5b523d..c9b4d16 100644
--- a/po/de.po
+++ b/po/de.po
@@ -10530,9 +10530,8 @@ msgstr ""
 "hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [<Muster>...] "
 
 #: builtin/show-ref.c:11
-#, fuzzy
 msgid "git show-ref --exclude-existing[=<pattern>] < <ref-list>"
-msgstr "git show-ref --exclude-existing[=Muster] < ref-list"
+msgstr "git show-ref --exclude-existing[=<Muster>] < <Referenzliste>"
 
 #: builtin/show-ref.c:170
 msgid "only show tags (can be combined with heads)"
@@ -10761,9 +10760,8 @@ msgid "replace the tag if exists"
 msgstr "das Tag ersetzen, wenn es existiert"
 
 #: builtin/tag.c:609 builtin/update-ref.c:368
-#, fuzzy
 msgid "create a reflog"
-msgstr "create_reflog"
+msgstr "Reflog erstellen"
 
 #: builtin/tag.c:611
 msgid "Tag listing options"
-- 
2.6.0.rc1.199.g678474c
