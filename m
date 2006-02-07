From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH 3/3] Docs: minor git-push copyediting
Date: Tue, 7 Feb 2006 03:22:48 +0000 (UTC)
Message-ID: <1139282428.ec02f402.2@fieldses.org>
References: <1139282428.ec02f402.1@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 04:22:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6JR1-000744-UF
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 04:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWBGDWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 22:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWBGDWY
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 22:22:24 -0500
Received: from mail.fieldses.org ([66.93.2.214]:9351 "EHLO puzzle.fieldses.org")
	by vger.kernel.org with ESMTP id S932448AbWBGDWY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 22:22:24 -0500
Received: from bfields by puzzle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F6JPk-0004Jn-UO; Mon, 06 Feb 2006 22:21:12 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <1139282428.ec02f402.1@fieldses.org>
Date: Sun Feb 5 19:42:27 2006 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15681>

Minor git-push copyediting

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

 Documentation/git-push.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

a9a95125f25c8f70fe52ab0e30fe5ff6473d7679
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index ce909f5..5b89110 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 Updates remote refs using local refs, while sending objects
 necessary to complete the given refs.
 
-You can make "interesting" things to happen on the repository
+You can make interesting things happen to a repository
 every time you push into it, by setting up 'hooks' there.  See
 documentation for gitlink:git-receive-pack[1].
 
@@ -51,8 +51,8 @@ Some short-cut notations are also suppor
   in the source.
 
 \--all::
-	Instead of naming each ref to push, specifies all refs
-	to be pushed.
+	Instead of naming each ref to push, specifies that all
+	refs be pushed.
 
 \--tags::
 	All refs under `$GIT_DIR/refs/tags` are pushed, in
-- 
0.99.8b.g3480-dirty
