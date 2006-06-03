From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 10/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:09 -0400
Message-ID: <13374.6473504745$1149366514@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email-> <11493664521468-git-send-email-> <114936645851-git-send-email-> <11493664643454-git-send-email-> <11493664652868-git-send-email-> <1149366466232-git-send-email-> <11493664673957-git-send-email-> <11493664672829-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:28:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmcjW-00067n-QV
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWFCU2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWFCU2E
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:28:04 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:52357 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751813AbWFCU2A (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:28:00 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KRsWb027464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:56 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KRoOw014090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:50 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KRnrC014089;
	Sat, 3 Jun 2006 16:27:49 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <11493664672829-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 03 Jun 2006 16:27:56 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21212>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-diff-tree.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 906830d..f7e8ff2 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -32,7 +32,7 @@ include::diff-options.txt[]
 <path>...::
 	If provided, the results are limited to a subset of files
 	matching one of these prefix strings.
-	ie file matches `/^<pattern1>|<pattern2>|.../`
+	i.e., file matches `/^<pattern1>|<pattern2>|.../`
 	Note that this parameter does not provide any wildcard or regexp
 	features.
 
@@ -54,7 +54,7 @@ include::diff-options.txt[]
 +
 When a single commit is given on one line of such input, it compares
 the commit with its parents.  The following flags further affects its
-behaviour.  This does not apply to the case where two <tree-ish>
+behavior.  This does not apply to the case where two <tree-ish>
 separated with a single space are given.
 
 -m::
-- 
1.3.3.g86f7
