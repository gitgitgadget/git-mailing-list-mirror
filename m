From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 10/13] Update Git(1) links to guides
Date: Sat, 23 Feb 2013 23:05:58 +0000
Message-ID: <1361660761-1932-11-git-send-email-philipoakley@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:06:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9OAs-0004LJ-Ig
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 00:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759302Ab3BWXGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 18:06:07 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:44386 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758938Ab3BWXGG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 18:06:06 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAJhKKVFZ8rke/2dsb2JhbABFwVGBCBdzgiABBVYzCBU0ORAOBhOIF75+jxWDQAOnIoMH
X-IronPort-AV: E=Sophos;i="4.84,724,1355097600"; 
   d="scan'208";a="419579940"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 23 Feb 2013 23:06:05 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216933>

to giteverday and gituser-manual

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0b681d9..1830245 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -22,8 +22,8 @@ unusually rich command set that provides both high-level operations
 and full access to internals.
 
 See linkgit:gittutorial[7] to get started, then see
-link:everyday.html[Everyday Git] for a useful minimum set of
-commands.  The link:user-manual.html[Git User's Manual] has a more
+linkgit:giteveryday[Everyday Git] for a useful minimum set of
+commands.  The linkgit:gituser-manual[Git User's Manual] has a more
 in-depth introduction.
 
 After you mastered the basic concepts, you can come back to this
@@ -826,7 +826,7 @@ Discussion[[Discussion]]
 ------------------------
 
 More detail on the following is available from the
-link:user-manual.html#git-concepts[Git concepts chapter of the
+linkgit:gituser-manual#git-concepts[git concepts chapter of the
 user-manual] and linkgit:gitcore-tutorial[7].
 
 A Git project normally consists of a working directory with a ".git"
@@ -882,7 +882,7 @@ See the references in the "description" section to get started
 using Git.  The following is probably more detail than necessary
 for a first-time user.
 
-The link:user-manual.html#git-concepts[Git concepts chapter of the
+The linkgit:gituser-manual#git-concepts[git concepts chapter of the
 user-manual] and linkgit:gitcore-tutorial[7] both provide
 introductions to the underlying Git architecture.
 
@@ -919,9 +919,9 @@ subscribed to the list to send a message there.
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
-link:everyday.html[Everyday Git], linkgit:gitcvs-migration[7],
+linkgit:giteveryday[Everyday Git], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
-linkgit:gitcli[7], link:user-manual.html[The Git User's Manual],
+linkgit:gitcli[7], linkgit:gituser-manual[The Git User's Manual],
 linkgit:gitworkflows[7]
 
 GIT
-- 
1.8.1.msysgit.1
