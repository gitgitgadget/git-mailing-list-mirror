From: David D Kilzer <ddkilzer@kilzer.net>
Subject: [PATCH] RelNotes-1.5.3.5: fix another typo
Date: Sun,  4 Nov 2007 04:45:22 -0800
Message-ID: <1194180323-89367-1-git-send-email-ddkilzer@kilzer.net>
References: <1194175990-76335-1-git-send-email-ddkilzer@kilzer.net>
Cc: David D Kilzer <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 13:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioer9-0006V0-Bt
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 13:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067AbXKDMpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 07:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbXKDMpW
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 07:45:22 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:52330 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbXKDMpV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 07:45:21 -0500
Received: from relay8.apple.com (relay8.apple.com [17.128.113.38])
	by mail-out3.apple.com (Postfix) with ESMTP id 074CB1742E47;
	Sun,  4 Nov 2007 04:45:21 -0800 (PST)
Received: from relay8.apple.com (unknown [127.0.0.1])
	by relay8.apple.com (Symantec Mail Security) with ESMTP id E1EFA40832;
	Sun,  4 Nov 2007 04:45:20 -0800 (PST)
X-AuditID: 11807126-a5efdbb00000499a-4d-472dbee04ff4
Received: from localhost.localdomain (unknown [17.151.119.102])
	by relay8.apple.com (Apple SCV relay) with ESMTP id AC171407AA;
	Sun,  4 Nov 2007 04:45:20 -0800 (PST)
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1194175990-76335-1-git-send-email-ddkilzer@kilzer.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63396>

Signed-off-by: David D Kilzer <ddkilzer@kilzer.net>
---
 Documentation/RelNotes-1.5.3.5.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/RelNotes-1.5.3.5.txt b/Documentation/RelNotes-1.5.3.5.txt
index f99a2cd..7ff1d5d 100644
--- a/Documentation/RelNotes-1.5.3.5.txt
+++ b/Documentation/RelNotes-1.5.3.5.txt
@@ -90,5 +90,5 @@ Fixes since v1.5.3.4
  * "git-send-pack $remote frotz" segfaulted when there is nothing
    named 'frotz' on the local end.
 
- * "git-rebase -interactive" did not handle its "--strategy" option
+ * "git-rebase --interactive" did not handle its "--strategy" option
    properly.
-- 
1.5.3.5
