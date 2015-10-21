From: Thomas Schneider <thosch97@gmail.com>
Subject: [PATCH] fr.po: Fix "uptream" typo
Date: Wed, 21 Oct 2015 15:25:59 +0200
Message-ID: <1445433959-11240-1-git-send-email-thosch97@gmail.com>
Cc: git@vger.kernel.org, Thomas Schneider <thosch97@gmail.com>
To: jn.avila@free.fr
X-From: git-owner@vger.kernel.org Wed Oct 21 15:26:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZotPA-0007RJ-B7
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 15:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbbJUN0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 09:26:08 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37463 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbJUN0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 09:26:06 -0400
Received: by wicfv8 with SMTP id fv8so75027634wic.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TQLTkUzl9Ra8A8pWq1kvcCBhcMOLf/KXwaqHx/GnUFU=;
        b=mUwq2qnAkOPvUGhm4gbMph7Oq27cSeqQ9+/4qV17it27pu4h5idKPFOzczNjAHoioI
         kIxz9XTnK0nyCUbnZyRZ80IUp+JwXK0rLlTnlx1BqSB6zfxuN51dInYScOG6xJ4uj8w2
         +BjigQVhDm6dqQVVRPVwuTz+4vG3e64QcKerQ2iVTNU6yEivctpcrF4840JjicxiJuku
         78KOxRDhg/B9aEi+FKvk3wWN9w1I5Ww4Qh1EvvC0IdyZ04FUe1UouTC9yc2/T40xxcVO
         5lAru8vx0wNfbxH1HBrBnw1fXjGzos8LGT9Xz6kOuovmnOcdo70LMb9KsqpqUpYYAGk9
         uNzw==
X-Received: by 10.180.37.76 with SMTP id w12mr11682193wij.0.1445433964621;
        Wed, 21 Oct 2015 06:26:04 -0700 (PDT)
Received: from tatooine.eduroam.rwth-aachen.de (186-098.eduroam.rwth-aachen.de. [134.61.186.98])
        by smtp.gmail.com with ESMTPSA id g9sm10829039wix.1.2015.10.21.06.26.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2015 06:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279982>

Signed-off-by: Thomas Schneider <thosch97@gmail.com>
---
 po/fr.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/fr.po b/po/fr.po
index 581167f..71c4b54 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -8862,7 +8862,7 @@ msgstr ""
 "Si vous souhaitez indiquer l'information de suivi distant pour cette "
 "branche, vous pouvez le faire avec :\n"
 "\n"
-"git branch --set-uptream-to=%s/<branche> %s\n"
+"git branch --set-upstream-to=%s/<branche> %s\n"
 
 #: builtin/pull.c:476
 #, c-format
-- 
2.4.3
