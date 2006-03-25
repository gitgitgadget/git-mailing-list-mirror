From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Removed bogus "<snap>" identifier.
Date: Fri, 24 Mar 2006 21:27:13 -0600
Message-ID: <E1FMzQn-0006vK-AB@jdl.com>
X-From: git-owner@vger.kernel.org Sat Mar 25 04:27:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMzRA-0006iF-1S
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 04:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWCYD1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 22:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWCYD1d
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 22:27:33 -0500
Received: from colo.jdl.com ([66.118.10.122]:61104 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750715AbWCYD1d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 22:27:33 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FMzQn-0006vK-AB
	for git@vger.kernel.org; Fri, 24 Mar 2006 21:27:14 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17949>


Signed-off-by: Jon Loeliger <jdl@jdl.com>

---

 Documentation/git.txt |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

c610f57ccfb52441719c5602894139acdd1271ee
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0c424ff..fe34f50 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -521,10 +521,6 @@ HEAD::
 	a valid head 'name'
 	(i.e. the contents of `$GIT_DIR/refs/heads/<head>`).
 
-<snap>::
-	a valid snapshot 'name'
-	(i.e. the contents of `$GIT_DIR/refs/snap/<snap>`).
-
 
 File/Directory Structure
 ------------------------
-- 
1.2.4.gdd7be
