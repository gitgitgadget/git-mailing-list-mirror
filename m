From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 27/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:26 -0400
Message-ID: <44065.4616490521$1149366564@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email-> <11493664521468-git-send-email-> <114936645851-git-send-email-> <11493664643454-git-send-email-> <11493664652868-git-send-email-> <1149366466232-git-send-email-> <11493664673957-git-send-email-> <11493664672829-git-send-email-> <1149366468410-git-send-email-> <11493664701494-git-send-email-> <11493664763628-git-send-email-> <11493664773328-git-send-email-> <11493664781775-git-send-email-> <1149366483572-git-send-email-> <11493664892352-git-send-email-> <11493664902219-git-send-email-> <11493664912139-git-send-email-> <1149366497156-git-send-email-> <11493664980-git-send-email-> <11493665032900-git-send-email-> <11493665092334-git-send-email-> <11493665101874-git-send-email-> <11493665112903-git-send-email-> <1149366517875-git-send-email-> <11493665173464-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:29:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmck8-0006EM-35
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWFCU3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWFCU3A
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:29:00 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:62597 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030334AbWFCU27 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:28:59 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KSrWX027800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:54 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KSmcw014162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:49 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KSmxT014161;
	Sat, 3 Jun 2006 16:28:48 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <11493665173464-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 03 Jun 2006 16:28:54 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21228>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/tutorial.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 039a859..db56312 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -194,7 +194,7 @@ Bob begins with:
 
 This creates a new directory "myrepo" containing a clone of Alice's
 repository.  The clone is on an equal footing with the original
-project, posessing its own copy of the original project's history.
+project, possessing its own copy of the original project's history.
 
 Bob then makes some changes and commits them:
 
@@ -240,7 +240,7 @@ of Bob's line of development without doi
 shows a list of all the changes that Bob made since he branched from
 Alice's master branch.
 
-After examing those changes, and possibly fixing things, Alice can
+After examining those changes, and possibly fixing things, Alice can
 pull the changes into her master branch:
 
 -------------------------------------
@@ -374,7 +374,7 @@ project, so
 $ git grep "hello" v2.5
 -------------------------------------
 
-searches for all occurences of "hello" in v2.5.
+searches for all occurrences of "hello" in v2.5.
 
 If you leave out the commit name, git grep will search any of the
 files it manages in your current directory.  So
@@ -482,6 +482,6 @@ digressions that may be interesting at t
     smart enough to perform a close-to-optimal search even in the
     case of complex non-linear history with lots of merged branches.
 
-  * link:everyday.html[Everday GIT with 20 Commands Or So]
+  * link:everyday.html[Everyday GIT with 20 Commands Or So]
 
   * link:cvs-migration.html[git for CVS users].
-- 
1.3.3.g86f7
