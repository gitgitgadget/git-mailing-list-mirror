From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/4] Don't use section 7 for main manpage.
Date: Sat, 07 Apr 2007 23:36:58 +0200
Message-ID: <20070407213658.13698.44552.stgit@gandelf.nowhere.earth>
References: <20070407213557.13698.21486.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 00:03:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaIb2-0002xI-GQ
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 23:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966355AbXDGVhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 17:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966357AbXDGVhQ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 17:37:16 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51821 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966355AbXDGVhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 17:37:14 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 651AE5DF83;
	Sat,  7 Apr 2007 23:37:13 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 4765F1F096;
	Sat,  7 Apr 2007 23:36:58 +0200 (CEST)
In-Reply-To: <20070407213557.13698.21486.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43987>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/COMMAND-TEMPLATE.txt |    2 +-
 Documentation/stg-cp.txt           |    2 +-
 Documentation/stg-new.txt          |    2 +-
 Documentation/stg.txt              |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/COMMAND-TEMPLATE.txt b/Documentation/COMMAND-TEMPLATE.txt
index 5d8a1a9..e49a44d 100644
--- a/Documentation/COMMAND-TEMPLATE.txt
+++ b/Documentation/COMMAND-TEMPLATE.txt
@@ -38,4 +38,4 @@ GIT CONFIGURATION VARIABLES
 
 StGIT
 -----
-Part of the StGIT suite - see gitlink:stg[7].
+Part of the StGIT suite - see gitlink:stg[1].
diff --git a/Documentation/stg-cp.txt b/Documentation/stg-cp.txt
index 723d811..d28c619 100644
--- a/Documentation/stg-cp.txt
+++ b/Documentation/stg-cp.txt
@@ -57,4 +57,4 @@ FUTURE OPTIONS
 
 StGIT
 -----
-Part of the StGIT suite - see gitlink:stg[7].
+Part of the StGIT suite - see gitlink:stg[1].
diff --git a/Documentation/stg-new.txt b/Documentation/stg-new.txt
index 698816b..5775559 100644
--- a/Documentation/stg-new.txt
+++ b/Documentation/stg-new.txt
@@ -112,4 +112,4 @@ GIT CONFIGURATION VARIABLES
 
 StGIT
 -----
-Part of the StGIT suite - see gitlink:stg[7].
+Part of the StGIT suite - see gitlink:stg[1].
diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index 7d92356..47934a5 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -1,4 +1,4 @@
-stg(7)
+stg(1)
 ======
 Yann Dirson <ydirson@altern.org>
 v0.12.1, February 2007
