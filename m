From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 16/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:15 -0400
Message-ID: <6743.52590363032$1149366518@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email-> <11493664521468-git-send-email-> <114936645851-git-send-email-> <11493664643454-git-send-email-> <11493664652868-git-send-email-> <1149366466232-git-send-email-> <11493664673957-git-send-email-> <11493664672829-git-send-email-> <1149366468410-git-send-email-> <11493664701494-git-send-email-> <11493664763628-git-send-email-> <11493664773328-git-send-email-> <11493664781775-git-send-email-> <1149366483572-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:28:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmcjT-00067n-3f
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWFCU2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWFCU2V
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:28:21 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:56453 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932625AbWFCU2U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:28:20 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KSEh9027586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:15 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KSAbZ014114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:10 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KSA4K014113;
	Sat, 3 Jun 2006 16:28:10 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <1149366483572-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 03 Jun 2006 16:28:15 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21216>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-read-tree.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 844cfda..02c7e99 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -205,7 +205,7 @@ The `git-write-tree` command refuses to 
 will complain about unmerged entries if it sees a single entry that is not
 stage 0.
 
-Ok, this all sounds like a collection of totally nonsensical rules,
+OK, this all sounds like a collection of totally nonsensical rules,
 but it's actually exactly what you want in order to do a fast
 merge. The different stages represent the "result tree" (stage 0, aka
 "merged"), the original tree (stage 1, aka "orig"), and the two trees
@@ -226,7 +226,7 @@ populated.  Here is an outline of how th
 
 - the index file saves and restores with all this information, so you
   can merge things incrementally, but as long as it has entries in
-  stages 1/2/3 (ie "unmerged entries") you can't write the result. So
+  stages 1/2/3 (i.e., "unmerged entries") you can't write the result. So
   now the merge algorithm ends up being really simple:
 
   * you walk the index in order, and ignore all entries of stage 0,
-- 
1.3.3.g86f7
