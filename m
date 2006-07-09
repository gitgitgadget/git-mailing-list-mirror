From: Alp Toker <alp@atoker.com>
Subject: [PATCH] Fix some doubled word typos
Date: Sun, 09 Jul 2006 10:36:23 +0100
Message-ID: <11524377844177-git-send-email-alp@atoker.com>
Reply-To: Alp Toker <alp@atoker.com>
Cc: Alp Toker <alp@atoker.com>
X-From: git-owner@vger.kernel.org Sun Jul 09 11:36:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzViP-0002EJ-P3
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 11:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWGIJg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 05:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWGIJg0
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 05:36:26 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:36113 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S964982AbWGIJgZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 05:36:25 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 386961645C6; Sun,  9 Jul 2006 10:36:24 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.gbe4c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23533>

Signed-off-by: Alp Toker <alp@atoker.com>
---
 Documentation/git-svn.txt |    2 +-
 Documentation/urls.txt    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f7d3de4..7d86809 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -224,7 +224,7 @@ Merge tracking in Subversion is lacking 
 with Subversion is cumbersome as a result.  git-svn completely forgoes
 any automated merge/branch tracking on the Subversion side and leaves it
 entirely up to the user on the git side.  It's simply not worth it to do
-a useful translation when the the original signal is weak.
+a useful translation when the original signal is weak.
 
 TRACKING MULTIPLE REPOSITORIES OR BRANCHES
 ------------------------------------------
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 7477413..d60b371 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -47,7 +47,7 @@ Then such a short-hand is specified in p
 <repository> without <refspec> parameters on the command
 line, <refspec> specified on `Push:` lines or `Pull:`
 lines are used for `git-push` and `git-fetch`/`git-pull`,
-respectively.  Multiple `Push:` and and `Pull:` lines may
+respectively.  Multiple `Push:` and `Pull:` lines may
 be specified for additional branch mappings.
 
 The name of a file in `$GIT_DIR/branches` directory can be
-- 
1.4.1.gbe4c7
