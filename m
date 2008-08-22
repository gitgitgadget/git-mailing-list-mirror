From: Mike Ralphson <mike@abacus.co.uk>
Subject: [JGIT PATCH] Typos in documentation
Date: Fri, 22 Aug 2008 16:49:46 +0100
Message-ID: <d03b5675d55bbbd68e3d22b6b28b1f70f7af00b9.1219418949.git.mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 17:43:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWYnN-0007AD-Qn
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 17:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbYHVPmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 11:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbYHVPmU
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 11:42:20 -0400
Received: from [82.109.193.99] ([82.109.193.99]:2958 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752170AbYHVPmT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 11:42:19 -0400
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id C125E1BD7FA; Fri, 22 Aug 2008 16:49:48 +0100 (BST)
X-Mailer: git-send-email 1.5.5.1.1.g75d5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93312>

---
 EGIT_INSTALL |    6 +++---
 README       |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/EGIT_INSTALL b/EGIT_INSTALL
index 142526a..3a8f249 100644
--- a/EGIT_INSTALL
+++ b/EGIT_INSTALL
@@ -16,7 +16,7 @@ things.
 
 - A reasonably recent version of Git itself installed on your platform to
   take care of what the plugin does not yet do or do things that native
-  git does better. Some tests have been peformed using both Cygwin and MSYS git.
+  git does better. Some tests have been performed using both Cygwin and MSYS git.
   Both have issues that we need both feedback and patches for.
 
 INSTALLATION INSTRUCTIONS
@@ -25,7 +25,7 @@ INSTALLATION INSTRUCTIONS
 - Start eclipse
 - Make sure a recent JDK 1.5.0_11 or JDK 1.6.x is among your installed JRE's. Which
   one is the default should not matter but Java 6 is recommended. 
-- Import the egit projects. Make sure there aare no compilation errors
+- Import the egit projects. Make sure there are no compilation errors
 - Now you can either export the plugin to a set of jar files to use in an Eclipse 
   installation or run it from within Eclipse. The latter is for development and 
   tracking down bugs.
@@ -34,7 +34,7 @@ INSTALLATION INSTRUCTIONS
   fragments and choose the Next button. Set Directory to the top of your
   installation directory (NOT the plugins directory). Select Finish. After 
   that restart Eclipse. You can associate a project withe Eclipse using the
-  Team>Share meny in the context meny when a project is selected.
+  Team>Share menu in the context menu when a project is selected.
 
 DEBUGGING INSTRUCTIONS
 - Select the org.spearce.egit.ui project, and using the context menu select
diff --git a/README b/README
index dd4a910..424f7a3 100644
--- a/README
+++ b/README
@@ -127,7 +127,7 @@ three for packaging.
     * Connect/disconnect the provider to a project.
 
     * Search for the repositories associated with a project by
-      autodecting the GIT repository directories.
+      autodetecting the GIT repository directories.
 
     * Store which repositories are tied to which containers in the
       Eclipse workspace.
-- 
1.5.6.4
