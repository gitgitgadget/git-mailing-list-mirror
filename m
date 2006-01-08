From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] .gitignore git-describe
Date: Sun, 8 Jan 2006 14:15:46 +0000 (UTC)
Message-ID: <20060108141457.8C4E85BE8F@nox.op5.se>
X-From: git-owner@vger.kernel.org Sun Jan 08 15:15:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvbKa-0007Jf-D7
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 15:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWAHOPB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 09:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbWAHOPA
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 09:15:00 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:2180 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1751405AbWAHOO6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 09:14:58 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id C28056BCBE
	for <git@vger.kernel.org>; Sun,  8 Jan 2006 15:14:57 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 8C4E85BE8F; Sun,  8 Jan 2006 15:14:57 +0100 (CET)
Date: 1136729682 +0100
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14319>

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

265df952d4c61f60eae42261aeea90e9b6d8e414
diff --git a/.gitignore b/.gitignore
index 1a9090b..4335061 100644
--- a/.gitignore
+++ b/.gitignore
@@ -23,6 +23,7 @@ git-count-objects
 git-cvsexportcommit
 git-cvsimport
 git-daemon
+git-describe
 git-diff
 git-diff-files
 git-diff-index
-- 
1.0.7-gb38d1
