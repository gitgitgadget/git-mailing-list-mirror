From: Dave Watson <dwatson@mimvista.com>
Subject: [PATCH] Fix misspelling of 'suppress' in docs
Date: Sun, 19 Aug 2007 22:27:52 -0400
Message-ID: <1187576872427-git-send-email-dwatson@mimvista.com>
Cc: Dave Watson <dwatson@mimvista.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 04:26:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMwyZ-0000NA-Ft
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 04:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbXHTC0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 22:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbXHTC0k
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 22:26:40 -0400
Received: from ms-smtp-05.ohiordc.rr.com ([65.24.5.139]:40940 "EHLO
	ms-smtp-05.ohiordc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbXHTC0j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 22:26:39 -0400
Received: from localhost.localdomain (cpe-66-61-71-72.neo.res.rr.com [66.61.71.72])
	by ms-smtp-05.ohiordc.rr.com (8.13.6/8.13.6) with ESMTP id l7K2Qbx5018519;
	Sun, 19 Aug 2007 22:26:38 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.rc4
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56166>

---
 Documentation/git-checkout.txt   |    2 +-
 Documentation/git-send-email.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 818b720..734928b 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -35,7 +35,7 @@ working tree.
 OPTIONS
 -------
 -q::
-	Quiet, supress feedback messages.
+	Quiet, suppress feedback messages.
 
 -f::
 	Proceed even if the index or the working tree differs
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index d243ed1..ff12158 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -88,7 +88,7 @@ The --cc option must be repeated for each user you want on the cc list.
         If this is set, do not add the From: address to the cc: list, if it
         shows up in a From: line.
         Default is the value of 'sendemail.suppressfrom' configuration value;
-        if that is unspecified, default to --no-supress-from.
+        if that is unspecified, default to --no-suppress-from.
 
 --thread, --no-thread::
 	If this is set, the In-Reply-To header will be set on each email sent.
-- 
1.5.3.rc4
