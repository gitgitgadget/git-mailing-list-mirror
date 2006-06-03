From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 7/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:06 -0400
Message-ID: <31079.4145720594$1149366499@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email-> <11493664521468-git-send-email-> <114936645851-git-send-email-> <11493664643454-git-send-email-> <11493664652868-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:28:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmcj6-00064K-V2
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWFCU17 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWFCU17
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:27:59 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51077 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751809AbWFCU15 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:27:57 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KRpW2027444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:51 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KRkx2014078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:47 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KRksm014077;
	Sat, 3 Jun 2006 16:27:46 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <11493664652868-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 03 Jun 2006 16:27:51 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21207>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-cvsserver.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 4dc13c3..952635d 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -94,7 +94,7 @@ To get a checkout with the Eclipse CVS c
 4. Pick 'HEAD' when it asks what branch/tag to check out. Untick the
    "launch commit wizard" to avoid committing the .project file.
 
-Protocol notes: If you are using anonymous acces via pserver, just select that.
+Protocol notes: If you are using anonymous access via pserver, just select that.
 Those using SSH access should choose the 'ext' protocol, and configure 'ext'
 access on the Preferences->Team->CVS->ExtConnection pane. Set CVS_SERVER to
 'git-cvsserver'. Not that password support is not good when using 'ext',
-- 
1.3.3.g86f7
