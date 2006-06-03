From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 11/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:10 -0400
Message-ID: <27957.0945109755$1149366520@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email-> <11493664521468-git-send-email-> <114936645851-git-send-email-> <11493664643454-git-send-email-> <11493664652868-git-send-email-> <1149366466232-git-send-email-> <11493664673957-git-send-email-> <11493664672829-git-send-email-> <1149366468410-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:28:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmcjV-00067n-Iu
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWFCU2I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWFCU2I
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:28:08 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:52613 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751815AbWFCU2C (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:28:02 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KRvCm027508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:58 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KRuH7014094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:56 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KRoJl014093;
	Sat, 3 Jun 2006 16:27:50 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <1149366468410-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 03 Jun 2006 16:27:58 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21217>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-diff.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 7267bcd..7ab2080 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -85,7 +85,7 @@ Limiting the diff output::
 nor deletion.
 <2> show only names and the nature of change, but not actual
 diff output.  --name-status disables usual patch generation
-which in turn also disables recursive behaviour, so without -r
+which in turn also disables recursive behavior, so without -r
 you would only see the directory name if there is a change in a
 file in a subdirectory.
 <3> limit diff output to named subtrees.
-- 
1.3.3.g86f7
