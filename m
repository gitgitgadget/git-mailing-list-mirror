From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 8/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:07 -0400
Message-ID: <38514.9753107273$1149366511@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email-> <11493664521468-git-send-email-> <114936645851-git-send-email-> <11493664643454-git-send-email-> <11493664652868-git-send-email-> <1149366466232-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:28:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmcjU-00067n-7b
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWFCU2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWFCU2C
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:28:02 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50821 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751808AbWFCU16 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:27:58 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KRpTU027448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:52 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KRlCa014082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:47 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KRl8v014081;
	Sat, 3 Jun 2006 16:27:47 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <1149366466232-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 03 Jun 2006 16:27:52 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21210>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-daemon.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 924a676..4c357da 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -20,7 +20,7 @@ aka 9418. It waits for a connection, and
 when it gets one.
 
 It's careful in that there's a magic request-line that gives the command and
-what directory to upload, and it verifies that the directory is ok.
+what directory to upload, and it verifies that the directory is OK.
 
 It verifies that the directory has the magic file "git-daemon-export-ok", and
 it will refuse to export any git directory that hasn't explicitly been marked
@@ -28,7 +28,7 @@ for export this way (unless the '--expor
 pass some directory paths as 'git-daemon' arguments, you can further restrict
 the offers to a whitelist comprising of those.
 
-This is ideally suited for read-only updates, ie pulling from git repositories.
+This is ideally suited for read-only updates, i.e., pulling from git repositories.
 
 OPTIONS
 -------
-- 
1.3.3.g86f7
