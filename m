From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/20] doc: git-foo was obsoleted several years ago
Date: Sat, 12 Oct 2013 02:06:56 -0500
Message-ID: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtO8-0005Ta-Bm
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502Ab3JLHNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:20 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:57899 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462Ab3JLHNR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:17 -0400
Received: by mail-oa0-f42.google.com with SMTP id g12so3124591oah.15
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Rm5zEO3e82l3Q4rzAjiu31XnaMJoNIo8YdkfzLgqDWE=;
        b=G2hq0kVyNsug2I0vRP/EFUnSY7aOgCqLlAvTVTkSUbIK/4NEZ2bkALEjOIJKKDnGU4
         cOxVUGrVkuEj1/WTMzunD6jWqRS/LbjlzKuk1GvwLzr35aHTMsY/Hw/sx5y1N2jlQ9n2
         hNxvsmCMRhXQd3KSJppa0D1nrxBFRgTn+giVXn0l8Hi5Y2Gpt8j+IfUJ2xnMmtWUisqp
         xtsl1jLIW5VQ8b1I6oj9OqpQk90aBMv+24vyixI8SAUHph/DL1CZ4dVfUBpo6HvApZ4q
         K/k4oNV/xoIx0sYHBf3gmyAXpdycRdaVCfWQCMuxm6qmOo1ru3JGOrxOZZUh2qqUxXRA
         wFSA==
X-Received: by 10.60.33.74 with SMTP id p10mr17759139oei.18.1381561997329;
        Sat, 12 Oct 2013 00:13:17 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm101394250oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236010>

So replace 'git-foo' with 'git foo'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-checkout.txt | 4 ++--
 Documentation/git-commit.txt   | 4 ++--
 Documentation/git-rebase.txt   | 4 ++--
 Documentation/git-status.txt   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 91294f8..7560113 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -1,9 +1,9 @@
-git-checkout(1)
+git checkout(1)
 ===============
 
 NAME
 ----
-git-checkout - Checkout a branch or paths to the working tree
+git checkout - Checkout a branch or paths to the working tree
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1a7616c..51f6b81 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -1,9 +1,9 @@
-git-commit(1)
+git commit(1)
 =============
 
 NAME
 ----
-git-commit - Record changes to the repository
+git commit - Record changes to the repository
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 94e07fd..9a8d158 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -1,9 +1,9 @@
-git-rebase(1)
+git rebase(1)
 =============
 
 NAME
 ----
-git-rebase - Forward-port local commits to the updated upstream head
+git rebase - Forward-port local commits to the updated upstream head
 
 SYNOPSIS
 --------
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index a4acaa0..6fb7561 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -1,9 +1,9 @@
-git-status(1)
+git status(1)
 =============
 
 NAME
 ----
-git-status - Show the working tree status
+git status - Show the working tree status
 
 
 SYNOPSIS
-- 
1.8.4-fc
