From: bfields@fieldses.org
Subject: [PATCH 3/5] Documentation: retitle the git-core tutorial
Date: Mon, 29 May 2006 19:31:34 -0400
Message-ID: <11489454963995-git-send-email-bfields@fieldses.org>
References: <1148945496592-git-send-email-bfields@fieldses.org>
Reply-To: bfields@fieldses.org
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 01:32:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkrDo-0001hS-J4
	for gcvg-git@gmane.org; Tue, 30 May 2006 01:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWE2XcU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 19:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWE2XcT
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 19:32:19 -0400
Received: from c-68-40-201-198.hsd1.mi.comcast.net ([68.40.201.198]:20650 "EHLO
	puzzle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751256AbWE2XcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 19:32:19 -0400
Received: from bfields by puzzle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1FkrCy-0005Ky-PO; Mon, 29 May 2006 19:31:36 -0400
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.3.g2506
In-Reply-To: <1148945496592-git-send-email-bfields@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20996>

From: J. Bruce Fields <bfields@citi.umich.edu>

Give the git-core tutorial a name that better reflects its intended
audience.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

cbec3d5696e6c9fa5a44046e1cd1c870681c6897
 Documentation/core-tutorial.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

cbec3d5696e6c9fa5a44046e1cd1c870681c6897
diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index d1360ec..5a831ad 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -1,5 +1,5 @@
-A short git tutorial
-====================
+A git core tutorial for developers
+==================================
 
 Introduction
 ------------
-- 
1.3.3.gff62
