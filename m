From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 14/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:13 -0400
Message-ID: <49814.4913385206$1149366516@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email-> <11493664521468-git-send-email-> <114936645851-git-send-email-> <11493664643454-git-send-email-> <11493664652868-git-send-email-> <1149366466232-git-send-email-> <11493664673957-git-send-email-> <11493664672829-git-send-email-> <1149366468410-git-send-email-> <11493664701494-git-send-email-> <11493664763628-git-send-email-> <11493664773328-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:28:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmcjV-00067n-07
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWFCU2Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWFCU2P
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:28:15 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55429 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751815AbWFCU2N (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:28:13 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KS7iq027548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:08 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KS3vK014106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:03 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KS3Pu014105;
	Sat, 3 Jun 2006 16:28:03 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <11493664773328-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 03 Jun 2006 16:28:08 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21214>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-merge-index.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 332e023..6cd0601 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -69,7 +69,7 @@ or 
   fatal: merge program failed
 
 where the latter example shows how "git-merge-index" will stop trying to
-merge once anything has returned an error (ie "cat" returned an error
+merge once anything has returned an error (i.e., "cat" returned an error
 for the AA file, because it didn't exist in the original, and thus
 "git-merge-index" didn't even try to merge the MM thing).
 
-- 
1.3.3.g86f7
