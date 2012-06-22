From: Leila Muhtasib <muhtasib@gmail.com>
Subject: [PATCH] Documentation: Fix misspellings
Date: Fri, 22 Jun 2012 14:22:09 -0400
Message-ID: <1340389329-18325-1-git-send-email-muhtasib@gmail.com>
Cc: Leila Muhtasib <muhtasib@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 20:30:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si8ct-0001Fz-Tx
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 20:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab2FVSa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 14:30:29 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50651 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab2FVSa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 14:30:28 -0400
Received: by qadb17 with SMTP id b17so519757qad.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Taylgcvhc1f9rXRiDG4RH1FG9nuxKJ9X0vRuJpnMbAY=;
        b=PJaycgoA2OnPysTvH/kiHe4L4OPsnBCQmds36VCL03qAYt0n5K4/XT5aPy0hN1a4o6
         QxEQ/wgtCwmaP+fbdivXuClgWWdHju0zt+dTy5L5K4CK+6bhTeJG3DL4RkC8NetI3VTx
         HLMYi4/EXVagCjWSog0Uuz3letgtcVL1hgWTB3Nx1C+iummSbhXW3JZ57ydBb417zeBY
         /U5HPvsTwUVyvuzwKo7Uj0JKiIUCO4GIRKtQmJ7bkgNevo55eNFaHEkHAyhfMdusjoqA
         Ld2IGc0eHL/0fkKx6hnwCWLMK/3CS8fiuavcg2xLQu7INWhqm6Sp4x7+jPi4Tfk+MXQx
         Gvvw==
Received: by 10.229.135.196 with SMTP id o4mr1581830qct.154.1340389336573;
        Fri, 22 Jun 2012 11:22:16 -0700 (PDT)
Received: from localhost ([38.117.156.148])
        by mx.google.com with ESMTPS id gv1sm3654923qab.8.2012.06.22.11.22.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Jun 2012 11:22:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.5 (Apple Git-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200456>


Signed-off-by: Leila Muhtasib <muhtasib@gmail.com>
---
 Documentation/diff-options.txt  |    2 +-
 Documentation/git-submodule.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6cfedd8..cf4b216 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -59,7 +59,7 @@ endif::git-format-patch[]
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
 	part. Maximum width defaults to terminal width, or 80 columns
-	if not connected to a terminal, and can be overriden by
+	if not connected to a terminal, and can be overridden by
 	`<width>`. The width of the filename part can be limited by
 	giving another width `<name-width>` after a comma. The width
 	of the graph part can be limited by using
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 9e488c0..fbbbcb2 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -140,7 +140,7 @@ update::
 	checkout the commit specified in the index of the containing repository.
 	This will make the submodules HEAD be detached unless `--rebase` or
 	`--merge` is specified or the key `submodule.$name.update` is set to
-	`rebase`, `merge` or `none`. `none` can be overriden by specifying
+	`rebase`, `merge` or `none`. `none` can be overridden by specifying
 	`--checkout`.
 +
 If the submodule is not yet initialized, and you just want to use the
-- 
1.7.7.5 (Apple Git-26)
