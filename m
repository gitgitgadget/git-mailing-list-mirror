From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 2/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:01 -0400
Message-ID: <46942.4365358011$1149366476@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:27:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmcit-00061v-Fi
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWFCU1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWFCU1n
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:27:43 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47749 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751801AbWFCU1m (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:27:42 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KRZXi027402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:36 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KRVoN014058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:31 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KRUsr014057;
	Sat, 3 Jun 2006 16:27:30 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <11493664482083-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 03 Jun 2006 16:27:36 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21202>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/core-tutorial.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 5a831ad..1185897 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -184,7 +184,7 @@ you'll have to use the object name, not 
 ----------------
 
 where the `-t` tells `git-cat-file` to tell you what the "type" of the
-object is. git will tell you that you have a "blob" object (ie just a
+object is. git will tell you that you have a "blob" object (i.e., just a
 regular file), and you can see the contents with
 
 ----------------
@@ -619,7 +619,7 @@ that tag. You create these annotated tag
 ----------------
 
 which will sign the current `HEAD` (but you can also give it another
-argument that specifies the thing to tag, ie you could have tagged the
+argument that specifies the thing to tag, i.e., you could have tagged the
 current `mybranch` point by using `git tag <tagname> mybranch`).
 
 You normally only do signed tags for major releases or things
@@ -1097,7 +1097,7 @@ commit object by downloading from `repo.
 using the object name of that commit object.  Then it reads the
 commit object to find out its parent commits and the associate
 tree object; it repeats this process until it gets all the
-necessary objects.  Because of this behaviour, they are
+necessary objects.  Because of this behavior, they are
 sometimes also called 'commit walkers'.
 +
 The 'commit walkers' are sometimes also called 'dumb
-- 
1.3.3.g86f7
