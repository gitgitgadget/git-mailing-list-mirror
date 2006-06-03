From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 25/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:24 -0400
Message-ID: <32989.2865186141$1149366554@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email-> <11493664521468-git-send-email-> <114936645851-git-send-email-> <11493664643454-git-send-email-> <11493664652868-git-send-email-> <1149366466232-git-send-email-> <11493664673957-git-send-email-> <11493664672829-git-send-email-> <1149366468410-git-send-email-> <11493664701494-git-send-email-> <11493664763628-git-send-email-> <11493664773328-git-send-email-> <11493664781775-git-send-email-> <1149366483572-git-send-email-> <11493664892352-git-send-email-> <11493664902219-git-send-email-> <11493664912139-git-send-email-> <1149366497156-git-send-email-> <11493664980-git-send-email-> <11493665032900-git-send-email-> <11493665092334-git-send-email-> <11493665101874-git-send-email-> <11493665112903-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:29:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmcjw-0006CR-6l
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWFCU2y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWFCU2y
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:28:54 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:61317 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030323AbWFCU2x (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:28:53 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KSkMB027757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:47 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KSbLL014154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:37 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KSbPf014153;
	Sat, 3 Jun 2006 16:28:37 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <11493665112903-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 03 Jun 2006 16:28:48 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21225>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/hooks.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 3824a95..e853b93 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -100,7 +100,7 @@ update
 This hook is invoked by `git-receive-pack` on the remote repository,
 which is happens when a `git push` is done on a local repository.
 Just before updating the ref on the remote repository, the update hook
-is invoked.  It's exit status determins the success or failure of
+is invoked.  It's exit status determines the success or failure of
 the ref update.
 
 The hook executes once for each ref to be updated, and takes
@@ -151,7 +151,7 @@ so it is a poor place to do log old..new
 
 The default post-update hook, when enabled, runs
 `git-update-server-info` to keep the information used by dumb
-transports (eg, http) up-to-date.  If you are publishing
+transports (e.g.,, http) up-to-date.  If you are publishing
 a git repository that is accessible via http, you should
 probably enable this hook.
 
-- 
1.3.3.g86f7
