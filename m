From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Fix minor typo.
Date: Fri, 17 Mar 2006 18:25:46 -0600
Message-ID: <E1FKPGM-00062R-Ql@jdl.com>
X-From: git-owner@vger.kernel.org Sat Mar 18 01:26:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKPGn-0006ns-0u
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 01:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWCRA0H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 19:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWCRA0H
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 19:26:07 -0500
Received: from colo.jdl.com ([66.118.10.122]:16781 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932279AbWCRA0F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 19:26:05 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FKPGM-00062R-Ql
	for git@vger.kernel.org; Fri, 17 Mar 2006 18:25:47 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17679>


Signed-off-by: Jon Loeliger <jdl@jdl.com>


---

 Documentation/git-show-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

0ccfbeb321dbebc70c2203cb801079a90255b2df
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index d3b6e62..f115b45 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -141,7 +141,7 @@ it, having the following in the configur
 
 ------------
 
-With this,`git show-branch` without extra parameters would show
+With this, `git show-branch` without extra parameters would show
 only the primary branches.  In addition, if you happen to be on
 your topic branch, it is shown as well.
 
-- 
1.2.4.gdd7be
