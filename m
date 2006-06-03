From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 15/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:14 -0400
Message-ID: <35605.5431919687$1149366539@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email-> <11493664521468-git-send-email-> <114936645851-git-send-email-> <11493664643454-git-send-email-> <11493664652868-git-send-email-> <1149366466232-git-send-email-> <11493664673957-git-send-email-> <11493664672829-git-send-email-> <1149366468410-git-send-email-> <11493664701494-git-send-email-> <11493664763628-git-send-email-> <11493664773328-git-send-email-> <11493664781775-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:28:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmcjX-00067n-WB
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWFCU2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWFCU2W
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:28:22 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:56709 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932627AbWFCU2U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:28:20 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KSDXj027580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:15 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KS9YK014110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:28:09 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KS4pN014109;
	Sat, 3 Jun 2006 16:28:04 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <11493664781775-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 03 Jun 2006 16:28:15 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21218>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-patch-id.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 723b8cc..5389097 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -13,7 +13,7 @@ DESCRIPTION
 -----------
 A "patch ID" is nothing but a SHA1 of the diff associated with a patch, with
 whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
-the same time also reasonably unique, ie two patches that have the same "patch
+the same time also reasonably unique, i.e., two patches that have the same "patch
 ID" are almost guaranteed to be the same thing.
 
 IOW, you can use this thing to look for likely duplicate commits.
-- 
1.3.3.g86f7
