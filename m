From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] user-manual: fixed typo in example
Date: Sat, 26 May 2007 21:16:27 +0200
Message-ID: <1180206987131-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 21:16:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs1ki-0002K7-60
	for gcvg-git@gmane.org; Sat, 26 May 2007 21:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbXEZTQa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 15:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756434AbXEZTQa
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 15:16:30 -0400
Received: from mailer.zib.de ([130.73.108.11]:35736 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733AbXEZTQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 15:16:29 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l4QJGSjv015325
	for <git@vger.kernel.org>; Sat, 26 May 2007 21:16:28 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l4QJGRM4005645;
	Sat, 26 May 2007 21:16:27 +0200 (MEST)
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48484>


Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 52247aa..4fabb8e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -872,7 +872,7 @@ Obviously, endless variations are possible; for example, to see all
 commits reachable from some head but not from any tag in the repository:
 
 -------------------------------------------------
-$ gitk ($ git show-ref --heads ) --not  $( git show-ref --tags )
+$ gitk $( git show-ref --heads ) --not  $( git show-ref --tags )
 -------------------------------------------------
 
 (See gitlink:git-rev-parse[1] for explanations of commit-selecting
-- 
1.5.1.2
