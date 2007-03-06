From: Nur Hussein <hussein@cs.usm.my>
Subject: [PATCH 1/1] Guilt: Makefile tab fix
Date: Tue, 06 Mar 2007 17:05:30 +0800
Message-ID: <1173171930.4877.23.camel@gandalf.dcc.usm.my>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Tue Mar 06 10:07:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOVe2-0008Bh-Pr
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 10:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151AbXCFJG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 04:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933149AbXCFJG5
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 04:06:57 -0500
Received: from cs.usm.my ([202.170.56.49]:53685 "EHLO cs.usm.my"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933151AbXCFJGz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 04:06:55 -0500
Received: from localhost (cs.usm.my [10.207.207.3])
	by cs.usm.my (8.13.8/8.13.8) with ESMTP id l26944ec007580;
	Tue, 6 Mar 2007 17:04:07 +0800 (SGT)
X-Mailer: Evolution 2.6.3 
X-Ppskomp-MailScanner-Information: Please contact the ISP for more information
X-Ppskomp-MailScanner: Found to be clean
X-Ppskomp-MailScanner-From: hussein@cs.usm.my
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41562>

Accidentally messed up tabs in Makefile with spaces. Fixing with a tab.

Signed-off-by: Nur Hussein <hussein@cs.usm.my>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index eb5fc2e..3725bc0 100644
--- a/Makefile
+++ b/Makefile
@@ -34,7 +34,7 @@ install:
 
 .PHONY: uninstall
 uninstall:
-       ./uninstall $(PREFIX)/bin/ $(SCRIPTS)
+	./uninstall $(PREFIX)/bin/ $(SCRIPTS)
 
 .PHONY: doc
 doc:
-- 
1.4.4.4


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
