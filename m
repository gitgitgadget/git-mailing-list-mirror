From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH QGit] Make the tooltips of the two search buttons more readable
Date: Sat, 13 Jun 2009 13:04:03 +0200
Message-ID: <1244891044-10582-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 13:04:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFR27-0002Ai-U5
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 13:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762697AbZFMLEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 07:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762691AbZFMLEL
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 07:04:11 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:56112 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757973AbZFMLEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 07:04:10 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 57FAF103304BE;
	Sat, 13 Jun 2009 13:04:12 +0200 (CEST)
Received: from [89.59.112.3] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MFR1w-0005Oz-00; Sat, 13 Jun 2009 13:04:12 +0200
X-Mailer: git-send-email 1.6.3.2.248.g8cb59
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1968LutlwI5dfgDzqQgkXaRLBm76lWldQKzah7U
	aAB+YdXsRAVz8PwqPkUv8/ZKahEm8TR53Ah1mYiShY7zcVtfdP
	qGTPP31INA31jfvqR4zg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121493>

This is not a variable name, so use spaces.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 src/mainview.ui |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/mainview.ui b/src/mainview.ui
index 488b909..4230020 100644
--- a/src/mainview.ui
+++ b/src/mainview.ui
@@ -680,7 +680,7 @@
      <normaloff>:/icons/resources/filter.png</normaloff>:/icons/resources/filter.png</iconset>
    </property>
    <property name="text">
-    <string>searchAndFilter</string>
+    <string>Search and filter</string>
    </property>
    <property name="statusTip">
     <string>Toggle filter</string>
@@ -698,7 +698,7 @@
      <normaloff>:/icons/resources/find.png</normaloff>:/icons/resources/find.png</iconset>
    </property>
    <property name="text">
-    <string>searchAndHighlight</string>
+    <string>Search and highlight</string>
    </property>
    <property name="statusTip">
     <string>Toggle match highlight</string>
-- 
1.6.3.2.248.g8cb59
