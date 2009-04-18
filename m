From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Commit brings up a dialog, so use ... on the end to indicate this
Date: Sat, 18 Apr 2009 22:23:12 +0200
Message-ID: <1240086192-20325-2-git-send-email-robin.rosenberg@dewire.com>
References: <1240086192-20325-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Alex Blewitt <alex.blewitt@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Apr 18 22:25:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvH6k-0005ks-GI
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 22:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526AbZDRUXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 16:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755158AbZDRUXV
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 16:23:21 -0400
Received: from mail.dewire.com ([83.140.172.130]:16267 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806AbZDRUXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 16:23:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 268B41491640;
	Sat, 18 Apr 2009 22:23:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fe1mQpQGv1yQ; Sat, 18 Apr 2009 22:23:18 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id A51711491629;
	Sat, 18 Apr 2009 22:23:18 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1240086192-20325-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116864>

From: Alex Blewitt <alex.blewitt@gmail.com>


Signed-off-by: Alex Blewitt <alex.blewitt@gmail.com>
---
 org.spearce.egit.ui/plugin.properties |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.ui/plugin.properties
index 7748770..26b1516 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -37,7 +37,7 @@ CompareWithIndexAction_tooltip=Compare with Git's index version
 ShowResourceInHistoryAction_label=Show in Resource History
 ShowResourceInHistoryAction_tooltip=Show selected files in the resource history view.
 
-CommitAction_label=&Commit
+CommitAction_label=&Commit...
 CommitAction_tooltip=Commit changes to your current branch
 
 ResetAction_label=&Reset To...
-- 
1.6.2.2
