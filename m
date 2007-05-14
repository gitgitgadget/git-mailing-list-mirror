From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 09/10] user-manual: introduce git
Date: Mon, 14 May 2007 11:21:28 -0400
Message-ID: <27010.177440434$1179156137@news.gmane.org>
References: <11791560893572-git-send-email->
 <1179156089759-git-send-email->
 <11791560893022-git-send-email->
 <11791560891179-git-send-email->
 <1179156089470-git-send-email->
 <11791560892667-git-send-email->
 <11791560901-git-send-email->
 <11791560901645-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:22:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncNI-0006P0-Gy
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798AbXENPVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756793AbXENPVn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:21:43 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54969 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756664AbXENPVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:21:32 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncMc-0004zI-9q; Mon, 14 May 2007 11:21:30 -0400
X-Mailer: git-send-email 1.5.1.4.19.g69e2
In-Reply-To: <11791560901645-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47257>

From: J. Bruce Fields <bfields@citi.umich.edu>

Well, we should say at least something about what git is.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index e86e46c..d6ac29b 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1,6 +1,9 @@
 Git User's Manual (for version 1.5.1 or newer)
 ______________________________________________
 
+
+Git is a fast distributed revision control system.
+
 This manual is designed to be readable by someone with basic unix
 command-line skills, but no previous knowledge of git.
 
-- 
1.5.1.4.19.g69e2
