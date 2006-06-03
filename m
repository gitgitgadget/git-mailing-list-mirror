From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 20/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:19 -0400
Message-ID: <41097.0909208574$1149366539@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email-> <11493664521468-git-send-email-> <114936645851-git-send-email-> <11493664643454-git-send-email-> <11493664652868-git-send-email-> <1149366466232-git-send-email-> <11493664673957-git-send-email-> <11493664672829-git-send-email-> <1149366468410-git-send-email-> <11493664701494-git-send-email-> <11493664763628-git-send-email-> <11493664773328-git-send-email-> <11493664781775-git-send-email-> <1149366483572-git-send-email-> <11493664892352-git-send-email-> <11493664902219-git-send-email-> <11493664912139-git-send-email-> <1149366497156-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:28:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmcjl-0006B7-Aj
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWFCU2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWFCU2i
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:28:38 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59781 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030318AbWFCU2h (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:28:37 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KSVwa027682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:32 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KSNx5014132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:23 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KSNn2014130;
	Sat, 3 Jun 2006 16:28:23 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <1149366497156-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 03 Jun 2006 16:28:33 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21219>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-send-email.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 8c58685..ad1b9cf 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -52,7 +52,7 @@ The options available are:
 	is not set, this will be prompted for.
 
 --no-signed-off-by-cc::
-	Do not add emails foudn in Signed-off-by: lines to the cc list.
+	Do not add emails found in Signed-off-by: lines to the cc list.
 
 --quiet::
 	Make git-send-email less verbose.  One line per email should be
-- 
1.3.3.g86f7
