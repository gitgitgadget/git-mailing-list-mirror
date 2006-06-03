From: Horst.H.von.Brand@inf.utfsm.cl
Subject: [PATCH 3/27] Documentation: Spelling fixes
Date: Sat, 03 Jun 2006 16:27:02 -0400
Message-ID: <18338.4818178185$1149366477@news.gmane.org>
References: <11493664464167-git-send-email-> <11493664482083-git-send-email-> <1149366450549-git-send-email->
Reply-To: Horst.H.von.Brand@inf.utfsm.cl
Cc: Junio C Hamano <junkio@cox.net>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sat Jun 03 22:27:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmciu-00061v-17
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 22:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWFCU1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 16:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbWFCU1s
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 16:27:48 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48261 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751797AbWFCU1r (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 16:27:47 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192] (may be forged))
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k53KRgHu027421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:42 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k53KRbSx014062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Jun 2006 16:27:37 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k53KRWs2014061;
	Sat, 3 Jun 2006 16:27:32 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g86f7
In-Reply-To: <1149366450549-git-send-email->
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 03 Jun 2006 16:27:42 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21204>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/cvs-migration.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index fa94efd..826d089 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -1,7 +1,7 @@
 git for CVS users
 =================
 
-So you're a CVS user. That's ok, it's a treatable condition.  The job of
+So you're a CVS user. That's OK, it's a treatable condition.  The job of
 this document is to put you on the road to recovery, by helping you
 convert an existing cvs repository to git, and by showing you how to use a
 git repository in a cvs-like fashion.
@@ -159,7 +159,7 @@ other than `master`.
 
 [NOTE]
 ============
-Because of this behaviour, if the shared repository and the developer's
+Because of this behavior, if the shared repository and the developer's
 repository both have branches named `origin`, then a push like the above
 attempts to update the `origin` branch in the shared repository from the
 developer's `origin` branch.  The results may be unexpected, so it's
-- 
1.3.3.g86f7
