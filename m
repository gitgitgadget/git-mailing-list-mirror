From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Changed to use more Eclipse-oriented naming
Date: Sat, 18 Apr 2009 22:23:11 +0200
Message-ID: <1240086192-20325-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Alex Blewitt <alex.blewitt@gmail.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Apr 18 22:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvH5k-0005TL-Ie
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 22:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbZDRUXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 16:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbZDRUXR
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 16:23:17 -0400
Received: from mail.dewire.com ([83.140.172.130]:16258 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654AbZDRUXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 16:23:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F39AB149164D;
	Sat, 18 Apr 2009 22:23:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MVQaRzHKHyAT; Sat, 18 Apr 2009 22:23:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6897E1491629;
	Sat, 18 Apr 2009 22:23:14 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116863>

From: Alex Blewitt <alex.blewitt@gmail.com>


Signed-off-by: Alex Blewitt <alex.blewitt@gmail.com>
---
 org.spearce.egit.ui/plugin.properties |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Shawn: I think these are fine, so I'll push them soon.

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.ui/plugin.properties
index 0627a62..7748770 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -16,10 +16,10 @@ DisconnectAction_tooltip=Disconnect the Git team provider.
 AssumeUnchangedAction_label=Assume unchanged
 AssumeUnchangedAction_tooltip=Assume selected folders/files are unchanged
 
-TrackAction_label=Track (&Add)
+TrackAction_label=&Add to Version Control
 TrackAction_tooltip=Track selected files/folders with Git.
 
-UntrackAction_label=Untrack (Remove)
+UntrackAction_label=&Remove from Version Control
 UntrackAction_tooltip=Stop tracking selected files/folders with Git.
 
 UpdateAction_label=Update Index (Refresh)
-- 
1.6.2.2
