From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 13/13] Fixup! doc: giteveryday and user-manual man format
Date: Sat, 23 Feb 2013 23:06:01 +0000
Message-ID: <1361660761-1932-14-git-send-email-philipoakley@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:06:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9OB0-0004hu-N9
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 00:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759322Ab3BWXGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 18:06:12 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:58001 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759203Ab3BWXGH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 18:06:07 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EANpKKVFZ8rke/2dsb2JhbABFwVGBCBdzgiABBVYzCEk5HgYTiBe+fo8Vg0ADpyKDBw
X-IronPort-AV: E=Sophos;i="4.84,724,1355097600"; 
   d="scan'208";a="409919205"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 23 Feb 2013 23:06:06 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216931>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/giteveryday.txt    | 10 ++++++++--
 Documentation/gituser-manual.txt |  7 ++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index e1fba85..3f11787 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -1,6 +1,12 @@
-Everyday Git With 20 Commands Or So
-===================================
+Everyday-Git(7)
+===============
 
+NAME
+----
+giteveryday - A useful minimum set of commands for Everyday Git 
+
+SYNOPSIS
+--------
 <<Individual Developer (Standalone)>> commands are essential for
 anybody who makes a commit, even for somebody who works alone.
 
diff --git a/Documentation/gituser-manual.txt b/Documentation/gituser-manual.txt
index a4778d7..e991b11 100644
--- a/Documentation/gituser-manual.txt
+++ b/Documentation/gituser-manual.txt
@@ -1,7 +1,12 @@
 Git User's Manual (for version 1.5.3 or newer)
-______________________________________________
+==============================================
 
+NAME
+----
+gituser-manual - User Manual for Git, the stupid content tracker
 
+SYNOPSIS
+--------
 Git is a fast distributed revision control system.
 
 This manual is designed to be readable by someone with basic UNIX
-- 
1.8.1.msysgit.1
