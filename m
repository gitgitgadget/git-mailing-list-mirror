From: David D Kilzer <ddkilzer@kilzer.net>
Subject: [PATCH] RelNotes-1.5.3.5: fix typo
Date: Sat,  3 Nov 2007 07:04:52 -0700
Message-ID: <1194098692-7623-1-git-send-email-ddkilzer@kilzer.net>
Cc: David D Kilzer <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 15:15:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoJmt-0007CH-A3
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 15:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbXKCOP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 10:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbXKCOP0
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 10:15:26 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:49209 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbXKCOPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 10:15:25 -0400
X-Greylist: delayed 633 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Nov 2007 10:15:25 EDT
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id 6C9A3172C82E;
	Sat,  3 Nov 2007 07:04:52 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 51E6B28124;
	Sat,  3 Nov 2007 07:04:52 -0700 (PDT)
X-AuditID: 11807134-a4401bb000003395-56-472c80035b57
Received: from localhost.localdomain (unknown [17.151.111.162])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 80DF228107;
	Sat,  3 Nov 2007 07:04:51 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63274>

Signed-off-by: David D Kilzer <ddkilzer@kilzer.net>
---
 Documentation/RelNotes-1.5.3.5.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes-1.5.3.5.txt b/Documentation/RelNotes-1.5.3.5.txt
index 4e46d2c..f99a2cd 100644
--- a/Documentation/RelNotes-1.5.3.5.txt
+++ b/Documentation/RelNotes-1.5.3.5.txt
@@ -63,8 +63,8 @@ Fixes since v1.5.3.4
 
  * Git segfaulted when reading an invalid .gitattributes file.  Fixed.
 
- * post-receive-email example hook fixed was fixed for
-   non-fast-forward updates.
+ * post-receive-email example hook was fixed for non-fast-forward
+   updates.
 
  * Documentation updates for supported (but previously undocumented)
    options of "git-archive" and "git-reflog".
-- 
1.5.3.4
