From: David D Kilzer <ddkilzer@kilzer.net>
Subject: [PATCH] RelNotes-1.5.3.5: fix typos
Date: Sun,  4 Nov 2007 03:33:10 -0800
Message-ID: <1194175990-76335-1-git-send-email-ddkilzer@kilzer.net>
Cc: David D Kilzer <ddkilzer@kilzer.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 12:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IodjJ-00065A-Dl
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 12:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757225AbXKDLdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 06:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756979AbXKDLdK
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 06:33:10 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:53876 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756959AbXKDLdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 06:33:09 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id 8CDB217E0048;
	Sun,  4 Nov 2007 03:33:08 -0800 (PST)
Received: from relay11.apple.com (unknown [127.0.0.1])
	by relay11.apple.com (Symantec Mail Security) with ESMTP id 7588F281CE;
	Sun,  4 Nov 2007 03:33:08 -0800 (PST)
X-AuditID: 11807130-a23bfbb000004daf-82-472dadf3fc24
Received: from localhost.localdomain (unknown [17.151.119.102])
	by relay11.apple.com (Apple SCV relay) with ESMTP id C0117281C5;
	Sun,  4 Nov 2007 03:33:07 -0800 (PST)
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: 1194098692-7623-1-git-send-email-ddkilzer@kilzer.net
References: 1194098692-7623-1-git-send-email-ddkilzer@kilzer.net
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63384>

Signed-off-by: David D Kilzer <ddkilzer@kilzer.net>
---

On Sat, 3 Nov 2007 at 06:56:36 -0700, David D. Kilzer wrote:
> Documentation/RelNotes-1.5.3.5.txt |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

Oops.  Found another typo.

 Documentation/RelNotes-1.5.3.5.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes-1.5.3.5.txt b/Documentation/RelNotes-1.5.3.5.txt
index 4e46d2c..7ff1d5d 100644
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
@@ -90,5 +90,5 @@ Fixes since v1.5.3.4
  * "git-send-pack $remote frotz" segfaulted when there is nothing
    named 'frotz' on the local end.
 
- * "git-rebase -interactive" did not handle its "--strategy" option
+ * "git-rebase --interactive" did not handle its "--strategy" option
    properly.
-- 
1.5.3.5
