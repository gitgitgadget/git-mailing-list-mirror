From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Add git-show reference
Date: Fri, 17 Mar 2006 18:21:39 -0600
Message-ID: <E1FKPCN-00061b-Fn@jdl.com>
X-From: git-owner@vger.kernel.org Sat Mar 18 01:22:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKPD1-0006JA-9y
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 01:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWCRAWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 19:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWCRAWI
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 19:22:08 -0500
Received: from jdl.com ([66.118.10.122]:14989 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751790AbWCRAWH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 19:22:07 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FKPCN-00061b-Fn
	for git@vger.kernel.org; Fri, 17 Mar 2006 18:21:40 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17674>


Signed-off-by: Jon Loeliger <jdl@jdl.com>


---

 Documentation/git.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

e202e207b8da1ac771a98f039cdfac70ad9ea0d2
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 8610d36..de3934d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -329,6 +329,9 @@ gitlink:git-revert[1]::
 gitlink:git-shortlog[1]::
 	Summarizes 'git log' output.
 
+gitlink:git-show[1]::
+	Show one commit log and its diff.
+
 gitlink:git-show-branch[1]::
 	Show branches and their commits.
 
-- 
1.2.4.gdd7be
