From: Phillip Sz <phillip.szelat@gmail.com>
Subject: [PATCH] l10n: de.po: better language for 2 strings
Date: Thu, 17 Sep 2015 17:50:32 +0200
Message-ID: <1442505032-11578-1-git-send-email-phillip.szelat@gmail.com>
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com,
	ralf.thielow@gmail.com, Phillip Sz <phillip.szelat@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 17:50:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcbSL-0002TB-HM
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 17:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbbIQPuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 11:50:37 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33653 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbbIQPug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 11:50:36 -0400
Received: by wiclk2 with SMTP id lk2so30004502wic.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LC2uEcmGXQNzZPubuvbtXm2h6q6oiKKO9mftwX0Jeak=;
        b=iY4eAagtOB7ogqTAKXCMb+3kXFII8jT+cXWNPXm6rIeBNec2+IskUVNCiCzHu1ywB2
         XSLRs7SGb+gTttrE3lsr16Uj4PBSE6mrSG2ucz7uhKFoTWAB4Xzp/OMKUHhFf1yd8E66
         3oVq15yyFkq9CoaVM1AizkTFTCqldIhE8iD9jEVvdPCYdsyfouDYDp56mWbTqdb229li
         kB7z7Jr0OliORYlcoSwoNomIAPcyaCrCMc+UZPz6LADheCRi9ssx8/LF5Jm45ArreHCQ
         i6hJOH/+gR/v0Z2/7cB+asOWXkxxTcNTwXAbe7NQCSG7vngMem7H2JjJpaheA/QvPHea
         Eg5g==
X-Received: by 10.194.86.161 with SMTP id q1mr66577986wjz.18.1442505035868;
        Thu, 17 Sep 2015 08:50:35 -0700 (PDT)
Received: from arch.fritz.box (i577ABECB.versanet.de. [87.122.190.203])
        by smtp.gmail.com with ESMTPSA id bs8sm4043040wjc.47.2015.09.17.08.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Sep 2015 08:50:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278126>

just 2 strings I think we could translate better.

Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
---
 po/de.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/de.po b/po/de.po
index 6ed3509..2f54093 100644
--- a/po/de.po
+++ b/po/de.po
@@ -10785,7 +10785,7 @@ msgid ""
 "it will be removed. Please do not use it anymore."
 msgstr ""
 "Die -b/--binary Option hat seit Langem keinen Effekt und wird\n"
-"entfernt. Bitte nicht mehr verwenden."
+"entfernt. Bitte verwenden Sie diese nicht mehr."
 
 #: git-am.sh:507
 #, sh-format
@@ -10795,7 +10795,7 @@ msgstr ""
 
 #: git-am.sh:512
 msgid "Please make up your mind. --skip or --abort?"
-msgstr "Bitte werden Sie sich klar. --skip oder --abort?"
+msgstr "Bitte entscheiden Sie sich. --skip oder --abort?"
 
 #: git-am.sh:560
 #, sh-format
-- 
2.5.2
