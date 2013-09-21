From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH] doc: git-foo was obsoleted several years ago
Date: Sat, 21 Sep 2013 06:37:09 -0500
Message-ID: <1379763429-3443-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 13:42:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNLaA-0003b6-NL
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 13:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab3IULmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 07:42:35 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:57398 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab3IULme (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 07:42:34 -0400
Received: by mail-ob0-f176.google.com with SMTP id uy5so1796771obc.21
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VIM2kHT6FOApisdwefj7MEgLnFBK0F2sxc8Drw59FNw=;
        b=IIMT4y4vn+1tGuZoLAhLSdSqhlp9YRFUpGXEaKtZFD7eCd8NYuOhVFdf8mvcp2Dl69
         hJZCM3lzyNN+sBMWYsWRrimLlczEEc70CR8GgVWL1W/hqjCVTU/noOpPSFEp+Vwo4VOf
         kXqzCRBdnu+UguOBvCxEHl+mxWremYJcKPo4M25Cs8KzT6njlE0tlR1reAUhTmZYguju
         bl8zVGeWz8QlY+RymoWEYzqjMATqk1HYCO8/bumlQpI9cvjxPFcR34nZ8x6yhcieKqAi
         TTGUFVrTeWIs/gFEG3oBkZFhPDYxDWsR4UxxWOal5RUmhfUvuCVVqp9FI8ono5/nfRSt
         QdYw==
X-Received: by 10.182.181.34 with SMTP id dt2mr10189595obc.30.1379763753727;
        Sat, 21 Sep 2013 04:42:33 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm7211416oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 04:42:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.9.g218b36e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235096>

So replace 'git-foo' with 'git foo'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-checkout.txt | 4 ++--
 Documentation/git-commit.txt   | 4 ++--
 Documentation/git-rebase.txt   | 4 ++--
 Documentation/git-status.txt   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ca118ac..8d98383 100644
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
index 6b2e1c8..ed4f5f6 100644
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
index 9046df9..a128453 100644
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
1.8.4.9.g218b36e.dirty
