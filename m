From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 9/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:08 -0400
Message-ID: <47009.7724268728$1149366500@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email-> <11493664521468-git-send-email-> <114936645851-git-send-email-> <11493664643454-git-send-email-> <11493664652868-git-send-email-> <1149366466232-git-send-email-> <11493664673957-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:28:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmcj7-00064K-H0
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWFCU2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWFCU2A
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:28:00 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51589 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751812AbWFCU16 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:27:58 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KRrFH027454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:53 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KRm0R014086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:48 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KRmWr014085;
	Sat, 3 Jun 2006 16:27:48 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <11493664673957-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 03 Jun 2006 16:27:54 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21208>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-diff-index.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 5d2096a..9cd43f1 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -101,7 +101,7 @@ have not actually done a "git-update-ind
   torvalds@ppc970:~/v2.6/linux> git-diff-index HEAD
   *100644->100664 blob    7476bb......->000000......      kernel/sched.c
 
-ie it shows that the tree has changed, and that `kernel/sched.c` has is
+i.e., it shows that the tree has changed, and that `kernel/sched.c` has is
 not up-to-date and may contain new stuff. The all-zero sha1 means that to
 get the real diff, you need to look at the object in the working directory
 directly rather than do an object-to-object diff.
-- 
1.3.3.g86f7
