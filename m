From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Fix git-gc usage note
Date: Sat,  3 Mar 2007 18:28:14 +0100
Message-ID: <11729428941652-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Mar 03 18:35:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNY8U-00005x-HF
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 18:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030696AbXCCRfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 12:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030695AbXCCRfG
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 12:35:06 -0500
Received: from mail17.bluewin.ch ([195.186.18.64]:61434 "EHLO
	mail17.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030696AbXCCRfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 12:35:05 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Mar 2007 12:35:05 EST
Received: from spinlock.ch (83.79.116.217) by mail17.bluewin.ch (Bluewin 7.3.121)
        id 45C31E1C0087C036; Sat, 3 Mar 2007 17:28:20 +0000
Received: (nullmailer pid 17424 invoked by uid 1000);
	Sat, 03 Mar 2007 17:28:14 -0000
X-Mailer: git-send-email 1.5.0.2.844.gcba8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41305>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 git-gc.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gc.sh b/git-gc.sh
index 1a45de5..436d7ca 100755
--- a/git-gc.sh
+++ b/git-gc.sh
@@ -4,7 +4,7 @@
 #
 # Cleanup unreachable files and optimize the repository.
 
-USAGE='git-gc [--prune]'
+USAGE='[--prune]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
-- 
1.5.0.2.844.gcba8
