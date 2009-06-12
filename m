From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit 1/2] Fix two typos in the "Toggle filter by tree" tooltip
Date: Fri, 12 Jun 2009 14:07:58 +0200
Message-ID: <5eda420491e42dbb85b86b688dd604f067d7136d.1244808064.git.markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 14:08:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF5Ya-0007Cm-W0
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 14:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbZFLMIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 08:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbZFLMIM
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 08:08:12 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33372 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZFLMIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 08:08:11 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 02C281054160B;
	Fri, 12 Jun 2009 14:08:13 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF5YK-0007lD-02; Fri, 12 Jun 2009 14:08:12 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18CJk9LX8NBIZF9yNlYUbNmT4M5kyEx26RLA0xU
	HQA6/xmyp8URRs4eRvHSGUb4ft9PWLX6WmDLkvvjEAd9UuanA2
	uJkQY/NacSG8MEAa8qFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121412>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/mainview.ui |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/mainview.ui b/src/mainview.ui
index 4ddf43d..b3a94a6 100644
--- a/src/mainview.ui
+++ b/src/mainview.ui
@@ -460,7 +460,7 @@
     <string>Filter by tree</string>
    </property>
    <property name="toolTip">
-    <string>Filter by tree selection, multple selection allowed</string>
+    <string>Filter by tree selection, multiple selections allowed</string>
    </property>
    <property name="shortcut">
     <string>F</string>
-- 
1.6.3.2.236.ge505d
