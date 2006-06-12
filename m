From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Fix formatting of Documentation/git-clone.txt
Date: Sun, 11 Jun 2006 21:37:50 -0400
Message-ID: <115007627180-git-send-email-vonbrand@inf.utfsm.cl>
Reply-To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 03:38:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpbNT-0004s3-Rj
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 03:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWFLBh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 21:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWFLBh4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 21:37:56 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:61859 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750917AbWFLBh4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 21:37:56 -0400
Received: from laptop11.inf.utfsm.cl (pc-192-170-104-200.cm.vtr.net [200.104.170.192])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k5C1boOl002809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Jun 2006 21:37:50 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k5C1bpF0012645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Jun 2006 21:37:51 -0400
Received: (from vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6/Submit) id k5C1bpOq012644;
	Sun, 11 Jun 2006 21:37:51 -0400
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0.g1b2d
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 11 Jun 2006 21:37:51 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21679>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/git-clone.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7572e4b..a90521e 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -95,8 +95,8 @@ OPTIONS
 	defined default, typically `/usr/share/git-core/templates`.
 
 --use-separate-remote::
-	Save remotes heads under `$GIT_DIR/remotes/origin/' instead
-	of `$GIT_DIR/refs/heads/'.  Only the master branch is saved
+	Save remotes heads under `$GIT_DIR/remotes/origin/` instead
+	of `$GIT_DIR/refs/heads/`.  Only the master branch is saved
 	in the latter.
 
 <repository>::
-- 
1.4.0.g1b2d
